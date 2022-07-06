// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "../libraries/Ownable.sol";
import "../libraries/Helper.sol";
import "hardhat/console.sol";

contract StakingPool is Ownable, ReentrancyGuard {
    
    using Counters for Counters.Counter;

    event TokenStaked(address staker, uint256 stakeAmount, uint256 withdrawableTime);
    event TokenUnstaked(address unstaker, uint256 unStakeAmount);
    event LockTimeUpdated(uint256 lockTime);
    event RewardWithdraw(address staker, uint256 rewardAmount);
    event RewardAdded(uint256 totalRewardAmount, uint256 rewardAmount);

    struct UserInfo {
        uint256 stakeAmount;     // staking amount per staker
        uint256 withdrawableTime;// last staked time(here, means the time that staker withdrawable time)
        uint256 rewardTime;// last staked time(here, means the time that staker withdrawable time)
    }

    IERC20 private immutable PAYOUT_TOKEN;// VAB token   
    address private immutable VOTE;       // vote contract address
    
    uint256 public lockPeriod;           // lock period for staked VAB
    uint256 public rewardRate;           // 1% = 10**4, 100% = 10**6
    uint256 public totalStakingAmount;   // 
    uint256 public totalRewardAmount;    // 

    mapping(address => UserInfo) public userInfo;

    Counters.Counter public stakerCount;   // count of stakers is from No.1

    modifier onlyVote() {
        require(msg.sender == VOTE, "caller is not the vote contract");
        _;
    }

    constructor(
        address _payoutToken,
        address _voteContract
    ) {
        require(_payoutToken != address(0), "_payoutToken: Zero address");
        PAYOUT_TOKEN = IERC20(_payoutToken);
        require(_voteContract != address(0), "_voteContract: ZERO address");
        VOTE = _voteContract;

        lockPeriod = 30 days;
        rewardRate = 4; // 0.0004% (1% = 10**4, 100%=10**6)
    }

    /// @notice Add reward token(VAB)
    function addRewardToPool(uint256 _amount) external {
        require(_amount > 0, 'addRewardToPool: Zero amount');

        Helper.safeTransferFrom(address(PAYOUT_TOKEN), msg.sender, address(this), _amount);
        totalRewardAmount += _amount;

        emit RewardAdded(totalRewardAmount, _amount);
    }    

    /// @notice Staking VAB token by staker
    function stakeToken(uint256 _amount) public nonReentrant {
        require(msg.sender != address(0), "stakeToken: Zero address");
        require(_amount > 0, "stakeToken: Zero amount");

        Helper.safeTransferFrom(address(PAYOUT_TOKEN), msg.sender, address(this), _amount);

        if(userInfo[msg.sender].stakeAmount == 0 && userInfo[msg.sender].withdrawableTime == 0) {
            stakerCount.increment();
        }
        userInfo[msg.sender].stakeAmount += _amount;
        userInfo[msg.sender].withdrawableTime = block.timestamp + lockPeriod;
        userInfo[msg.sender].rewardTime = block.timestamp;

        totalStakingAmount += _amount;

        emit TokenStaked(msg.sender, _amount, block.timestamp + lockPeriod);
    }

    /// @dev Allows user to unstake tokens after the correct time period has elapsed
    function unstakeToken(uint256 _amount) external nonReentrant {

        require(msg.sender != address(0), "unstakeToken: Zero staker address");
        require(userInfo[msg.sender].stakeAmount >= _amount, "unstakeToken: Insufficient stake token amount");
        console.log("sol=>withdrawTime in unstaking::", userInfo[msg.sender].withdrawableTime);
        require(
            block.timestamp >= userInfo[msg.sender].withdrawableTime, "unstakeToken: Token locked yet"
        );

        // first, withdraw reward
        uint256 rewardAmount = __calcRewardAmount();
        if(totalRewardAmount >= rewardAmount) {
            __withdrawReward(rewardAmount);
        }

        // Todo should check if we consider reward amount here or not
        Helper.safeTransfer(address(PAYOUT_TOKEN), msg.sender, _amount);        
        userInfo[msg.sender].stakeAmount -= _amount;

        totalStakingAmount -= _amount;

        emit TokenUnstaked(msg.sender, _amount);
    }

    /// @notice Withdraw reward
    function withdrawReward() external {
        require(msg.sender != address(0), "withdrawReward: Zero staker address");
        require(userInfo[msg.sender].stakeAmount > 0, "withdrawReward: Zero staking amount");
        require(block.timestamp - userInfo[msg.sender].rewardTime > lockPeriod, "withdrawReward: lock period yet");

        uint256 rewardAmount = __calcRewardAmount();
        require(totalRewardAmount >= rewardAmount, "withdrawReward: Insufficient total reward amount");

        __withdrawReward(rewardAmount);
    }

    /// @dev Calculate reward amount
    function __calcRewardAmount() private view returns (uint256 amount_) {
        // Get time with accuracy(10**4) from after lockPeriod 
        uint256 timeVal = (block.timestamp - userInfo[msg.sender].rewardTime) * 10**4 / lockPeriod;
        amount_ = userInfo[msg.sender].stakeAmount * timeVal * rewardRate / 10**6 / 10**4;
    }

    /// @dev Transfer reward amount
    function __withdrawReward(uint256 _amount) private {
        Helper.safeTransfer(address(PAYOUT_TOKEN), msg.sender, _amount);
        userInfo[msg.sender].rewardTime = block.timestamp;
        totalRewardAmount -= _amount;

        emit RewardWithdraw(msg.sender, _amount);
    }

    /// @notice Update lastStakedTime for a staker when vote
    function updateWithdrawableTime(address _user, uint256 _time) external onlyVote {
        userInfo[_user].withdrawableTime = _time;
    }

    /// @notice Update reward rate by auditor
    function updateRewardRate(uint256 _rate) external onlyAuditor {
        require(_rate > 0 && rewardRate != _rate, "updateRewardRate: not allow rate");
        rewardRate = _rate;
    }

    /// @notice Update lock time(in second) by auditor
    function updateLockPeriod(uint256 _lockPeriod) external onlyAuditor {
        require(_lockPeriod > 0, "updateLockPeriod: not allow zero lock period");
        lockPeriod = _lockPeriod;
        emit LockTimeUpdated(_lockPeriod);
    }

    /// @notice Get staking amount for a staker
    function getStakeAmount(address _user) external view returns(uint256 amount_) {
        amount_ = userInfo[_user].stakeAmount;
    }

    /// @notice Get withdrawableTime for a staker
    function getWithdrawableTime(address _user) external view returns(uint256 time_) {
        time_ = userInfo[_user].withdrawableTime;
    }    
}