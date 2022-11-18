// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "../libraries/Helper.sol";
import "../interfaces/IUniHelper.sol";
import "../interfaces/IStakingPool.sol";
import "../interfaces/IProperty.sol";
import "../interfaces/IOwnablee.sol";
import "hardhat/console.sol";

contract VabbleDAO is ReentrancyGuard {
    using Counters for Counters.Counter;
    
    event FilmsProposalCreated(uint256[] indexed filmIds, address studio);
    event FilmApproved(uint256 filmId);
    event FilmsFinalSet(uint256[] filmIds);
    event FilmsMultiUpdated(uint256[] indexed filmIds, address studio);
    event DepositedTokenToFilm(address customer, address token, uint256 amount, uint256 filmId);
    event VABDeposited(address customer, uint256 amount);
    event WithdrawVABTransferred(address customer, address token, uint256 amount);
    event WithdrawPending(address customer, address token, uint256 amount);    
    event MinMaxDepositAmountUpdated(uint256 minAmount, uint256 maxAmount);
    event FundPeriodUpdated(uint256 filmId, uint256 fundPeriod);
    event FundFeePercentUpdated(uint256 fundFeePercent);
    event ProposalFeeAmountUpdated(uint256 proposalFeeAmount);
    event FundProcessed(uint256 filmId);

    struct UserRent {
        uint256 vabAmount;       // current VAB amount in DAO
        uint256 withdrawAmount;  // pending withdraw amount for a customer
        bool pending;            // pending status for withdraw
    }

    struct Asset {
        address token;   // token address
        uint256 amount;  // token amount
    }

    struct Film {
        address[] studioPayees; // addresses who studio define to pay revenue
        uint256[] sharePercents;// percents(1% = 1e8) that studio defines to pay revenue for each payee
        uint256 rentPrice;      // VAB amount that a customer rents a film
        uint256 raiseAmount;    // USDC amount(in cash) studio are seeking to raise for the film. if 0, this film is not for funding
        uint256 fundPeriod;     // how many days(ex: 20 days) to keep the funding pool open
        uint256 fundStart;      // time(block.timestamp) that film approved for raising fund
        uint256 pCreateTime; // proposal created time(block.timestamp) by studio
        address studio;         // address of studio who is admin of film 
        bool onlyAllowVAB;      // if onlyVAB is true, customer can deposit only VAB token for this film
        Helper.Status status;   // status of film
    }
  
    address public immutable OWNABLE;         // Ownablee contract address
    address public immutable VOTE;            // Vote contract address
    address public immutable STAKING_POOL;    // StakingPool contract address
    address public immutable UNI_HELPER;      // UniHelper contract address
    address public immutable DAO_PROPERTY;
    
    uint256[] private proposalFilmIds;    
    uint256[] private updatedFilmIds;    
    uint256[] private finalFilmIds;
    uint256[] private approvedFundingFilmIds;
    uint256[] private approvedListingFilmIds;
    uint256[] private fundProcessedFilmIds;
    
    mapping(uint256 => Film) private filmInfo;             // Each film information(filmId => Film)
    mapping(address => UserRent) public userRentInfo;
    mapping(uint256 => Asset[]) public assetPerFilm;                  // (filmId => Asset[token, amount])
    mapping(uint256 => mapping(address => Asset[])) public assetInfo; // (filmId => (customer => Asset[token, amount]))
    mapping(uint256 => address[]) private investorList;       // (filmId => investor address[])
    mapping(address => uint256[]) private userInvestFilmIds;  // (user => invest filmId[]) for only approved_funding films
    mapping(address => uint256) public userFilmProposalCount; // (user => created film-proposal count)
    
    Counters.Counter public filmCount;          // filmId is from No.1

    modifier onlyVote() {
        require(msg.sender == VOTE, "caller is not the vote contract");
        _;
    }
    modifier onlyAuditor() {
        require(msg.sender == IOwnablee(OWNABLE).auditor(), "caller is not the auditor");
        _;
    }    
    modifier onlyStudio() {
        require(IOwnablee(OWNABLE).isStudio(msg.sender), "caller is not the studio");
        _;
    }

    receive() external payable {}

    constructor(
        address _ownableContract,
        address _voteContract,
        address _stakingContract,
        address _uniHelperContract,
        address _daoProperty
    ) {        
        require(_ownableContract != address(0), "ownableContract: Zero address");
        OWNABLE = _ownableContract;     
        require(_voteContract != address(0), "voteContract: Zero address");
        VOTE = _voteContract;
        require(_stakingContract != address(0), "stakingContract: Zero address");
        STAKING_POOL = _stakingContract;
        require(_uniHelperContract != address(0), "uniHelperContract: Zero address");
        UNI_HELPER = _uniHelperContract;      
        require(_daoProperty != address(0), "daoProperty: Zero address");
        DAO_PROPERTY = _daoProperty; 
    }

    // ======================== Film proposal ==============================
    /// @notice Create a proposal with rentPrice and raise amount for multiple films by studio
    // if raiseAmount > 0 then it is for funding and if raiseAmount = 0 then it is for listing
    // Creator(Studio) should pay VAB as fee
    function createProposalFilms(
        bytes[] calldata _proposalFilms,
        bool _noVote
    ) external onlyStudio nonReentrant {        
        require(_proposalFilms.length > 0, "createProposalFilms: Invalid films length");         
        require(__isPaidFee(_noVote), 'createProposalFilms: Not paid fee');

        for(uint256 i = 0; i < _proposalFilms.length; i++) { 
            proposalFilmIds.push(__proposalFilm(_proposalFilms[i])); 
        }        
        emit FilmsProposalCreated(proposalFilmIds, msg.sender);        
    }

    /// @notice Check if proposal fee transferred from studio to stakingPool
    // Get expected VAB amount from UniswapV2 and then Transfer VAB: user(studio) -> stakingPool.
    function __isPaidFee(bool _noVote) private returns(bool) {    
        uint256 depositAmount = IProperty(DAO_PROPERTY).proposalFeeAmount();
        if(_noVote) depositAmount = IProperty(DAO_PROPERTY).proposalFeeAmount() * 2;

        address payout_token = IProperty(DAO_PROPERTY).PAYOUT_TOKEN();
        uint256 expectVABAmount = IUniHelper(UNI_HELPER).expectedAmount(depositAmount, IProperty(DAO_PROPERTY).USDC_TOKEN(), payout_token);
        
        if(expectVABAmount > 0) {
            Helper.safeTransferFrom(payout_token, msg.sender, address(this), expectVABAmount);
            if(IERC20(payout_token).allowance(address(this), STAKING_POOL) == 0) {
                Helper.safeApprove(payout_token, STAKING_POOL, IERC20(payout_token).totalSupply());
            }  
            IStakingPool(STAKING_POOL).addRewardToPool(expectVABAmount);
            return true;
        } else {
            return false;
        }
    } 
    /// @dev Create a Proposal for a film
    function __proposalFilm(
        bytes calldata _proposalFilm
    ) private returns(uint256) {
        (
            uint256 _rentPrice,
            uint256 _raiseAmount,
            uint256 _fundPeriod,
            bool _onlyAllowVAB
        ) = abi.decode(_proposalFilm, (uint256, uint256, uint256, bool));

        filmCount.increment();
        uint256 filmId = filmCount.current();

        Film storage _filmInfo = filmInfo[filmId];
        _filmInfo.rentPrice = _rentPrice;
        _filmInfo.raiseAmount = _raiseAmount;
        _filmInfo.fundPeriod = _fundPeriod;
        _filmInfo.pCreateTime = block.timestamp;
        _filmInfo.studio = msg.sender;
        _filmInfo.onlyAllowVAB = _onlyAllowVAB;
        _filmInfo.status = Helper.Status.LISTED;
     
        userFilmProposalCount[msg.sender] += 1;
        // If proposal is for fund, update "lastfundProposalCreateTime"
        if(_raiseAmount > 0) IStakingPool(STAKING_POOL).updateLastfundProposalCreateTime(block.timestamp);

        return filmId;
    }

    /// @notice Update multi films with param(payee and share %) after LISTED by studio
    function updateMultiFilms(
        bytes[] calldata _updateFilms
    ) external onlyStudio nonReentrant {
        require(_updateFilms.length > 0, "updateMultiFilms: Invalid item length");

        for(uint256 i = 0; i < _updateFilms.length; i++) {        
            (
                uint256 filmId_, 
                uint256[] memory sharePercents_, 
                address[] memory studioPayees_
            ) = abi.decode(_updateFilms[i], (uint256, uint256[], address[]));

            Film storage _filmInfo = filmInfo[filmId_];
            if(_filmInfo.status == Helper.Status.LISTED && _filmInfo.studio == msg.sender) {
                _filmInfo.studioPayees = studioPayees_;   
                _filmInfo.sharePercents = sharePercents_;   

                updatedFilmIds.push(filmId_);
            }
        }   
        emit FilmsMultiUpdated(updatedFilmIds, msg.sender);
    }

    /// @notice Approve a film for funding/listing from vote contract
    // For film with APPROVED_FUNDING, set up fundStart(current block timestamp)
    function approveFilm(uint256 _filmId, bool _isFund) external onlyVote {
        require(_filmId > 0, "ApproveFilm: Invalid filmId"); 

        if(_isFund) {
            filmInfo[_filmId].status = Helper.Status.APPROVED_FUNDING;
            filmInfo[_filmId].fundStart = block.timestamp;
            approvedFundingFilmIds.push(_filmId);
        } else {
            filmInfo[_filmId].status = Helper.Status.APPROVED_LISTING;    
            approvedListingFilmIds.push(_filmId);
        }        
        emit FilmApproved(_filmId);
    }

    /// @notice Set final films with watched percents by Auditor
    function setFinalFilms(
        bytes[] calldata _finalFilms
    ) external onlyAuditor nonReentrant {
        require(_finalFilms.length > 0, "finalSetFilms: Bad items length");
        
        for(uint256 i = 0; i < _finalFilms.length; i++) {
            __setFinalFilm(_finalFilms[i]);
        }
        emit FilmsFinalSet(finalFilmIds);
    }

    /// @dev Set final films for a customer with watched percents
    function __setFinalFilm(        
        bytes calldata _filmData
    ) private {
        (   
            address customer_,
            uint256[] memory filmIds_,
            uint256[] memory watchPercents_
        ) = abi.decode(_filmData, (address, uint256[], uint256[]));

        require(customer_ != address(0), "_setFinalFilm: Zero customer address");
        require(userRentInfo[customer_].vabAmount > 0, "_setFinalFilm: Zero balance");
        require(filmIds_.length == watchPercents_.length, "_setFinalFilm: Invalid items length");

        // Assgin the VAB token to payees based on share(%) and watch(%)
        for(uint256 i = 0; i < filmIds_.length; i++) {
            // Todo should check again with APPROVED_LISTING
            if(filmInfo[filmIds_[i]].status == Helper.Status.APPROVED_LISTING || filmInfo[filmIds_[i]].status == Helper.Status.APPROVED_WITHOUTVOTE) { 
                uint256 payout = __getPayoutFor(filmIds_[i], watchPercents_[i]);
                if(payout > 0 && userRentInfo[customer_].vabAmount >= payout) {
                    userRentInfo[customer_].vabAmount -= payout; 

                    for(uint256 k = 0; k < filmInfo[filmIds_[i]].studioPayees.length; k++) {
                        userRentInfo[filmInfo[filmIds_[i]].studioPayees[k]].vabAmount += __getShareAmount(payout, filmIds_[i], k);
                    }

                    finalFilmIds.push(filmIds_[i]);
                }                
            } else if(filmInfo[filmIds_[i]].status == Helper.Status.APPROVED_FUNDING) {
                // Todo should change the films status from APPROVED_FUNDING to APPROVED_LISTING
                filmInfo[filmIds_[i]].status == Helper.Status.APPROVED_LISTING;
            }
        }   
    }  

    // =================== Funding(Launch Pad) START ===============================
    /// @notice Deposit tokens(VAB, USDT, USDC)/native token($50 ~ $5000 per address for a film) to only funding film by customer(investor)
    function depositToFilm(uint256 _filmId, address _token, uint256 _amount) external payable nonReentrant {
        require(msg.sender != address(0) && _amount > 0, "depositToFilm: Zero value");
        require(filmInfo[_filmId].status == Helper.Status.APPROVED_FUNDING, "depositToFilm: filmId not approved for funding");
        require(filmInfo[_filmId].fundPeriod >= block.timestamp - filmInfo[_filmId].fundStart, "depositToFilm: passed funding period");
        require(IOwnablee(OWNABLE).isDepositAsset(_token), "depositToFilm: not allowed asset");    

        if(filmInfo[_filmId].onlyAllowVAB) {
            require(_token == IProperty(DAO_PROPERTY).PAYOUT_TOKEN(), "depositToFilm: Allowed only VAB token");            
        } 
        require(__checkMinMaxAmount(_filmId, _token, _amount), "depositToFilm: Invalid amount");

        if(getUserFundAmountPerFilm(msg.sender, _filmId) == 0) {
            investorList[_filmId].push(msg.sender);            
            userInvestFilmIds[msg.sender].push(_filmId);
        }
        // Return remain ETH to user back if case of ETH
        if(_token == address(0)) {
            require(msg.value >= _amount, "depositToFilm: Insufficient paid");
            if (msg.value > _amount) {
                Helper.safeTransferETH(msg.sender, msg.value - _amount);
            }
        }
        
        if(_token != address(0)) {
            Helper.safeTransferFrom(_token, msg.sender, address(this), _amount);
        }            
        __assignToken(_filmId, _token, _amount);

        emit DepositedTokenToFilm(msg.sender, _token, _amount, _filmId);
    }    

    /// @dev Update/Add user fund amount
    function __assignToken(uint256 _filmId, address _token, uint256 _amount) private {
        bool isNewTokenPerUser = true;
        bool isNewTokenPerFilm = true;

        // update token amount
        for(uint256 i = 0; i < assetInfo[_filmId][msg.sender].length; i++) {
            if(_token == assetInfo[_filmId][msg.sender][i].token) {
                assetInfo[_filmId][msg.sender][i].amount += _amount;
                isNewTokenPerUser = false;
            }
        }
        // add new token
        if(isNewTokenPerUser) {
            assetInfo[_filmId][msg.sender].push(Asset({token: _token, amount: _amount}));
        }
        
        for(uint256 i = 0; i < assetPerFilm[_filmId].length; i++) {
            if(_token == assetPerFilm[_filmId][i].token) {
                assetPerFilm[_filmId][i].amount += _amount;
                isNewTokenPerFilm = false;
            }
        }
        if(isNewTokenPerFilm) {
            assetPerFilm[_filmId].push(Asset({token: _token, amount: _amount}));
        }
    }
    
    /// @notice Send the 2% of funds to reward pool in VAB if funding meet the raise amount after fund period
    function fundProcess(uint256 _filmId) external onlyStudio nonReentrant {
        require(filmInfo[_filmId].studio == msg.sender, "fundProcess: Bad studio of this film");
        require(filmInfo[_filmId].status == Helper.Status.APPROVED_FUNDING, "fundProcess: filmId not approved for funding");
        require(filmInfo[_filmId].fundPeriod < block.timestamp - filmInfo[_filmId].fundStart, "fundProcess: funding period");

        require(isRaisedFullAmount(_filmId), "fundProcess: fails to meet raise amount");
                        
        // TODO send fundFeePercent(2%) to reward pool as VAB token and rest send to studio
        address payout_token = IProperty(DAO_PROPERTY).PAYOUT_TOKEN();
        Asset[] storage assetArr = assetPerFilm[_filmId];
        uint256 rewardSumAmount;
        uint256 rewardAmount;
        for(uint256 i = 0; i < assetArr.length; i++) {                
            rewardAmount = assetArr[i].amount * IProperty(DAO_PROPERTY).fundFeePercent() / 1e10;
            if(payout_token == assetArr[i].token) {
                rewardSumAmount += rewardAmount;
            } else {
                if(IERC20(assetArr[i].token).allowance(address(this), UNI_HELPER) == 0) {
                    Helper.safeApprove(assetArr[i].token, UNI_HELPER, IERC20(assetArr[i].token).totalSupply());
                }
                bytes memory swapArgs = abi.encode(rewardAmount, assetArr[i].token, payout_token);
                rewardSumAmount += IUniHelper(UNI_HELPER).swapAsset(swapArgs);
            }
            Helper.safeTransfer(assetArr[i].token, msg.sender, (assetArr[i].amount - rewardAmount));
            assetArr[i].amount = 0;
        }

        if(rewardSumAmount > 0) {
            if(IERC20(payout_token).allowance(address(this), STAKING_POOL) == 0) {
                Helper.safeApprove(payout_token, STAKING_POOL, IERC20(payout_token).totalSupply());
            }        
            IStakingPool(STAKING_POOL).addRewardToPool(rewardSumAmount);
        }

        fundProcessedFilmIds.push(_filmId);

        emit FundProcessed(_filmId);
    }

    /// @notice Investor can withdraw fund after fund period if funding fails to meet the raise amount
    function withdrawFunding(uint256 _filmId) external nonReentrant {     
        require(filmInfo[_filmId].status == Helper.Status.APPROVED_FUNDING, "withdrawFunding: filmId not approved for funding");
        require(filmInfo[_filmId].fundPeriod < block.timestamp - filmInfo[_filmId].fundStart, "withdrawFunding: funding period");

        require(!isRaisedFullAmount(_filmId), "withdrawFunding: satisfied raise amount");

        Asset[] memory assetArr = assetInfo[_filmId][msg.sender];
        for(uint256 i = 0; i < assetArr.length; i++) {   
            if(assetArr[i].token == address(0)) {
                if(address(this).balance >= assetArr[i].amount) {
                    Helper.safeTransferETH(msg.sender, assetArr[i].amount);
                }                
            } else {
                if(IERC20(assetArr[i].token).balanceOf(address(this)) >= assetArr[i].amount) {
                    Helper.safeTransfer(assetArr[i].token, msg.sender, assetArr[i].amount);    
                }
            }
        }
    }

    /// @notice Check if fund meet raise amount
    function isRaisedFullAmount(uint256 _filmId) public view returns (bool) {
        uint256 raisedAmount = getRaisedAmountPerFilm(_filmId);
        if(raisedAmount > 0 && raisedAmount >= filmInfo[_filmId].raiseAmount) {
            return true;
        } else {
            return false;
        }
    }

    // =================== Customer deposit/withdraw VAB START =================    
    /// @notice Deposit VAB token from customer for renting the films
    function depositVAB(uint256 _amount) external nonReentrant {
        require(msg.sender != address(0), "depositVAB: Zero address");
        require(_amount > 0, "depositVAB: Zero amount");

        Helper.safeTransferFrom(IProperty(DAO_PROPERTY).PAYOUT_TOKEN(), msg.sender, address(this), _amount);
        userRentInfo[msg.sender].vabAmount += _amount;

        emit VABDeposited(msg.sender, _amount);
    }

    /// @notice Pending Withdraw VAB token by customer
    function pendingWithdraw(uint256 _amount) external nonReentrant {
        require(msg.sender != address(0), "pendingWithdraw: Zero address");
        require(_amount > 0 && _amount <= userRentInfo[msg.sender].vabAmount - userRentInfo[msg.sender].withdrawAmount, "pendingWithdraw: Insufficient VAB amount");
        require(!userRentInfo[msg.sender].pending, "pendingWithdraw: already pending status");

        userRentInfo[msg.sender].withdrawAmount += _amount;
        userRentInfo[msg.sender].pending = true;

        emit WithdrawPending(msg.sender, IProperty(DAO_PROPERTY).PAYOUT_TOKEN(), _amount);
    }

    /// @notice Approve pending-withdraw of given customers by Auditor
    function approvePendingWithdraw(address[] calldata _customers) external onlyAuditor nonReentrant {
        require(_customers.length > 0, "approvePendingWithdraw: No customer");

        // Transfer withdrawable amount to _customers
        for(uint256 i = 0; i < _customers.length; i++) {
            if(
                userRentInfo[_customers[i]].withdrawAmount > 0 &&
                userRentInfo[_customers[i]].withdrawAmount <= userRentInfo[_customers[i]].vabAmount &&
                userRentInfo[_customers[i]].pending
            ) {
                __transferVABWithdraw(_customers[i]);
            }
        }
    }

    /// @dev Transfer VAB token to user's withdraw request
    function __transferVABWithdraw(address _to) private {
        uint256 payAmount = userRentInfo[_to].withdrawAmount;
        Helper.safeTransfer(IProperty(DAO_PROPERTY).PAYOUT_TOKEN(), _to, payAmount);

        userRentInfo[_to].vabAmount -= payAmount;
        userRentInfo[_to].withdrawAmount = 0;
        userRentInfo[_to].pending = false;

        emit WithdrawVABTransferred(_to, IProperty(DAO_PROPERTY).PAYOUT_TOKEN(), payAmount);
    }

    /// @notice Deny pending-withdraw of given customers by Auditor
    function denyPendingWithdraw(address[] calldata _customers) external onlyAuditor nonReentrant {
        require(_customers.length > 0, "denyPendingWithdraw: No customer");

        // Release withdrawable amount for _customers
        for(uint256 i = 0; i < _customers.length; i++) {
            if(userRentInfo[_customers[i]].withdrawAmount > 0 && userRentInfo[_customers[i]].pending) {
                userRentInfo[_customers[i]].withdrawAmount = 0;
                userRentInfo[_customers[i]].pending = false;
            }
        }
    }  

    /// @notice Update fundPeriod only by studio that created the proposal
    function updateFundPeriod(uint256 _filmId, uint256 _fundPeriod) external onlyStudio nonReentrant {
        require(msg.sender == filmInfo[_filmId].studio, "updatefundPeriod: Invalid film owner");
        require(_fundPeriod > 0, "updatefundPeriod: Invalid fundPeriod");   

        filmInfo[_filmId].fundPeriod = _fundPeriod;
        
        emit FundPeriodUpdated(_filmId, _fundPeriod);
    }    

    /// @dev Get payout amount based on watched percent for a film
    function __getPayoutFor(uint256 _filmId, uint256 _watchPercent) private view returns(uint256) {
        return filmInfo[_filmId].rentPrice * _watchPercent / 1e10;
    }

    /// @dev For transferring to Studio, Get share amount based on share percent
    function __getShareAmount(uint256 _payout, uint256 _filmId, uint256 _k) private view returns(uint256) {
        return _payout * filmInfo[_filmId].sharePercents[_k] / 1e10;
    }

    /// @dev Check min & max amount for each token/ETH per film
    function __checkMinMaxAmount(uint256 _filmId, address _token, uint256 _amount) private view returns (bool passed_) {
        uint256 userFundAmountPerFilm = getUserFundAmountPerFilm(msg.sender, _filmId);
        uint256 fundAmount = IUniHelper(UNI_HELPER).expectedAmount(_amount, _token, IProperty(DAO_PROPERTY).USDC_TOKEN());    
        uint256 amountOfUser = userFundAmountPerFilm + fundAmount;
        if(amountOfUser >= IProperty(DAO_PROPERTY).minDepositAmount() && amountOfUser <= IProperty(DAO_PROPERTY).maxDepositAmount()) {
            passed_ = true;
        } else {
            passed_ = false;
        } 
    }

    /// @notice Get user fund amount in cash(usdc) for each token per film
    function getUserFundAmountPerFilm(address _customer, uint256 _filmId) public view returns (uint256 amount_) {
        address usdc_token = IProperty(DAO_PROPERTY).USDC_TOKEN();
        Asset[] memory assetArr = assetInfo[_filmId][_customer];
        for(uint256 i = 0; i < assetArr.length; i++) {
            if(assetArr[i].amount == 0) continue;

            if(assetArr[i].token == usdc_token) {
                amount_ += assetArr[i].amount;
            } else {
                amount_ += IUniHelper(UNI_HELPER).expectedAmount(assetArr[i].amount, assetArr[i].token, usdc_token);
            }
        }
    }

    /// @notice Get fund amount in cash(usdc) per film
    function getRaisedAmountPerFilm(uint256 _filmId) public view returns (uint256 amount_) {
        address usdc_token = IProperty(DAO_PROPERTY).USDC_TOKEN();
        Asset[] memory assetArr = assetPerFilm[_filmId];
        for(uint256 i = 0; i < assetArr.length; i++) {
            if(assetArr[i].amount == 0) continue;

            if(assetArr[i].token == usdc_token) {
                amount_ += assetArr[i].amount;
            } else {
                amount_ += IUniHelper(UNI_HELPER).expectedAmount(assetArr[i].amount, assetArr[i].token, usdc_token);
            }
        }
    }

    // =================== View functions =====================
    /// @notice Check user balance(VAB token amount) in DAO if enough for rent or not
    function checkUserVABAmount(address _user, uint256[] calldata _filmIds) public view returns(bool) {
        uint256 totalRentPrice = 0;
        for(uint256 i = 0; i < _filmIds.length; i++) {
            totalRentPrice += filmInfo[_filmIds[i]].rentPrice;
        }        

        if(userRentInfo[_user].vabAmount > totalRentPrice) return true;
        return false;
    }

    /// @notice Get film item based on filmId
    function getFilmById(uint256 _filmId) external view 
    returns (
        address[] memory studioPayees_, 
        uint256[] memory sharePercents_, 
        uint256 rentPrice_,
        uint256 raiseAmount_,
        uint256 fundPeriod_,
        uint256 fundStart_,
        uint256 pCreateTime_,
        address studio_,
        bool onlyAllowVAB_,
        Helper.Status status_
    ) {
        Film storage _filmInfo = filmInfo[_filmId];
        studioPayees_ = _filmInfo.studioPayees;
        sharePercents_ = _filmInfo.sharePercents;
        rentPrice_ = _filmInfo.rentPrice;
        raiseAmount_ = _filmInfo.raiseAmount;
        fundPeriod_ = _filmInfo.fundPeriod;
        fundStart_ = _filmInfo.fundStart;
        pCreateTime_ = _filmInfo.pCreateTime;
        studio_ = _filmInfo.studio;
        onlyAllowVAB_ = _filmInfo.onlyAllowVAB;
        status_ = _filmInfo.status;
    }

    /// @notice Get film item based on Id
    function getFilmStatusById(uint256 _filmId) external view returns (Helper.Status status_) {
        status_ = filmInfo[_filmId].status;
    }

    /// @notice Check if film is for fund or list
    function isForFund(uint256 _filmId) external view returns (bool isFund_) {
        if(filmInfo[_filmId].raiseAmount > 0) isFund_ = true;
        else isFund_ = false;
    }

    /// @notice Get proposal/updated/approvedFunding/approvedListing/fundProcessed/final film Ids
    function getFilmIds(uint256 _flag) external view returns (uint256[] memory) {
        if(_flag == 1) return proposalFilmIds;
        else if(_flag == 2) return updatedFilmIds;
        else if(_flag == 3) return approvedFundingFilmIds;
        else if(_flag == 4) return approvedListingFilmIds;
        else if(_flag == 5) return fundProcessedFilmIds;        
        else return finalFilmIds;
    }  

    /// @notice Get investor list per film Id
    function getInvestorList(uint256 _filmId) external view returns (address[] memory) {
        return investorList[_filmId];
    }

    /// @notice Get investor film list
    function getUserInvestFilmIds(address _user) external view returns (uint256[] memory) {
        return userInvestFilmIds[_user];
    }
}
