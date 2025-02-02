**THIS CHECKLIST IS NOT COMPLETE**. Use `--show-ignored-findings` to show all the results.
Summary
 - [arbitrary-send-eth](#arbitrary-send-eth) (1 results) (High)
 - [encode-packed-collision](#encode-packed-collision) (1 results) (High)
 - [incorrect-exp](#incorrect-exp) (1 results) (High)
 - [divide-before-multiply](#divide-before-multiply) (16 results) (Medium)
 - [incorrect-equality](#incorrect-equality) (10 results) (Medium)
 - [reentrancy-no-eth](#reentrancy-no-eth) (15 results) (Medium)
 - [tautology](#tautology) (1 results) (Medium)
 - [uninitialized-local](#uninitialized-local) (6 results) (Medium)
 - [unused-return](#unused-return) (28 results) (Medium)
 - [shadowing-local](#shadowing-local) (2 results) (Low)
 - [events-access](#events-access) (5 results) (Low)
 - [missing-zero-check](#missing-zero-check) (7 results) (Low)
 - [calls-loop](#calls-loop) (51 results) (Low)
 - [reentrancy-benign](#reentrancy-benign) (35 results) (Low)
 - [timestamp](#timestamp) (31 results) (Low)
 - [assembly](#assembly) (11 results) (Informational)
 - [costly-loop](#costly-loop) (4 results) (Informational)
 - [cyclomatic-complexity](#cyclomatic-complexity) (3 results) (Informational)
 - [dead-code](#dead-code) (13 results) (Informational)
 - [low-level-calls](#low-level-calls) (8 results) (Informational)
 - [unused-import](#unused-import) (7 results) (Informational)
 - [unused-state](#unused-state) (4 results) (Informational)
 - [cache-array-length](#cache-array-length) (1 results) (Optimization)
 - [constable-states](#constable-states) (2 results) (Optimization)
 - [immutable-states](#immutable-states) (1 results) (Optimization)
## arbitrary-send-eth
Impact: High
Confidence: Medium
 - [ ] ID-0
[UniHelper._executeSwap(uint256,address,address)](contracts/dao/UniHelper.sol#L155-L174) sends eth to arbitrary user
	Dangerous calls:
	- [IUniswapV2Router(router).swapExactETHForTokens{value: _amount}(expectedOut,path,address(this),block.timestamp + 1)[1]](contracts/dao/UniHelper.sol#L163-L165)

contracts/dao/UniHelper.sol#L155-L174


## encode-packed-collision
Impact: High
Confidence: High
 - [ ] ID-1
[VabbleNFT.tokenURI(uint256)](contracts/dao/VabbleNFT.sol#L75-L79) calls abi.encodePacked() with multiple dynamic arguments:
	- [string(abi.encodePacked(baseUri,_tokenId.toString(),.json))](contracts/dao/VabbleNFT.sol#L78)

contracts/dao/VabbleNFT.sol#L75-L79


## incorrect-exp
Impact: High
Confidence: Medium
 - [ ] ID-2
[Math.mulDiv(uint256,uint256,uint256)](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L55-L134) has bitwise-xor operator ^ instead of the exponentiation operator **: 
	 - [inverse = (3 * denominator) ^ 2](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L116)

node_modules/@openzeppelin/contracts/utils/math/Math.sol#L55-L134


## divide-before-multiply
Impact: Medium
Confidence: Medium
 - [ ] ID-3
[StakingPool.__calcRewards(address,uint256,uint256)](contracts/dao/StakingPool.sol#L454-L469) performs a multiplication on the result of a division:
	- [period = ((endTime - startTime) * 1e4) / 86400](contracts/dao/StakingPool.sol#L462)
	- [amount_ = (totalRewardAmount * rewardPercent * period) / 1e10 / 1e4](contracts/dao/StakingPool.sol#L463)

contracts/dao/StakingPool.sol#L454-L469


 - [ ] ID-4
[Math.mulDiv(uint256,uint256,uint256)](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L55-L134) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L101)
	- [inverse *= 2 - denominator * inverse](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L120)

node_modules/@openzeppelin/contracts/utils/math/Math.sol#L55-L134


 - [ ] ID-5
[StakingPool.calculateAPR(uint256,uint256,uint256,uint256,bool)](contracts/dao/StakingPool.sol#L479-L516) performs a multiplication on the result of a division:
	- [stakingRewards = (totalRewardAmount * rewardPercent * _period) / 1e10](contracts/dao/StakingPool.sol#L496)
	- [countVal = (_voteCount * 1e4) / _proposalCount](contracts/dao/StakingPool.sol#L510)
	- [pendingRewards = (stakingRewards * countVal) / 1e4](contracts/dao/StakingPool.sol#L511)

contracts/dao/StakingPool.sol#L479-L516


 - [ ] ID-6
[Math.mulDiv(uint256,uint256,uint256)](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L55-L134) performs a multiplication on the result of a division:
	- [prod0 = prod0 / twos](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L104)
	- [result = prod0 * inverse](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L131)

node_modules/@openzeppelin/contracts/utils/math/Math.sol#L55-L134


 - [ ] ID-7
[Math.mulDiv(uint256,uint256,uint256)](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L55-L134) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L101)
	- [inverse *= 2 - denominator * inverse](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L122)

node_modules/@openzeppelin/contracts/utils/math/Math.sol#L55-L134


 - [ ] ID-8
[Math.mulDiv(uint256,uint256,uint256)](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L55-L134) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L101)
	- [inverse *= 2 - denominator * inverse](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L125)

node_modules/@openzeppelin/contracts/utils/math/Math.sol#L55-L134


 - [ ] ID-9
[Math.mulDiv(uint256,uint256,uint256)](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L55-L134) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L101)
	- [inverse *= 2 - denominator * inverse](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L124)

node_modules/@openzeppelin/contracts/utils/math/Math.sol#L55-L134


 - [ ] ID-10
[Math.mulDiv(uint256,uint256,uint256)](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L55-L134) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L101)
	- [inverse *= 2 - denominator * inverse](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L123)

node_modules/@openzeppelin/contracts/utils/math/Math.sol#L55-L134


 - [ ] ID-11
[VabbleDAO.__setFinalAmountToHelpers(uint256,uint256,uint256)](contracts/dao/VabbleDAO.sol#L519-L534) performs a multiplication on the result of a division:
	- [percent = (userAmount * 1e10) / raisedAmount](contracts/dao/VabbleDAO.sol#L527)
	- [amount = (_rewardAmount * percent) / 1e10](contracts/dao/VabbleDAO.sol#L528)

contracts/dao/VabbleDAO.sol#L519-L534


 - [ ] ID-12
[StakingPool.calcRealizedRewards(address)](contracts/dao/StakingPool.sol#L388-L418) performs a multiplication on the result of a division:
	- [countRate = (vCount * 1e4) / pCount](contracts/dao/StakingPool.sol#L410)
	- [amount = (amount * countRate) / 1e4](contracts/dao/StakingPool.sol#L411)

contracts/dao/StakingPool.sol#L388-L418


 - [ ] ID-13
[Math.mulDiv(uint256,uint256,uint256)](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L55-L134) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L101)
	- [inverse *= 2 - denominator * inverse](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L121)

node_modules/@openzeppelin/contracts/utils/math/Math.sol#L55-L134


 - [ ] ID-14
[StakingPool.__rewardPercent(uint256)](contracts/dao/StakingPool.sol#L473-L476) performs a multiplication on the result of a division:
	- [poolPercent = (_stakingAmount * 1e10) / totalStakingAmount](contracts/dao/StakingPool.sol#L474)
	- [percent_ = (IProperty(DAO_PROPERTY).rewardRate() * poolPercent) / 1e10](contracts/dao/StakingPool.sol#L475)

contracts/dao/StakingPool.sol#L473-L476


 - [ ] ID-15
[StakingPool.__calcRewards(address,uint256,uint256)](contracts/dao/StakingPool.sol#L454-L469) performs a multiplication on the result of a division:
	- [amount_ = (totalRewardAmount * rewardPercent * period) / 1e10 / 1e4](contracts/dao/StakingPool.sol#L463)
	- [amount_ += (amount_ * IProperty(DAO_PROPERTY).boardRewardRate()) / 1e10](contracts/dao/StakingPool.sol#L467)

contracts/dao/StakingPool.sol#L454-L469


 - [ ] ID-16
[StakingPool.calcPendingRewards(address)](contracts/dao/StakingPool.sol#L420-L452) performs a multiplication on the result of a division:
	- [countRate = (pendingVoteCount * 1e4) / pCount](contracts/dao/StakingPool.sol#L442)
	- [amount = (amount * countRate) / 1e4](contracts/dao/StakingPool.sol#L443)

contracts/dao/StakingPool.sol#L420-L452


 - [ ] ID-17
[Math.mulDiv(uint256,uint256,uint256)](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L55-L134) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L101)
	- [inverse = (3 * denominator) ^ 2](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L116)

node_modules/@openzeppelin/contracts/utils/math/Math.sol#L55-L134


 - [ ] ID-18
[StakingPool.calculateAPR(uint256,uint256,uint256,uint256,bool)](contracts/dao/StakingPool.sol#L479-L516) performs a multiplication on the result of a division:
	- [stakingRewards = (totalRewardAmount * rewardPercent * _period) / 1e10](contracts/dao/StakingPool.sol#L496)
	- [stakingRewards += (stakingRewards * IProperty(DAO_PROPERTY).boardRewardRate()) / 1e10](contracts/dao/StakingPool.sol#L500)

contracts/dao/StakingPool.sol#L479-L516


## incorrect-equality
Impact: Medium
Confidence: High
 - [ ] ID-19
[VabbleDAO.proposalFilmUpdate(uint256,string,string,uint256[],address[],uint256,uint256,uint256,uint256)](contracts/dao/VabbleDAO.sol#L154-L228) uses a dangerous strict equality:
	- [fInfo.noVote == 1](contracts/dao/VabbleDAO.sol#L219)

contracts/dao/VabbleDAO.sol#L154-L228


 - [ ] ID-20
[VabbleDAO.__setFinalFilm(uint256,uint256)](contracts/dao/VabbleDAO.sol#L477-L504) uses a dangerous strict equality:
	- [fInfo.status == Helper.Status.APPROVED_LISTING](contracts/dao/VabbleDAO.sol#L485)

contracts/dao/VabbleDAO.sol#L477-L504


 - [ ] ID-21
[VabbleDAO.__setFinalFilm(uint256,uint256)](contracts/dao/VabbleDAO.sol#L477-L504) uses a dangerous strict equality:
	- [require(bool,string)(fInfo.status == Helper.Status.APPROVED_LISTING || fInfo.status == Helper.Status.APPROVED_FUNDING,sFF: Not approved)](contracts/dao/VabbleDAO.sol#L479-L482)

contracts/dao/VabbleDAO.sol#L477-L504


 - [ ] ID-22
[StakingPool.__calcRewards(address,uint256,uint256)](contracts/dao/StakingPool.sol#L454-L469) uses a dangerous strict equality:
	- [si.stakeAmount == 0](contracts/dao/StakingPool.sol#L456)

contracts/dao/StakingPool.sol#L454-L469


 - [ ] ID-23
[VabbleDAO.__claimAllReward(uint256[])](contracts/dao/VabbleDAO.sol#L550-L576) uses a dangerous strict equality:
	- [finalFilmCalledTime[_filmIds[i]] == 0](contracts/dao/VabbleDAO.sol#L559)

contracts/dao/VabbleDAO.sol#L550-L576


 - [ ] ID-24
[VabbleDAO.__setFinalFilm(uint256,uint256)](contracts/dao/VabbleDAO.sol#L477-L504) uses a dangerous strict equality:
	- [fInfo.status == Helper.Status.APPROVED_FUNDING](contracts/dao/VabbleDAO.sol#L487)

contracts/dao/VabbleDAO.sol#L477-L504


 - [ ] ID-25
[VabbleDAO.isEnabledClaimer(uint256)](contracts/dao/VabbleDAO.sol#L674-L677) uses a dangerous strict equality:
	- [filmInfo[_filmId].enableClaimer == 1](contracts/dao/VabbleDAO.sol#L675)

contracts/dao/VabbleDAO.sol#L674-L677


 - [ ] ID-26
[StakingPool.unstakeVAB(uint256)](contracts/dao/StakingPool.sol#L156-L185) uses a dangerous strict equality:
	- [si.stakeAmount == 0](contracts/dao/StakingPool.sol#L177)

contracts/dao/StakingPool.sol#L156-L185


 - [ ] ID-27
[StakingPool.__calcRewards(address,uint256,uint256)](contracts/dao/StakingPool.sol#L454-L469) uses a dangerous strict equality:
	- [startTime == 0](contracts/dao/StakingPool.sol#L457)

contracts/dao/StakingPool.sol#L454-L469


 - [ ] ID-28
[StakingPool.calcRewardAmount(address)](contracts/dao/StakingPool.sol#L238-L249) uses a dangerous strict equality:
	- [si.stakeAmount == 0](contracts/dao/StakingPool.sol#L241)

contracts/dao/StakingPool.sol#L238-L249


## reentrancy-no-eth
Impact: Medium
Confidence: Medium
 - [ ] ID-29
Reentrancy in [Property.proposalProperty(uint256,uint256,string,string)](contracts/dao/Property.sol#L398-L516):
	External calls:
	- [__paidFee(proposalFeeAmount)](contracts/dao/Property.sol#L412)
		- [(success,data) = token.call(abi.encodeWithSelector(0x23b872dd,from,to,value))](contracts/libraries/Helper.sol#L53)
		- [(success,data) = token.call(abi.encodeWithSelector(0x095ea7b3,to,value))](contracts/libraries/Helper.sol#L32)
		- [Helper.safeTransferFrom(vabToken,msg.sender,address(this),expectVABAmount)](contracts/dao/Property.sol#L244)
		- [Helper.safeApprove(vabToken,STAKING_POOL,IERC20(vabToken).totalSupply())](contracts/dao/Property.sol#L246)
		- [IStakingPool(STAKING_POOL).addRewardToPool(expectVABAmount)](contracts/dao/Property.sol#L248)
	- [pp.proposalID = IStakingPool(STAKING_POOL).addProposalData(msg.sender,block.timestamp,propertyVotePeriod)](contracts/dao/Property.sol#L509)
	State variables written after the call(s):
	- [isPropertyWhitelist[_flag][_property] = 1](contracts/dao/Property.sol#L513)
	[Property.isPropertyWhitelist](contracts/dao/Property.sol#L123) can be used in cross function reentrancies:
	- [Property.checkPropertyWhitelist(uint256,uint256)](contracts/dao/Property.sol#L682-L684)
	- [Property.updatePropertyProposal(uint256,uint256,uint256)](contracts/dao/Property.sol#L578-L639)

contracts/dao/Property.sol#L398-L516


 - [ ] ID-30
Reentrancy in [StakingPool.withdrawAllFund()](contracts/dao/StakingPool.sol#L696-L721):
	External calls:
	- [Helper.safeTransfer(vabToken,to,totalMigrationVAB)](contracts/dao/StakingPool.sol#L706)
	- [sumAmount += IOwnablee(OWNABLE).withdrawVABFromEdgePool(to)](contracts/dao/StakingPool.sol#L713)
	- [sumAmount += IVabbleDAO(VABBLE_DAO).withdrawVABFromStudioPool(to)](contracts/dao/StakingPool.sol#L716)
	State variables written after the call(s):
	- [migrationStatus = 2](contracts/dao/StakingPool.sol#L718)
	[StakingPool.migrationStatus](contracts/dao/StakingPool.sol#L63) can be used in cross function reentrancies:
	- [StakingPool.calcRewardAmount(address)](contracts/dao/StakingPool.sol#L238-L249)
	- [StakingPool.migrationStatus](contracts/dao/StakingPool.sol#L63)

contracts/dao/StakingPool.sol#L696-L721


 - [ ] ID-31
Reentrancy in [StakingPool.withdrawAllFund()](contracts/dao/StakingPool.sol#L696-L721):
	External calls:
	- [Helper.safeTransfer(vabToken,to,totalMigrationVAB)](contracts/dao/StakingPool.sol#L706)
	State variables written after the call(s):
	- [totalMigrationVAB = 0](contracts/dao/StakingPool.sol#L709)
	[StakingPool.totalMigrationVAB](contracts/dao/StakingPool.sol#L64) can be used in cross function reentrancies:
	- [StakingPool.totalMigrationVAB](contracts/dao/StakingPool.sol#L64)

contracts/dao/StakingPool.sol#L696-L721


 - [ ] ID-32
Reentrancy in [StakingPool.unstakeVAB(uint256)](contracts/dao/StakingPool.sol#L156-L185):
	External calls:
	- [__withdrawReward(rewardAmount)](contracts/dao/StakingPool.sol#L167)
		- [Helper.safeTransfer(IOwnablee(OWNABLE).PAYOUT_TOKEN(),msg.sender,_amount)](contracts/dao/StakingPool.sol#L222)
		- [(success,data) = token.call(abi.encodeWithSelector(0xa9059cbb,to,value))](contracts/libraries/Helper.sol#L42)
	- [Helper.safeTransfer(IOwnablee(OWNABLE).PAYOUT_TOKEN(),msg.sender,_amount)](contracts/dao/StakingPool.sol#L171)
	State variables written after the call(s):
	- [si.stakeTime = block.timestamp](contracts/dao/StakingPool.sol#L173)
	[StakingPool.stakeInfo](contracts/dao/StakingPool.sol#L68) can be used in cross function reentrancies:
	- [StakingPool.__calcProposalTimeIntervals(address)](contracts/dao/StakingPool.sol#L251-L290)
	- [StakingPool.__calcRewards(address,uint256,uint256)](contracts/dao/StakingPool.sol#L454-L469)
	- [StakingPool.__getProposalVoteCount(address,uint256,uint256,uint256)](contracts/dao/StakingPool.sol#L329-L374)
	- [StakingPool.calcRewardAmount(address)](contracts/dao/StakingPool.sol#L238-L249)
	- [StakingPool.getStakeAmount(address)](contracts/dao/StakingPool.sol#L765-L767)
	- [StakingPool.getWithdrawableTime(address)](contracts/dao/StakingPool.sol#L789-L791)
	- [StakingPool.stakeInfo](contracts/dao/StakingPool.sol#L68)
	- [si.stakeAmount -= _amount](contracts/dao/StakingPool.sol#L174)
	[StakingPool.stakeInfo](contracts/dao/StakingPool.sol#L68) can be used in cross function reentrancies:
	- [StakingPool.__calcProposalTimeIntervals(address)](contracts/dao/StakingPool.sol#L251-L290)
	- [StakingPool.__calcRewards(address,uint256,uint256)](contracts/dao/StakingPool.sol#L454-L469)
	- [StakingPool.__getProposalVoteCount(address,uint256,uint256,uint256)](contracts/dao/StakingPool.sol#L329-L374)
	- [StakingPool.calcRewardAmount(address)](contracts/dao/StakingPool.sol#L238-L249)
	- [StakingPool.getStakeAmount(address)](contracts/dao/StakingPool.sol#L765-L767)
	- [StakingPool.getWithdrawableTime(address)](contracts/dao/StakingPool.sol#L789-L791)
	- [StakingPool.stakeInfo](contracts/dao/StakingPool.sol#L68)
	- [delete stakeInfo[msg.sender]](contracts/dao/StakingPool.sol#L178)
	[StakingPool.stakeInfo](contracts/dao/StakingPool.sol#L68) can be used in cross function reentrancies:
	- [StakingPool.__calcProposalTimeIntervals(address)](contracts/dao/StakingPool.sol#L251-L290)
	- [StakingPool.__calcRewards(address,uint256,uint256)](contracts/dao/StakingPool.sol#L454-L469)
	- [StakingPool.__getProposalVoteCount(address,uint256,uint256,uint256)](contracts/dao/StakingPool.sol#L329-L374)
	- [StakingPool.calcRewardAmount(address)](contracts/dao/StakingPool.sol#L238-L249)
	- [StakingPool.getStakeAmount(address)](contracts/dao/StakingPool.sol#L765-L767)
	- [StakingPool.getWithdrawableTime(address)](contracts/dao/StakingPool.sol#L789-L791)
	- [StakingPool.stakeInfo](contracts/dao/StakingPool.sol#L68)
	- [totalStakingAmount -= _amount](contracts/dao/StakingPool.sol#L175)
	[StakingPool.totalStakingAmount](contracts/dao/StakingPool.sol#L59) can be used in cross function reentrancies:
	- [StakingPool.__rewardPercent(uint256)](contracts/dao/StakingPool.sol#L473-L476)
	- [StakingPool.totalStakingAmount](contracts/dao/StakingPool.sol#L59)

contracts/dao/StakingPool.sol#L156-L185


 - [ ] ID-33
Reentrancy in [FactorySubNFT.lockNFT(uint256)](contracts/dao/FactorySubNFT.sol#L207-L219):
	External calls:
	- [subNFTContract.transferNFT(_tokenId,address(this))](contracts/dao/FactorySubNFT.sol#L211)
	State variables written after the call(s):
	- [lockInfo[_tokenId].lockPeriod = nftLockPeriod](contracts/dao/FactorySubNFT.sol#L215)
	[FactorySubNFT.lockInfo](contracts/dao/FactorySubNFT.sol#L38) can be used in cross function reentrancies:
	- [FactorySubNFT.getLockInfo(uint256)](contracts/dao/FactorySubNFT.sol#L281-L297)
	- [lockInfo[_tokenId].lockTime = block.timestamp](contracts/dao/FactorySubNFT.sol#L216)
	[FactorySubNFT.lockInfo](contracts/dao/FactorySubNFT.sol#L38) can be used in cross function reentrancies:
	- [FactorySubNFT.getLockInfo(uint256)](contracts/dao/FactorySubNFT.sol#L281-L297)

contracts/dao/FactorySubNFT.sol#L207-L219


 - [ ] ID-34
Reentrancy in [Property.proposalFilmBoard(address,string,string)](contracts/dao/Property.sol#L287-L318):
	External calls:
	- [__paidFee(proposalFeeAmount)](contracts/dao/Property.sol#L299)
		- [(success,data) = token.call(abi.encodeWithSelector(0x23b872dd,from,to,value))](contracts/libraries/Helper.sol#L53)
		- [(success,data) = token.call(abi.encodeWithSelector(0x095ea7b3,to,value))](contracts/libraries/Helper.sol#L32)
		- [Helper.safeTransferFrom(vabToken,msg.sender,address(this),expectVABAmount)](contracts/dao/Property.sol#L244)
		- [Helper.safeApprove(vabToken,STAKING_POOL,IERC20(vabToken).totalSupply())](contracts/dao/Property.sol#L246)
		- [IStakingPool(STAKING_POOL).addRewardToPool(expectVABAmount)](contracts/dao/Property.sol#L248)
	- [bp.proposalID = IStakingPool(STAKING_POOL).addProposalData(msg.sender,block.timestamp,boardVotePeriod)](contracts/dao/Property.sol#L309)
	State variables written after the call(s):
	- [filmBoardCandidates.push(_member)](contracts/dao/Property.sol#L315)
	[Property.filmBoardCandidates](contracts/dao/Property.sol#L116) can be used in cross function reentrancies:
	- [Property.getGovProposalList(uint256)](contracts/dao/Property.sol#L345-L361)
	- [isGovWhitelist[2][_member] = 1](contracts/dao/Property.sol#L311)
	[Property.isGovWhitelist](contracts/dao/Property.sol#L121) can be used in cross function reentrancies:
	- [Property.checkGovWhitelist(uint256,address)](contracts/dao/Property.sol#L678-L680)
	- [Property.updateGovProposal(uint256,uint256,uint256)](contracts/dao/Property.sol#L641-L676)

contracts/dao/Property.sol#L287-L318


 - [ ] ID-35
Reentrancy in [Property.proposalRewardFund(address,string,string)](contracts/dao/Property.sol#L252-L283):
	External calls:
	- [__paidFee(10 * proposalFeeAmount)](contracts/dao/Property.sol#L264)
		- [(success,data) = token.call(abi.encodeWithSelector(0x23b872dd,from,to,value))](contracts/libraries/Helper.sol#L53)
		- [(success,data) = token.call(abi.encodeWithSelector(0x095ea7b3,to,value))](contracts/libraries/Helper.sol#L32)
		- [Helper.safeTransferFrom(vabToken,msg.sender,address(this),expectVABAmount)](contracts/dao/Property.sol#L244)
		- [Helper.safeApprove(vabToken,STAKING_POOL,IERC20(vabToken).totalSupply())](contracts/dao/Property.sol#L246)
		- [IStakingPool(STAKING_POOL).addRewardToPool(expectVABAmount)](contracts/dao/Property.sol#L248)
	- [rp.proposalID = IStakingPool(STAKING_POOL).addProposalData(msg.sender,block.timestamp,rewardVotePeriod)](contracts/dao/Property.sol#L274)
	State variables written after the call(s):
	- [isGovWhitelist[3][_rewardAddress] = 1](contracts/dao/Property.sol#L276)
	[Property.isGovWhitelist](contracts/dao/Property.sol#L121) can be used in cross function reentrancies:
	- [Property.checkGovWhitelist(uint256,address)](contracts/dao/Property.sol#L678-L680)
	- [Property.updateGovProposal(uint256,uint256,uint256)](contracts/dao/Property.sol#L641-L676)
	- [rewardAddressList.push(_rewardAddress)](contracts/dao/Property.sol#L280)
	[Property.rewardAddressList](contracts/dao/Property.sol#L115) can be used in cross function reentrancies:
	- [Property.getGovProposalList(uint256)](contracts/dao/Property.sol#L345-L361)

contracts/dao/Property.sol#L252-L283


 - [ ] ID-36
Reentrancy in [VabbleFund.depositToFilm(uint256,uint256,uint256,address)](contracts/dao/VabbleFund.sol#L78-L116):
	External calls:
	- [Helper.safeTransferETH(msg.sender,msg.value - tokenAmount)](contracts/dao/VabbleFund.sol#L108)
	- [Helper.safeTransferFrom(_token,msg.sender,address(this),tokenAmount)](contracts/dao/VabbleFund.sol#L110)
	State variables written after the call(s):
	- [__assignToken(_filmId,_token,tokenAmount)](contracts/dao/VabbleFund.sol#L113)
		- [assetInfo[_filmId][msg.sender][i].amount += _amount](contracts/dao/VabbleFund.sol#L161)
		- [assetInfo[_filmId][msg.sender].push(Asset({token:_token,amount:_amount}))](contracts/dao/VabbleFund.sol#L167)
	[VabbleFund.assetInfo](contracts/dao/VabbleFund.sol#L37) can be used in cross function reentrancies:
	- [VabbleFund.assetInfo](contracts/dao/VabbleFund.sol#L37)
	- [VabbleFund.getUserFundAmountPerFilm(address,uint256)](contracts/dao/VabbleFund.sol#L310-L320)

contracts/dao/VabbleFund.sol#L78-L116


 - [ ] ID-37
Reentrancy in [VabbleFund.fundProcess(uint256)](contracts/dao/VabbleFund.sol#L184-L236):
	External calls:
	- [Helper.safeTransferETH(UNI_HELPER,rewardAmount)](contracts/dao/VabbleFund.sol#L211)
	- [Helper.safeApprove(assetArr[i].token,UNI_HELPER,IERC20(assetArr[i].token).totalSupply())](contracts/dao/VabbleFund.sol#L214)
	- [rewardSumAmount += IUniHelper(UNI_HELPER).swapAsset(swapArgs)](contracts/dao/VabbleFund.sol#L218)
	- [Helper.safeTransferAsset(assetArr[i].token,msg.sender,(assetArr[i].amount - rewardAmount))](contracts/dao/VabbleFund.sol#L221)
	- [Helper.safeApprove(vabToken,STAKING_POOL,IERC20(vabToken).totalSupply())](contracts/dao/VabbleFund.sol#L226)
	- [IStakingPool(STAKING_POOL).addRewardToPool(rewardSumAmount)](contracts/dao/VabbleFund.sol#L229)
	State variables written after the call(s):
	- [isFundProcessed[_filmId] = true](contracts/dao/VabbleFund.sol#L233)
	[VabbleFund.isFundProcessed](contracts/dao/VabbleFund.sol#L39) can be used in cross function reentrancies:
	- [VabbleFund.isFundProcessed](contracts/dao/VabbleFund.sol#L39)

contracts/dao/VabbleFund.sol#L184-L236


 - [ ] ID-38
Reentrancy in [VabbleDAO.proposalFilmUpdate(uint256,string,string,uint256[],address[],uint256,uint256,uint256,uint256)](contracts/dao/VabbleDAO.sol#L154-L228):
	External calls:
	- [proposalID = IStakingPool(STAKING_POOL).addProposalData(msg.sender,block.timestamp,IProperty(DAO_PROPERTY).filmVotePeriod())](contracts/dao/VabbleDAO.sol#L210-L212)
	- [IVote(VOTE).saveProposalWithFilm(_filmId,proposalID)](contracts/dao/VabbleDAO.sol#L213)
	- [IStakingPool(STAKING_POOL).updateLastfundProposalCreateTime(block.timestamp)](contracts/dao/VabbleDAO.sol#L217)
	State variables written after the call(s):
	- [fInfo.status = Helper.Status.APPROVED_FUNDING](contracts/dao/VabbleDAO.sol#L220)
	[VabbleDAO.filmInfo](contracts/dao/VabbleDAO.sol#L57) can be used in cross function reentrancies:
	- [VabbleDAO.approveFilmByVote(uint256,uint256)](contracts/dao/VabbleDAO.sol#L327-L348)
	- [VabbleDAO.filmInfo](contracts/dao/VabbleDAO.sol#L57)
	- [VabbleDAO.getFilmFund(uint256)](contracts/dao/VabbleDAO.sol#L646-L655)
	- [VabbleDAO.getFilmOwner(uint256)](contracts/dao/VabbleDAO.sol#L641-L643)
	- [VabbleDAO.getFilmProposalTime(uint256)](contracts/dao/VabbleDAO.sol#L668-L671)
	- [VabbleDAO.getFilmShare(uint256)](contracts/dao/VabbleDAO.sol#L658-L665)
	- [VabbleDAO.getFilmStatus(uint256)](contracts/dao/VabbleDAO.sol#L636-L638)
	- [VabbleDAO.isEnabledClaimer(uint256)](contracts/dao/VabbleDAO.sol#L674-L677)
	- [VabbleDAO.migrateFilmProposals(IVabbleDAO.Film[])](contracts/dao/VabbleDAO.sol#L114-L121)
	- [VabbleDAO.updateEnabledClaimer(uint256,uint256)](contracts/dao/VabbleDAO.sol#L680-L684)
	- [fInfo.pApproveTime = block.timestamp](contracts/dao/VabbleDAO.sol#L221)
	[VabbleDAO.filmInfo](contracts/dao/VabbleDAO.sol#L57) can be used in cross function reentrancies:
	- [VabbleDAO.approveFilmByVote(uint256,uint256)](contracts/dao/VabbleDAO.sol#L327-L348)
	- [VabbleDAO.filmInfo](contracts/dao/VabbleDAO.sol#L57)
	- [VabbleDAO.getFilmFund(uint256)](contracts/dao/VabbleDAO.sol#L646-L655)
	- [VabbleDAO.getFilmOwner(uint256)](contracts/dao/VabbleDAO.sol#L641-L643)
	- [VabbleDAO.getFilmProposalTime(uint256)](contracts/dao/VabbleDAO.sol#L668-L671)
	- [VabbleDAO.getFilmShare(uint256)](contracts/dao/VabbleDAO.sol#L658-L665)
	- [VabbleDAO.getFilmStatus(uint256)](contracts/dao/VabbleDAO.sol#L636-L638)
	- [VabbleDAO.isEnabledClaimer(uint256)](contracts/dao/VabbleDAO.sol#L674-L677)
	- [VabbleDAO.migrateFilmProposals(IVabbleDAO.Film[])](contracts/dao/VabbleDAO.sol#L114-L121)
	- [VabbleDAO.updateEnabledClaimer(uint256,uint256)](contracts/dao/VabbleDAO.sol#L680-L684)
	- [totalFilmIds[3].push(_filmId)](contracts/dao/VabbleDAO.sol#L222)
	[VabbleDAO.totalFilmIds](contracts/dao/VabbleDAO.sol#L52) can be used in cross function reentrancies:
	- [VabbleDAO.approveFilmByVote(uint256,uint256)](contracts/dao/VabbleDAO.sol#L327-L348)
	- [VabbleDAO.getFilmIds(uint256)](contracts/dao/VabbleDAO.sol#L687-L689)
	- [VabbleDAO.migrateFilmProposals(IVabbleDAO.Film[])](contracts/dao/VabbleDAO.sol#L114-L121)
	- [userFilmIds[msg.sender][3].push(_filmId)](contracts/dao/VabbleDAO.sol#L223)
	[VabbleDAO.userFilmIds](contracts/dao/VabbleDAO.sol#L59) can be used in cross function reentrancies:
	- [VabbleDAO.approveFilmByVote(uint256,uint256)](contracts/dao/VabbleDAO.sol#L327-L348)
	- [VabbleDAO.getAllAvailableRewards(uint256,address)](contracts/dao/VabbleDAO.sol#L603-L615)
	- [VabbleDAO.getUserFilmIds(address,uint256)](contracts/dao/VabbleDAO.sol#L631-L633)
	- [VabbleDAO.migrateFilmProposals(IVabbleDAO.Film[])](contracts/dao/VabbleDAO.sol#L114-L121)

contracts/dao/VabbleDAO.sol#L154-L228


 - [ ] ID-39
Reentrancy in [FactorySubNFT.unlockNFT(uint256)](contracts/dao/FactorySubNFT.sol#L222-L235):
	External calls:
	- [subNFTContract.transferNFT(_tokenId,msg.sender)](contracts/dao/FactorySubNFT.sol#L229)
	State variables written after the call(s):
	- [lockInfo[_tokenId].lockPeriod = 0](contracts/dao/FactorySubNFT.sol#L231)
	[FactorySubNFT.lockInfo](contracts/dao/FactorySubNFT.sol#L38) can be used in cross function reentrancies:
	- [FactorySubNFT.getLockInfo(uint256)](contracts/dao/FactorySubNFT.sol#L281-L297)
	- [lockInfo[_tokenId].lockTime = 0](contracts/dao/FactorySubNFT.sol#L232)
	[FactorySubNFT.lockInfo](contracts/dao/FactorySubNFT.sol#L38) can be used in cross function reentrancies:
	- [FactorySubNFT.getLockInfo(uint256)](contracts/dao/FactorySubNFT.sol#L281-L297)

contracts/dao/FactorySubNFT.sol#L222-L235


 - [ ] ID-40
Reentrancy in [Property.proposalAuditor(address,string,string)](contracts/dao/Property.sol#L201-L233):
	External calls:
	- [__paidFee(proposalFeeAmount)](contracts/dao/Property.sol#L214)
		- [(success,data) = token.call(abi.encodeWithSelector(0x23b872dd,from,to,value))](contracts/libraries/Helper.sol#L53)
		- [(success,data) = token.call(abi.encodeWithSelector(0x095ea7b3,to,value))](contracts/libraries/Helper.sol#L32)
		- [Helper.safeTransferFrom(vabToken,msg.sender,address(this),expectVABAmount)](contracts/dao/Property.sol#L244)
		- [Helper.safeApprove(vabToken,STAKING_POOL,IERC20(vabToken).totalSupply())](contracts/dao/Property.sol#L246)
		- [IStakingPool(STAKING_POOL).addRewardToPool(expectVABAmount)](contracts/dao/Property.sol#L248)
	- [ap.proposalID = IStakingPool(STAKING_POOL).addProposalData(msg.sender,block.timestamp,agentVotePeriod)](contracts/dao/Property.sol#L224)
	State variables written after the call(s):
	- [agentList.push(Agent(_agent,IStakingPool(STAKING_POOL).getStakeAmount(msg.sender)))](contracts/dao/Property.sol#L230)
	[Property.agentList](contracts/dao/Property.sol#L114) can be used in cross function reentrancies:
	- [Property.getAgentProposerStakeAmount(uint256)](contracts/dao/Property.sol#L364-L366)
	- [Property.getGovProposalList(uint256)](contracts/dao/Property.sol#L345-L361)
	- [isGovWhitelist[1][_agent] = 1](contracts/dao/Property.sol#L228)
	[Property.isGovWhitelist](contracts/dao/Property.sol#L121) can be used in cross function reentrancies:
	- [Property.checkGovWhitelist(uint256,address)](contracts/dao/Property.sol#L678-L680)
	- [Property.updateGovProposal(uint256,uint256,uint256)](contracts/dao/Property.sol#L641-L676)

contracts/dao/Property.sol#L201-L233


 - [ ] ID-41
Reentrancy in [VabbleDAO.allocateFromEdgePool(uint256)](contracts/dao/VabbleDAO.sol#L400-L414):
	External calls:
	- [IOwnablee(OWNABLE).addToStudioPool(_amount)](contracts/dao/VabbleDAO.sol#L404)
	State variables written after the call(s):
	- [delete edgePoolUsers](contracts/dao/VabbleDAO.sol#L413)
	[VabbleDAO.edgePoolUsers](contracts/dao/VabbleDAO.sol#L55) can be used in cross function reentrancies:
	- [VabbleDAO.getPoolUsers(uint256)](contracts/dao/VabbleDAO.sol#L692-L695)

contracts/dao/VabbleDAO.sol#L400-L414


 - [ ] ID-42
Reentrancy in [VabbleDAO.__claimAllReward(uint256[])](contracts/dao/VabbleDAO.sol#L550-L576):
	External calls:
	- [Helper.safeTransfer(vabToken,msg.sender,rewardSum)](contracts/dao/VabbleDAO.sol#L572)
	State variables written after the call(s):
	- [StudioPool -= rewardSum](contracts/dao/VabbleDAO.sol#L573)
	[VabbleDAO.StudioPool](contracts/dao/VabbleDAO.sol#L69) can be used in cross function reentrancies:
	- [VabbleDAO.StudioPool](contracts/dao/VabbleDAO.sol#L69)

contracts/dao/VabbleDAO.sol#L550-L576


 - [ ] ID-43
Reentrancy in [StakingPool.__transferVABWithdraw(address)](contracts/dao/StakingPool.sol#L571-L584):
	External calls:
	- [Helper.safeTransfer(IOwnablee(OWNABLE).PAYOUT_TOKEN(),_to,payAmount)](contracts/dao/StakingPool.sol#L577)
	State variables written after the call(s):
	- [userRentInfo[_to].vabAmount -= payAmount](contracts/dao/StakingPool.sol#L579)
	[StakingPool.userRentInfo](contracts/dao/StakingPool.sol#L70) can be used in cross function reentrancies:
	- [StakingPool.checkAllocateToPool(address[],uint256[])](contracts/dao/StakingPool.sol#L674-L692)
	- [StakingPool.checkApprovePendingWithdraw(address[])](contracts/dao/StakingPool.sol#L586-L616)
	- [StakingPool.checkDenyPendingWithDraw(address[])](contracts/dao/StakingPool.sol#L635-L647)
	- [StakingPool.getRentVABAmount(address)](contracts/dao/StakingPool.sol#L770-L772)
	- [StakingPool.sendVAB(address[],address,uint256[])](contracts/dao/StakingPool.sol#L650-L672)
	- [StakingPool.userRentInfo](contracts/dao/StakingPool.sol#L70)
	- [userRentInfo[_to].withdrawAmount = 0](contracts/dao/StakingPool.sol#L580)
	[StakingPool.userRentInfo](contracts/dao/StakingPool.sol#L70) can be used in cross function reentrancies:
	- [StakingPool.checkAllocateToPool(address[],uint256[])](contracts/dao/StakingPool.sol#L674-L692)
	- [StakingPool.checkApprovePendingWithdraw(address[])](contracts/dao/StakingPool.sol#L586-L616)
	- [StakingPool.checkDenyPendingWithDraw(address[])](contracts/dao/StakingPool.sol#L635-L647)
	- [StakingPool.getRentVABAmount(address)](contracts/dao/StakingPool.sol#L770-L772)
	- [StakingPool.sendVAB(address[],address,uint256[])](contracts/dao/StakingPool.sol#L650-L672)
	- [StakingPool.userRentInfo](contracts/dao/StakingPool.sol#L70)
	- [userRentInfo[_to].pending = false](contracts/dao/StakingPool.sol#L581)
	[StakingPool.userRentInfo](contracts/dao/StakingPool.sol#L70) can be used in cross function reentrancies:
	- [StakingPool.checkAllocateToPool(address[],uint256[])](contracts/dao/StakingPool.sol#L674-L692)
	- [StakingPool.checkApprovePendingWithdraw(address[])](contracts/dao/StakingPool.sol#L586-L616)
	- [StakingPool.checkDenyPendingWithDraw(address[])](contracts/dao/StakingPool.sol#L635-L647)
	- [StakingPool.getRentVABAmount(address)](contracts/dao/StakingPool.sol#L770-L772)
	- [StakingPool.sendVAB(address[],address,uint256[])](contracts/dao/StakingPool.sol#L650-L672)
	- [StakingPool.userRentInfo](contracts/dao/StakingPool.sol#L70)

contracts/dao/StakingPool.sol#L571-L584


## tautology
Impact: Medium
Confidence: High
 - [ ] ID-44
[Property.proposalProperty(uint256,uint256,string,string)](contracts/dao/Property.sol#L398-L516) contains a tautology or contradiction:
	- [require(bool,string)(_property != 0 && _flag >= 0 && _flag < maxPropertyList.length,pP: bad value)](contracts/dao/Property.sol#L408)

contracts/dao/Property.sol#L398-L516


## uninitialized-local
Impact: Medium
Confidence: Medium
 - [ ] ID-45
[Property.proposalProperty(uint256,uint256,string,string).len](contracts/dao/Property.sol#L414) is a local variable never initialized

contracts/dao/Property.sol#L414


 - [ ] ID-46
[StakingPool.calculateAPR(uint256,uint256,uint256,uint256,bool).pendingRewards](contracts/dao/StakingPool.sol#L505) is a local variable never initialized

contracts/dao/StakingPool.sol#L505


 - [ ] ID-47
[StakingPool.withdrawAllFund().sumAmount](contracts/dao/StakingPool.sol#L703) is a local variable never initialized

contracts/dao/StakingPool.sol#L703


 - [ ] ID-48
[VabbleDAO.__claimAllReward(uint256[]).rewardSum](contracts/dao/VabbleDAO.sol#L556) is a local variable never initialized

contracts/dao/VabbleDAO.sol#L556


 - [ ] ID-49
[Subscription.getExpectedSubscriptionAmount(address,uint256).discount](contracts/dao/Subscription.sol#L245) is a local variable never initialized

contracts/dao/Subscription.sol#L245


 - [ ] ID-50
[VabbleFund.fundProcess(uint256).rewardSumAmount](contracts/dao/VabbleFund.sol#L201) is a local variable never initialized

contracts/dao/VabbleFund.sol#L201


## unused-return
Impact: Medium
Confidence: Medium
 - [ ] ID-51
[Subscription.swapAllAssetsAndSendToVabWallet()](contracts/dao/Subscription.sol#L176-L198) ignores return value by [IUniHelper(UNI_HELPER).swapAsset(abi.encode(ethAmount,address(0),USDC_TOKEN))](contracts/dao/Subscription.sol#L180)

contracts/dao/Subscription.sol#L176-L198


 - [ ] ID-52
[Vote.setDAORewardAddress(uint256)](contracts/dao/Vote.sol#L445-L473) ignores return value by [(cTime,aTime,None,member,None,None) = IProperty(DAO_PROPERTY).getGovProposalInfo(_index,3)](contracts/dao/Vote.sol#L446)

contracts/dao/Vote.sol#L445-L473


 - [ ] ID-53
[Vote.disputeToAgent(uint256,bool)](contracts/dao/Vote.sol#L273-L289) ignores return value by [(None,aTime,None,agent,None,stats) = IProperty(DAO_PROPERTY).getGovProposalInfo(_index,1)](contracts/dao/Vote.sol#L274)

contracts/dao/Vote.sol#L273-L289


 - [ ] ID-54
[Vote.updateProperty(uint256,uint256)](contracts/dao/Vote.sol#L513-L543) ignores return value by [(cTime,aTime,None,value,None,None) = IProperty(DAO_PROPERTY).getPropertyProposalInfo(_index,_flag)](contracts/dao/Vote.sol#L517)

contracts/dao/Vote.sol#L513-L543


 - [ ] ID-55
[Vote.updateAgentStats(uint256)](contracts/dao/Vote.sol#L240-L269) ignores return value by [(cTime,aTime,None,agent,None,None) = IProperty(DAO_PROPERTY).getGovProposalInfo(_index,1)](contracts/dao/Vote.sol#L241)

contracts/dao/Vote.sol#L240-L269


 - [ ] ID-56
[VabbleFund.isRaisedFullAmount(uint256)](contracts/dao/VabbleFund.sol#L298-L307) ignores return value by [(raiseAmount,None,None,None) = IVabbleDAO(VABBLE_DAO).getFilmFund(_filmId)](contracts/dao/VabbleFund.sol#L301)

contracts/dao/VabbleFund.sol#L298-L307


 - [ ] ID-57
[FactoryTierNFT.setTierInfo(uint256,uint256[],uint256[])](contracts/dao/FactoryTierNFT.sol#L77-L109) ignores return value by [(raiseAmount,fundPeriod,fundType,None) = IVabbleDAO(VABBLE_DAO).getFilmFund(_filmId)](contracts/dao/FactoryTierNFT.sol#L88)

contracts/dao/FactoryTierNFT.sol#L77-L109


 - [ ] ID-58
[FactoryTierNFT.setTierInfo(uint256,uint256[],uint256[])](contracts/dao/FactoryTierNFT.sol#L77-L109) ignores return value by [(None,pApproveTime) = IVabbleDAO(VABBLE_DAO).getFilmProposalTime(_filmId)](contracts/dao/FactoryTierNFT.sol#L89)

contracts/dao/FactoryTierNFT.sol#L77-L109


 - [ ] ID-59
[FactoryFilmNFT.deployFilmNFTContract(uint256,string,string)](contracts/dao/FactoryFilmNFT.sol#L114-L144) ignores return value by [(None,None,fundType,None) = IVabbleDAO(VABBLE_DAO).getFilmFund(_filmId)](contracts/dao/FactoryFilmNFT.sol#L121)

contracts/dao/FactoryFilmNFT.sol#L114-L144


 - [ ] ID-60
[VabbleDAO.allocateToPool(address[],uint256[],uint256)](contracts/dao/VabbleDAO.sol#L362-L397) ignores return value by [IStakingPool(STAKING_POOL).sendVAB(_users,OWNABLE,_amounts)](contracts/dao/VabbleDAO.sol#L377)

contracts/dao/VabbleDAO.sol#L362-L397


 - [ ] ID-61
[StakingPool.__calcProposalTimeIntervals(address)](contracts/dao/StakingPool.sol#L251-L290) ignores return value by [times_.sort()](contracts/dao/StakingPool.sol#L289)

contracts/dao/StakingPool.sol#L251-L290


 - [ ] ID-62
[Vote.voteToAgent(uint256,uint256)](contracts/dao/Vote.sol#L206-L237) ignores return value by [(cTime,None,pID,agent,creator,None) = IProperty(DAO_PROPERTY).getGovProposalInfo(_index,1)](contracts/dao/Vote.sol#L210)

contracts/dao/Vote.sol#L206-L237


 - [ ] ID-63
[VabbleFund.withdrawFunding(uint256)](contracts/dao/VabbleFund.sol#L239-L272) ignores return value by [(None,pApproveTime) = IVabbleDAO(VABBLE_DAO).getFilmProposalTime(_filmId)](contracts/dao/VabbleFund.sol#L244)

contracts/dao/VabbleFund.sol#L239-L272


 - [ ] ID-64
[VabbleFund.fundProcess(uint256)](contracts/dao/VabbleFund.sol#L184-L236) ignores return value by [(None,pApproveTime) = IVabbleDAO(VABBLE_DAO).getFilmProposalTime(_filmId)](contracts/dao/VabbleFund.sol#L193)

contracts/dao/VabbleFund.sol#L184-L236


 - [ ] ID-65
[Subscription.swapAllAssetsAndSendToVabWallet()](contracts/dao/Subscription.sol#L176-L198) ignores return value by [IUniHelper(UNI_HELPER).swapAsset(abi.encode(vabAmount,VAB_TOKEN,USDC_TOKEN))](contracts/dao/Subscription.sol#L188)

contracts/dao/Subscription.sol#L176-L198


 - [ ] ID-66
[VabbleFund.fundProcess(uint256)](contracts/dao/VabbleFund.sol#L184-L236) ignores return value by [(None,fundPeriod,None,None) = IVabbleDAO(VABBLE_DAO).getFilmFund(_filmId)](contracts/dao/VabbleFund.sol#L192)

contracts/dao/VabbleFund.sol#L184-L236


 - [ ] ID-67
[Vote.__voteToFilm(uint256,uint256)](contracts/dao/Vote.sol#L113-L159) ignores return value by [(None,None,fundType,None) = IVabbleDAO(VABBLE_DAO).getFilmFund(_filmId)](contracts/dao/Vote.sol#L129)

contracts/dao/Vote.sol#L113-L159


 - [ ] ID-68
[VabbleFund.depositToFilm(uint256,uint256,uint256,address)](contracts/dao/VabbleFund.sol#L78-L116) ignores return value by [(None,fundPeriod,fundType,None) = IVabbleDAO(VABBLE_DAO).getFilmFund(_filmId)](contracts/dao/VabbleFund.sol#L90)

contracts/dao/VabbleFund.sol#L78-L116


 - [ ] ID-69
[VabbleFund.__depositToFilm(uint256,uint256,uint256,uint256,uint256,address)](contracts/dao/VabbleFund.sol#L119-L150) ignores return value by [(None,maxMintAmount,mintPrice,nft,None) = IFactoryFilmNFT(FILM_NFT).getMintInfo(_filmId)](contracts/dao/VabbleFund.sol#L137)

contracts/dao/VabbleFund.sol#L119-L150


 - [ ] ID-70
[VabbleFund.depositToFilm(uint256,uint256,uint256,address)](contracts/dao/VabbleFund.sol#L78-L116) ignores return value by [(None,pApproveTime) = IVabbleDAO(VABBLE_DAO).getFilmProposalTime(_filmId)](contracts/dao/VabbleFund.sol#L91)

contracts/dao/VabbleFund.sol#L78-L116


 - [ ] ID-71
[VabbleFund.withdrawFunding(uint256)](contracts/dao/VabbleFund.sol#L239-L272) ignores return value by [(None,fundPeriod,None,None) = IVabbleDAO(VABBLE_DAO).getFilmFund(_filmId)](contracts/dao/VabbleFund.sol#L243)

contracts/dao/VabbleFund.sol#L239-L272


 - [ ] ID-72
[Vote.voteToProperty(uint256,uint256,uint256)](contracts/dao/Vote.sol#L476-L510) ignores return value by [(cTime,None,pID,value,creator,None) = IProperty(DAO_PROPERTY).getPropertyProposalInfo(_index,_flag)](contracts/dao/Vote.sol#L481)

contracts/dao/Vote.sol#L476-L510


 - [ ] ID-73
[Vote.voteToFilmBoard(uint256,uint256)](contracts/dao/Vote.sol#L345-L379) ignores return value by [(cTime,None,pID,member,creator,None) = IProperty(DAO_PROPERTY).getGovProposalInfo(_index,2)](contracts/dao/Vote.sol#L349)

contracts/dao/Vote.sol#L345-L379


 - [ ] ID-74
[Vote.__voteToFilm(uint256,uint256)](contracts/dao/Vote.sol#L113-L159) ignores return value by [(cTime,None) = IVabbleDAO(VABBLE_DAO).getFilmProposalTime(_filmId)](contracts/dao/Vote.sol#L124)

contracts/dao/Vote.sol#L113-L159


 - [ ] ID-75
[Vote.addFilmBoard(uint256)](contracts/dao/Vote.sol#L381-L409) ignores return value by [(cTime,aTime,None,member,None,None) = IProperty(DAO_PROPERTY).getGovProposalInfo(_index,2)](contracts/dao/Vote.sol#L382)

contracts/dao/Vote.sol#L381-L409


 - [ ] ID-76
[Vote.voteToRewardAddress(uint256,uint256)](contracts/dao/Vote.sol#L412-L443) ignores return value by [(cTime,None,pID,member,creator,None) = IProperty(DAO_PROPERTY).getGovProposalInfo(_index,3)](contracts/dao/Vote.sol#L413)

contracts/dao/Vote.sol#L412-L443


 - [ ] ID-77
[Vote.__approveFilm(uint256)](contracts/dao/Vote.sol#L176-L203) ignores return value by [(None,None,fundType,None) = IVabbleDAO(VABBLE_DAO).getFilmFund(_filmId)](contracts/dao/Vote.sol#L185)

contracts/dao/Vote.sol#L176-L203


 - [ ] ID-78
[Vote.replaceAuditor(uint256)](contracts/dao/Vote.sol#L323-L343) ignores return value by [(None,aTime,None,agent,None,stats) = IProperty(DAO_PROPERTY).getGovProposalInfo(_index,1)](contracts/dao/Vote.sol#L324)

contracts/dao/Vote.sol#L323-L343


## shadowing-local
Impact: Low
Confidence: High
 - [ ] ID-79
[VabbleNFT.constructor(string,string,string,string,address)._name](contracts/dao/VabbleNFT.sol#L28) shadows:
	- [ERC721._name](node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol#L24) (state variable)

contracts/dao/VabbleNFT.sol#L28


 - [ ] ID-80
[VabbleNFT.constructor(string,string,string,string,address)._symbol](contracts/dao/VabbleNFT.sol#L29) shadows:
	- [ERC721._symbol](node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol#L27) (state variable)

contracts/dao/VabbleNFT.sol#L29


## events-access
Impact: Low
Confidence: Medium
 - [ ] ID-81
[Ownablee.setup(address,address,address)](contracts/dao/Ownablee.sol#L69-L79) should emit an event for: 
	- [VOTE = _vote](contracts/dao/Ownablee.sol#L74) 
	- [VABBLE_DAO = _dao](contracts/dao/Ownablee.sol#L76) 
	- [STAKING_POOL = _stakingPool](contracts/dao/Ownablee.sol#L78) 

contracts/dao/Ownablee.sol#L69-L79


 - [ ] ID-82
[StakingPool.initialize(address,address,address)](contracts/dao/StakingPool.sol#L109-L119) should emit an event for: 
	- [VABBLE_DAO = _vabbleDAO](contracts/dao/StakingPool.sol#L114) 
	- [VOTE = _vote](contracts/dao/StakingPool.sol#L118) 

contracts/dao/StakingPool.sol#L109-L119


 - [ ] ID-83
[Vote.initialize(address,address,address,address)](contracts/dao/Vote.sol#L81-L97) should emit an event for: 
	- [STAKING_POOL = _stakingPool](contracts/dao/Vote.sol#L92) 

contracts/dao/Vote.sol#L81-L97


 - [ ] ID-84
[Ownablee.transferAuditor(address)](contracts/dao/Ownablee.sol#L81-L85) should emit an event for: 
	- [auditor = _newAuditor](contracts/dao/Ownablee.sol#L84) 

contracts/dao/Ownablee.sol#L81-L85


 - [ ] ID-85
[Ownablee.replaceAuditor(address)](contracts/dao/Ownablee.sol#L87-L90) should emit an event for: 
	- [auditor = _newAuditor](contracts/dao/Ownablee.sol#L89) 

contracts/dao/Ownablee.sol#L87-L90


## missing-zero-check
Impact: Low
Confidence: Medium
 - [ ] ID-86
[VabbleNFT.constructor(string,string,string,string,address)._factory](contracts/dao/VabbleNFT.sol#L30) lacks a zero-check on :
		- [FACTORY = _factory](contracts/dao/VabbleNFT.sol#L34)

contracts/dao/VabbleNFT.sol#L30


 - [ ] ID-87
[VabbleDAO.constructor(address,address,address,address,address,address)._ownable](contracts/dao/VabbleDAO.sol#L96) lacks a zero-check on :
		- [OWNABLE = _ownable](contracts/dao/VabbleDAO.sol#L103)

contracts/dao/VabbleDAO.sol#L96


 - [ ] ID-88
[VabbleDAO.constructor(address,address,address,address,address,address)._property](contracts/dao/VabbleDAO.sol#L100) lacks a zero-check on :
		- [DAO_PROPERTY = _property](contracts/dao/VabbleDAO.sol#L107)

contracts/dao/VabbleDAO.sol#L100


 - [ ] ID-89
[VabbleDAO.constructor(address,address,address,address,address,address)._staking](contracts/dao/VabbleDAO.sol#L99) lacks a zero-check on :
		- [STAKING_POOL = _staking](contracts/dao/VabbleDAO.sol#L106)

contracts/dao/VabbleDAO.sol#L99


 - [ ] ID-90
[VabbleDAO.constructor(address,address,address,address,address,address)._vabbleFund](contracts/dao/VabbleDAO.sol#L101) lacks a zero-check on :
		- [VABBLE_FUND = _vabbleFund](contracts/dao/VabbleDAO.sol#L108)

contracts/dao/VabbleDAO.sol#L101


 - [ ] ID-91
[VabbleDAO.constructor(address,address,address,address,address,address)._uniHelper](contracts/dao/VabbleDAO.sol#L97) lacks a zero-check on :
		- [UNI_HELPER = _uniHelper](contracts/dao/VabbleDAO.sol#L104)

contracts/dao/VabbleDAO.sol#L97


 - [ ] ID-92
[VabbleDAO.constructor(address,address,address,address,address,address)._vote](contracts/dao/VabbleDAO.sol#L98) lacks a zero-check on :
		- [VOTE = _vote](contracts/dao/VabbleDAO.sol#L105)

contracts/dao/VabbleDAO.sol#L98


## calls-loop
Impact: Low
Confidence: Medium
 - [ ] ID-93
[VabbleFund.fundProcess(uint256)](contracts/dao/VabbleFund.sol#L184-L236) has external calls inside a loop: [rewardSumAmount += IUniHelper(UNI_HELPER).swapAsset(swapArgs)](contracts/dao/VabbleFund.sol#L218)

contracts/dao/VabbleFund.sol#L184-L236


 - [ ] ID-94
[StakingPool.__rewardPercent(uint256)](contracts/dao/StakingPool.sol#L473-L476) has external calls inside a loop: [percent_ = (IProperty(DAO_PROPERTY).rewardRate() * poolPercent) / 1e10](contracts/dao/StakingPool.sol#L475)

contracts/dao/StakingPool.sol#L473-L476


 - [ ] ID-95
[Vote.__approveFilm(uint256)](contracts/dao/Vote.sol#L176-L203) has external calls inside a loop: [totalVoteCount >= IStakingPool(STAKING_POOL).getLimitCount() && fv.stakeAmount_1 > fv.stakeAmount_2](contracts/dao/Vote.sol#L188)

contracts/dao/Vote.sol#L176-L203


 - [ ] ID-96
[FilmMigration.parseFilm(string,string)](scripts/foundry/05_FilmMigration.s.sol#L55-L76) has external calls inside a loop: [film.enableClaimer = abi.decode(vm.parseJson(root,string(abi.encodePacked(basePath,.enableClaimer))),(uint256))](scripts/foundry/05_FilmMigration.s.sol#L64-L65)

scripts/foundry/05_FilmMigration.s.sol#L55-L76


 - [ ] ID-97
[VabbleFund.__getExpectedUsdcAmount(address,uint256)](contracts/dao/VabbleFund.sol#L344-L352) has external calls inside a loop: [amount_ = IUniHelper(UNI_HELPER).expectedAmount(_tokenAmount,_token,IOwnablee(OWNABLE).USDC_TOKEN())](contracts/dao/VabbleFund.sol#L350)

contracts/dao/VabbleFund.sol#L344-L352


 - [ ] ID-98
[FilmMigration.parseFilm(string,string)](scripts/foundry/05_FilmMigration.s.sol#L55-L76) has external calls inside a loop: [film.noVote = abi.decode(vm.parseJson(root,string(abi.encodePacked(basePath,.noVote))),(uint256))](scripts/foundry/05_FilmMigration.s.sol#L63)

scripts/foundry/05_FilmMigration.s.sol#L55-L76


 - [ ] ID-99
[FilmMigration.parseFilm(string,string)](scripts/foundry/05_FilmMigration.s.sol#L55-L76) has external calls inside a loop: [film.studio = abi.decode(vm.parseJson(root,string(abi.encodePacked(basePath,.studio))),(address))](scripts/foundry/05_FilmMigration.s.sol#L69)

scripts/foundry/05_FilmMigration.s.sol#L55-L76


 - [ ] ID-100
[FilmMigration.parseFilm(string,string)](scripts/foundry/05_FilmMigration.s.sol#L55-L76) has external calls inside a loop: [film.fundType = abi.decode(vm.parseJson(root,string(abi.encodePacked(basePath,.fundType))),(uint256))](scripts/foundry/05_FilmMigration.s.sol#L60)

scripts/foundry/05_FilmMigration.s.sol#L55-L76


 - [ ] ID-101
[Vote.__voteToFilm(uint256,uint256)](contracts/dao/Vote.sol#L113-L159) has external calls inside a loop: [require(bool,string)(__isVotePeriod(IProperty(DAO_PROPERTY).filmVotePeriod(),cTime),vF: elapsed period)](contracts/dao/Vote.sol#L126)

contracts/dao/Vote.sol#L113-L159


 - [ ] ID-102
[Vote.__approveFilm(uint256)](contracts/dao/Vote.sol#L176-L203) has external calls inside a loop: [IVabbleDAO(VABBLE_DAO).approveFilmByVote(_filmId,reason)](contracts/dao/Vote.sol#L200)

contracts/dao/Vote.sol#L176-L203


 - [ ] ID-103
[FactorySubNFT.__mint(address,address,uint256,uint256)](contracts/dao/FactorySubNFT.sol#L115-L144) has external calls inside a loop: [tokenId = subNFTContract.mintTo(receiver)](contracts/dao/FactorySubNFT.sol#L132)

contracts/dao/FactorySubNFT.sol#L115-L144


 - [ ] ID-104
[FilmMigration.parseFilm(string,string)](scripts/foundry/05_FilmMigration.s.sol#L55-L76) has external calls inside a loop: [film.description = abi.decode(vm.parseJson(root,string(abi.encodePacked(basePath,.description))),(string))](scripts/foundry/05_FilmMigration.s.sol#L57)

scripts/foundry/05_FilmMigration.s.sol#L55-L76


 - [ ] ID-105
[FilmMigration.parseFilm(string,string)](scripts/foundry/05_FilmMigration.s.sol#L55-L76) has external calls inside a loop: [film.status = Helper.Status(abi.decode(vm.parseJson(root,string(abi.encodePacked(basePath,.status))),(uint256)))](scripts/foundry/05_FilmMigration.s.sol#L70-L71)

scripts/foundry/05_FilmMigration.s.sol#L55-L76


 - [ ] ID-106
[FilmMigration.parseFilm(string,string)](scripts/foundry/05_FilmMigration.s.sol#L55-L76) has external calls inside a loop: [film.pCreateTime = abi.decode(vm.parseJson(root,string(abi.encodePacked(basePath,.pCreateTime))),(uint256))](scripts/foundry/05_FilmMigration.s.sol#L66)

scripts/foundry/05_FilmMigration.s.sol#L55-L76


 - [ ] ID-107
[FactoryFilmNFT.__mint(uint256)](contracts/dao/FactoryFilmNFT.sol#L158-L165) has external calls inside a loop: [tokenId = t.mintTo(msg.sender)](contracts/dao/FactoryFilmNFT.sol#L160)

contracts/dao/FactoryFilmNFT.sol#L158-L165


 - [ ] ID-108
[Helper.safeTransfer(address,address,uint256)](contracts/libraries/Helper.sol#L36-L44) has external calls inside a loop: [(success,data) = token.call(abi.encodeWithSelector(0xa9059cbb,to,value))](contracts/libraries/Helper.sol#L42)

contracts/libraries/Helper.sol#L36-L44


 - [ ] ID-109
[VabbleFund.withdrawFunding(uint256)](contracts/dao/VabbleFund.sol#L239-L272) has external calls inside a loop: [IERC20(assetArr[i].token).balanceOf(address(this)) >= assetArr[i].amount](contracts/dao/VabbleFund.sol#L259)

contracts/dao/VabbleFund.sol#L239-L272


 - [ ] ID-110
[VabbleDAO.__setFinalFilm(uint256,uint256)](contracts/dao/VabbleDAO.sol#L477-L504) has external calls inside a loop: [! IVabbleFund(VABBLE_FUND).isRaisedFullAmount(_filmId)](contracts/dao/VabbleDAO.sol#L491)

contracts/dao/VabbleDAO.sol#L477-L504


 - [ ] ID-111
[FactorySubNFT.__mint(address,address,uint256,uint256)](contracts/dao/FactorySubNFT.sol#L115-L144) has external calls inside a loop: [_token != IOwnablee(OWNABLE).PAYOUT_TOKEN() && _token != address(0)](contracts/dao/FactorySubNFT.sol#L121)

contracts/dao/FactorySubNFT.sol#L115-L144


 - [ ] ID-112
[FilmMigration.parseFilm(string,string)](scripts/foundry/05_FilmMigration.s.sol#L55-L76) has external calls inside a loop: [film.sharePercents = abi.decode(vm.parseJson(root,string(abi.encodePacked(basePath,.sharePercents))),(uint256[]))](scripts/foundry/05_FilmMigration.s.sol#L72-L73)

scripts/foundry/05_FilmMigration.s.sol#L55-L76


 - [ ] ID-113
[FactorySubNFT.getTotalSupply()](contracts/dao/FactorySubNFT.sol#L252-L254) has external calls inside a loop: [subNFTContract.totalSupply()](contracts/dao/FactorySubNFT.sol#L253)

contracts/dao/FactorySubNFT.sol#L252-L254


 - [ ] ID-114
[FilmMigration.run()](scripts/foundry/05_FilmMigration.s.sol#L18-L53) has external calls inside a loop: [basePath = string(abi.encodePacked([,vm.toString(i),]))](scripts/foundry/05_FilmMigration.s.sol#L44)

scripts/foundry/05_FilmMigration.s.sol#L18-L53


 - [ ] ID-115
[FactorySubNFT.__mint(address,address,uint256,uint256)](contracts/dao/FactorySubNFT.sol#L115-L144) has external calls inside a loop: [require(bool,string)(IOwnablee(OWNABLE).isDepositAsset(_token),mint: not allowed asset)](contracts/dao/FactorySubNFT.sol#L122)

contracts/dao/FactorySubNFT.sol#L115-L144


 - [ ] ID-116
[VabbleFund.fundProcess(uint256)](contracts/dao/VabbleFund.sol#L184-L236) has external calls inside a loop: [Helper.safeApprove(assetArr[i].token,UNI_HELPER,IERC20(assetArr[i].token).totalSupply())](contracts/dao/VabbleFund.sol#L214)

contracts/dao/VabbleFund.sol#L184-L236


 - [ ] ID-117
[FilmMigration.parseFilm(string,string)](scripts/foundry/05_FilmMigration.s.sol#L55-L76) has external calls inside a loop: [film.pApproveTime = abi.decode(vm.parseJson(root,string(abi.encodePacked(basePath,.pApproveTime))),(uint256))](scripts/foundry/05_FilmMigration.s.sol#L67-L68)

scripts/foundry/05_FilmMigration.s.sol#L55-L76


 - [ ] ID-118
[FilmMigration.parseFilm(string,string)](scripts/foundry/05_FilmMigration.s.sol#L55-L76) has external calls inside a loop: [film.rewardPercent = abi.decode(vm.parseJson(root,string(abi.encodePacked(basePath,.rewardPercent))),(uint256))](scripts/foundry/05_FilmMigration.s.sol#L61-L62)

scripts/foundry/05_FilmMigration.s.sol#L55-L76


 - [ ] ID-119
[StakingPool.__calcRewards(address,uint256,uint256)](contracts/dao/StakingPool.sol#L454-L469) has external calls inside a loop: [amount_ += (amount_ * IProperty(DAO_PROPERTY).boardRewardRate()) / 1e10](contracts/dao/StakingPool.sol#L467)

contracts/dao/StakingPool.sol#L454-L469


 - [ ] ID-120
[VabbleFund.fundProcess(uint256)](contracts/dao/VabbleFund.sol#L184-L236) has external calls inside a loop: [rewardAmount = assetArr[i].amount * IProperty(DAO_PROPERTY).fundFeePercent() / 1e10](contracts/dao/VabbleFund.sol#L206)

contracts/dao/VabbleFund.sol#L184-L236


 - [ ] ID-121
[Vote.__voteToFilm(uint256,uint256)](contracts/dao/Vote.sol#L113-L159) has external calls inside a loop: [(cTime,None) = IVabbleDAO(VABBLE_DAO).getFilmProposalTime(_filmId)](contracts/dao/Vote.sol#L124)

contracts/dao/Vote.sol#L113-L159


 - [ ] ID-122
[Vote.__approveFilm(uint256)](contracts/dao/Vote.sol#L176-L203) has external calls inside a loop: [(pCreateTime,pApproveTime) = IVabbleDAO(VABBLE_DAO).getFilmProposalTime(_filmId)](contracts/dao/Vote.sol#L181)

contracts/dao/Vote.sol#L176-L203


 - [ ] ID-123
[FilmMigration.parseFilm(string,string)](scripts/foundry/05_FilmMigration.s.sol#L55-L76) has external calls inside a loop: [film.studioPayees = abi.decode(vm.parseJson(root,string(abi.encodePacked(basePath,.studioPayees))),(address[]))](scripts/foundry/05_FilmMigration.s.sol#L74-L75)

scripts/foundry/05_FilmMigration.s.sol#L55-L76


 - [ ] ID-124
[Vote.__approveFilm(uint256)](contracts/dao/Vote.sol#L176-L203) has external calls inside a loop: [totalVoteCount < IStakingPool(STAKING_POOL).getLimitCount()](contracts/dao/Vote.sol#L191)

contracts/dao/Vote.sol#L176-L203


 - [ ] ID-125
[FilmMigration.parseFilm(string,string)](scripts/foundry/05_FilmMigration.s.sol#L55-L76) has external calls inside a loop: [film.title = abi.decode(vm.parseJson(root,string(abi.encodePacked(basePath,.title))),(string))](scripts/foundry/05_FilmMigration.s.sol#L56)

scripts/foundry/05_FilmMigration.s.sol#L55-L76


 - [ ] ID-126
[Vote.__voteToFilm(uint256,uint256)](contracts/dao/Vote.sol#L113-L159) has external calls inside a loop: [require(bool,string)(msg.sender != IVabbleDAO(VABBLE_DAO).getFilmOwner(_filmId),vF: film owner)](contracts/dao/Vote.sol#L117)

contracts/dao/Vote.sol#L113-L159


 - [ ] ID-127
[VabbleDAO.__setFinalAmountToHelpers(uint256,uint256,uint256)](contracts/dao/VabbleDAO.sol#L519-L534) has external calls inside a loop: [investors = IVabbleFund(VABBLE_FUND).getFilmInvestorList(_filmId)](contracts/dao/VabbleDAO.sol#L522)

contracts/dao/VabbleDAO.sol#L519-L534


 - [ ] ID-128
[VabbleDAO.__setFinalAmountToHelpers(uint256,uint256,uint256)](contracts/dao/VabbleDAO.sol#L519-L534) has external calls inside a loop: [userAmount = IVabbleFund(VABBLE_FUND).getUserFundAmountPerFilm(investors[i],_filmId)](contracts/dao/VabbleDAO.sol#L524)

contracts/dao/VabbleDAO.sol#L519-L534


 - [ ] ID-129
[VabbleFund.__getExpectedUsdcAmount(address,uint256)](contracts/dao/VabbleFund.sol#L344-L352) has external calls inside a loop: [_token != IOwnablee(OWNABLE).USDC_TOKEN()](contracts/dao/VabbleFund.sol#L349)

contracts/dao/VabbleFund.sol#L344-L352


 - [ ] ID-130
[StakingPool.__calcRewards(address,uint256,uint256)](contracts/dao/StakingPool.sol#L454-L469) has external calls inside a loop: [IProperty(DAO_PROPERTY).checkGovWhitelist(2,_user) == 2](contracts/dao/StakingPool.sol#L466)

contracts/dao/StakingPool.sol#L454-L469


 - [ ] ID-131
[Vote.__voteToFilm(uint256,uint256)](contracts/dao/Vote.sol#L113-L159) has external calls inside a loop: [IStakingPool(STAKING_POOL).addVotedData(msg.sender,block.timestamp,proposalFilmIds[_filmId])](contracts/dao/Vote.sol#L154-L156)

contracts/dao/Vote.sol#L113-L159


 - [ ] ID-132
[FilmMigration.parseFilm(string,string)](scripts/foundry/05_FilmMigration.s.sol#L55-L76) has external calls inside a loop: [film.raiseAmount = abi.decode(vm.parseJson(root,string(abi.encodePacked(basePath,.raiseAmount))),(uint256))](scripts/foundry/05_FilmMigration.s.sol#L58)

scripts/foundry/05_FilmMigration.s.sol#L55-L76


 - [ ] ID-133
[Vote.__voteToFilm(uint256,uint256)](contracts/dao/Vote.sol#L113-L159) has external calls inside a loop: [status = IVabbleDAO(VABBLE_DAO).getFilmStatus(_filmId)](contracts/dao/Vote.sol#L121)

contracts/dao/Vote.sol#L113-L159


 - [ ] ID-134
[Vote.__voteToFilm(uint256,uint256)](contracts/dao/Vote.sol#L113-L159) has external calls inside a loop: [stakeAmount += stakeAmount * IProperty(DAO_PROPERTY).boardVoteWeight() / 1e10](contracts/dao/Vote.sol#L133)

contracts/dao/Vote.sol#L113-L159


 - [ ] ID-135
[VabbleDAO.__setFinalAmountToHelpers(uint256,uint256,uint256)](contracts/dao/VabbleDAO.sol#L519-L534) has external calls inside a loop: [raisedAmount = IVabbleFund(VABBLE_FUND).getTotalFundAmountPerFilm(_filmId)](contracts/dao/VabbleDAO.sol#L520)

contracts/dao/VabbleDAO.sol#L519-L534


 - [ ] ID-136
[StakingPool.__transferVABWithdraw(address)](contracts/dao/StakingPool.sol#L571-L584) has external calls inside a loop: [Helper.safeTransfer(IOwnablee(OWNABLE).PAYOUT_TOKEN(),_to,payAmount)](contracts/dao/StakingPool.sol#L577)

contracts/dao/StakingPool.sol#L571-L584


 - [ ] ID-137
[Vote.__voteToFilm(uint256,uint256)](contracts/dao/Vote.sol#L113-L159) has external calls inside a loop: [(None,None,fundType,None) = IVabbleDAO(VABBLE_DAO).getFilmFund(_filmId)](contracts/dao/Vote.sol#L129)

contracts/dao/Vote.sol#L113-L159


 - [ ] ID-138
[Vote.__approveFilm(uint256)](contracts/dao/Vote.sol#L176-L203) has external calls inside a loop: [require(bool,string)(! __isVotePeriod(IProperty(DAO_PROPERTY).filmVotePeriod(),pCreateTime),aF: vote period yet)](contracts/dao/Vote.sol#L182)

contracts/dao/Vote.sol#L176-L203


 - [ ] ID-139
[Vote.__approveFilm(uint256)](contracts/dao/Vote.sol#L176-L203) has external calls inside a loop: [(None,None,fundType,None) = IVabbleDAO(VABBLE_DAO).getFilmFund(_filmId)](contracts/dao/Vote.sol#L185)

contracts/dao/Vote.sol#L176-L203


 - [ ] ID-140
[FilmMigration.parseFilm(string,string)](scripts/foundry/05_FilmMigration.s.sol#L55-L76) has external calls inside a loop: [film.fundPeriod = abi.decode(vm.parseJson(root,string(abi.encodePacked(basePath,.fundPeriod))),(uint256))](scripts/foundry/05_FilmMigration.s.sol#L59)

scripts/foundry/05_FilmMigration.s.sol#L55-L76


 - [ ] ID-141
[Vote.__voteToFilm(uint256,uint256)](contracts/dao/Vote.sol#L113-L159) has external calls inside a loop: [stakeAmount = IStakingPool(STAKING_POOL).getStakeAmount(msg.sender)](contracts/dao/Vote.sol#L128)

contracts/dao/Vote.sol#L113-L159


 - [ ] ID-142
[VabbleFund.fundProcess(uint256)](contracts/dao/VabbleFund.sol#L184-L236) has external calls inside a loop: [IERC20(assetArr[i].token).allowance(address(this),UNI_HELPER) == 0](contracts/dao/VabbleFund.sol#L213)

contracts/dao/VabbleFund.sol#L184-L236


 - [ ] ID-143
[Vote.__voteToFilm(uint256,uint256)](contracts/dao/Vote.sol#L113-L159) has external calls inside a loop: [IProperty(DAO_PROPERTY).checkGovWhitelist(2,msg.sender) == 2](contracts/dao/Vote.sol#L132)

contracts/dao/Vote.sol#L113-L159


## reentrancy-benign
Impact: Low
Confidence: Medium
 - [ ] ID-144
Reentrancy in [Property.proposalFilmBoard(address,string,string)](contracts/dao/Property.sol#L287-L318):
	External calls:
	- [__paidFee(proposalFeeAmount)](contracts/dao/Property.sol#L299)
		- [(success,data) = token.call(abi.encodeWithSelector(0x23b872dd,from,to,value))](contracts/libraries/Helper.sol#L53)
		- [(success,data) = token.call(abi.encodeWithSelector(0x095ea7b3,to,value))](contracts/libraries/Helper.sol#L32)
		- [Helper.safeTransferFrom(vabToken,msg.sender,address(this),expectVABAmount)](contracts/dao/Property.sol#L244)
		- [Helper.safeApprove(vabToken,STAKING_POOL,IERC20(vabToken).totalSupply())](contracts/dao/Property.sol#L246)
		- [IStakingPool(STAKING_POOL).addRewardToPool(expectVABAmount)](contracts/dao/Property.sol#L248)
	State variables written after the call(s):
	- [bp.title = _title](contracts/dao/Property.sol#L302)
	- [bp.description = _description](contracts/dao/Property.sol#L303)
	- [bp.createTime = block.timestamp](contracts/dao/Property.sol#L304)
	- [bp.value = _member](contracts/dao/Property.sol#L305)
	- [bp.creator = msg.sender](contracts/dao/Property.sol#L306)
	- [bp.status = Helper.Status.LISTED](contracts/dao/Property.sol#L307)

contracts/dao/Property.sol#L287-L318


 - [ ] ID-145
Reentrancy in [Vote.updateProperty(uint256,uint256)](contracts/dao/Vote.sol#L513-L543):
	External calls:
	- [IProperty(DAO_PROPERTY).updatePropertyProposal(_index,_flag,1)](contracts/dao/Vote.sol#L529)
	State variables written after the call(s):
	- [govPassedVoteCount[5] += 1](contracts/dao/Vote.sol#L530)

contracts/dao/Vote.sol#L513-L543


 - [ ] ID-146
Reentrancy in [StakingPool.unstakeVAB(uint256)](contracts/dao/StakingPool.sol#L156-L185):
	External calls:
	- [__withdrawReward(rewardAmount)](contracts/dao/StakingPool.sol#L167)
		- [Helper.safeTransfer(IOwnablee(OWNABLE).PAYOUT_TOKEN(),msg.sender,_amount)](contracts/dao/StakingPool.sol#L222)
		- [(success,data) = token.call(abi.encodeWithSelector(0xa9059cbb,to,value))](contracts/libraries/Helper.sol#L42)
	- [Helper.safeTransfer(IOwnablee(OWNABLE).PAYOUT_TOKEN(),msg.sender,_amount)](contracts/dao/StakingPool.sol#L171)
	State variables written after the call(s):
	- [__stakerRemove(msg.sender)](contracts/dao/StakingPool.sol#L181)
		- [stakerMap.indexOf[lastKey] = index](contracts/dao/StakingPool.sol#L831)
		- [delete stakerMap.indexOf[key]](contracts/dao/StakingPool.sol#L832)
		- [stakerMap.keys[index - 1] = lastKey](contracts/dao/StakingPool.sol#L834)
		- [stakerMap.keys.pop()](contracts/dao/StakingPool.sol#L835)

contracts/dao/StakingPool.sol#L156-L185


 - [ ] ID-147
Reentrancy in [Property.updateGovProposal(uint256,uint256,uint256)](contracts/dao/Property.sol#L641-L676):
	External calls:
	- [IStakingPool(STAKING_POOL).calcMigrationVAB()](contracts/dao/Property.sol#L670)
	State variables written after the call(s):
	- [filmBoardMembers.push(member)](contracts/dao/Property.sol#L674)

contracts/dao/Property.sol#L641-L676


 - [ ] ID-148
Reentrancy in [DeployerScript.run()](scripts/foundry/01_Deploy.s.sol#L69-L73):
	External calls:
	- [vm.startBroadcast()](scripts/foundry/01_Deploy.s.sol#L70)
	- [deployForMainOrTestnet()](scripts/foundry/01_Deploy.s.sol#L71)
		- [activeConfig = helperConfig.getActiveNetworkConfig()](scripts/foundry/01_Deploy.s.sol#L129)
		- [_factoryFilmNFT.initialize(address(_vabbleDAO),address(_vabbleFund))](scripts/foundry/01_Deploy.s.sol#L207)
		- [_stakingPool.initialize(address(_vabbleDAO),address(_property),address(_vote))](scripts/foundry/01_Deploy.s.sol#L208)
		- [_vote.initialize(address(_vabbleDAO),address(_stakingPool),address(_property),address(_uniHelper))](scripts/foundry/01_Deploy.s.sol#L209)
		- [_vabbleFund.initialize(address(_vabbleDAO))](scripts/foundry/01_Deploy.s.sol#L210)
		- [_uniHelper.setWhiteList(address(_vabbleDAO),address(_vabbleFund),address(_subscription),address(_factoryFilmNFT),address(_factorySubNFT))](scripts/foundry/01_Deploy.s.sol#L211-L217)
		- [_ownablee.setup(address(_vote),address(_vabbleDAO),address(_stakingPool))](scripts/foundry/01_Deploy.s.sol#L218)
		- [_ownablee.addDepositAsset(depositAssets)](scripts/foundry/01_Deploy.s.sol#L219)
	State variables written after the call(s):
	- [deployForMainOrTestnet()](scripts/foundry/01_Deploy.s.sol#L71)
		- [usdt = activeConfig.networkConfig.usdt](scripts/foundry/01_Deploy.s.sol#L133)

scripts/foundry/01_Deploy.s.sol#L69-L73


 - [ ] ID-149
Reentrancy in [VabbleFund.depositToFilm(uint256,uint256,uint256,address)](contracts/dao/VabbleFund.sol#L78-L116):
	External calls:
	- [Helper.safeTransferETH(msg.sender,msg.value - tokenAmount)](contracts/dao/VabbleFund.sol#L108)
	- [Helper.safeTransferFrom(_token,msg.sender,address(this),tokenAmount)](contracts/dao/VabbleFund.sol#L110)
	State variables written after the call(s):
	- [__assignToken(_filmId,_token,tokenAmount)](contracts/dao/VabbleFund.sol#L113)
		- [assetPerFilm[_filmId][i_scope_0].amount += _amount](contracts/dao/VabbleFund.sol#L174)
		- [assetPerFilm[_filmId].push(Asset({token:_token,amount:_amount}))](contracts/dao/VabbleFund.sol#L179)

contracts/dao/VabbleFund.sol#L78-L116


 - [ ] ID-150
Reentrancy in [VabbleDAO.allocateFromEdgePool(uint256)](contracts/dao/VabbleDAO.sol#L400-L414):
	External calls:
	- [IOwnablee(OWNABLE).addToStudioPool(_amount)](contracts/dao/VabbleDAO.sol#L404)
	State variables written after the call(s):
	- [StudioPool += _amount](contracts/dao/VabbleDAO.sol#L405)
	- [studioPoolUsers.push(edgePoolUsers[i])](contracts/dao/VabbleDAO.sol#L410)

contracts/dao/VabbleDAO.sol#L400-L414


 - [ ] ID-151
Reentrancy in [Property.proposalAuditor(address,string,string)](contracts/dao/Property.sol#L201-L233):
	External calls:
	- [__paidFee(proposalFeeAmount)](contracts/dao/Property.sol#L214)
		- [(success,data) = token.call(abi.encodeWithSelector(0x23b872dd,from,to,value))](contracts/libraries/Helper.sol#L53)
		- [(success,data) = token.call(abi.encodeWithSelector(0x095ea7b3,to,value))](contracts/libraries/Helper.sol#L32)
		- [Helper.safeTransferFrom(vabToken,msg.sender,address(this),expectVABAmount)](contracts/dao/Property.sol#L244)
		- [Helper.safeApprove(vabToken,STAKING_POOL,IERC20(vabToken).totalSupply())](contracts/dao/Property.sol#L246)
		- [IStakingPool(STAKING_POOL).addRewardToPool(expectVABAmount)](contracts/dao/Property.sol#L248)
	State variables written after the call(s):
	- [ap.title = _title](contracts/dao/Property.sol#L217)
	- [ap.description = _description](contracts/dao/Property.sol#L218)
	- [ap.createTime = block.timestamp](contracts/dao/Property.sol#L219)
	- [ap.value = _agent](contracts/dao/Property.sol#L220)
	- [ap.creator = msg.sender](contracts/dao/Property.sol#L221)
	- [ap.status = Helper.Status.LISTED](contracts/dao/Property.sol#L222)

contracts/dao/Property.sol#L201-L233


 - [ ] ID-152
Reentrancy in [FactorySubNFT.__mint(address,address,uint256,uint256)](contracts/dao/FactorySubNFT.sol#L115-L144):
	External calls:
	- [tokenId = subNFTContract.mintTo(receiver)](contracts/dao/FactorySubNFT.sol#L132)
	State variables written after the call(s):
	- [sInfo.subscriptionPeriod = _subPeriod](contracts/dao/FactorySubNFT.sol#L135)
	- [sInfo.lockPeriod = nftLockPeriod](contracts/dao/FactorySubNFT.sol#L136)
	- [sInfo.minter = msg.sender](contracts/dao/FactorySubNFT.sol#L137)
	- [sInfo.category = _category](contracts/dao/FactorySubNFT.sol#L138)
	- [sInfo.lockTime = block.timestamp](contracts/dao/FactorySubNFT.sol#L139)
	- [subNFTTokenList[receiver].push(tokenId)](contracts/dao/FactorySubNFT.sol#L141)

contracts/dao/FactorySubNFT.sol#L115-L144


 - [ ] ID-153
Reentrancy in [Property.proposalFilmBoard(address,string,string)](contracts/dao/Property.sol#L287-L318):
	External calls:
	- [__paidFee(proposalFeeAmount)](contracts/dao/Property.sol#L299)
		- [(success,data) = token.call(abi.encodeWithSelector(0x23b872dd,from,to,value))](contracts/libraries/Helper.sol#L53)
		- [(success,data) = token.call(abi.encodeWithSelector(0x095ea7b3,to,value))](contracts/libraries/Helper.sol#L32)
		- [Helper.safeTransferFrom(vabToken,msg.sender,address(this),expectVABAmount)](contracts/dao/Property.sol#L244)
		- [Helper.safeApprove(vabToken,STAKING_POOL,IERC20(vabToken).totalSupply())](contracts/dao/Property.sol#L246)
		- [IStakingPool(STAKING_POOL).addRewardToPool(expectVABAmount)](contracts/dao/Property.sol#L248)
	- [bp.proposalID = IStakingPool(STAKING_POOL).addProposalData(msg.sender,block.timestamp,boardVotePeriod)](contracts/dao/Property.sol#L309)
	State variables written after the call(s):
	- [allGovProposalInfo[2].push(_member)](contracts/dao/Property.sol#L314)
	- [governanceProposalCount += 1](contracts/dao/Property.sol#L312)
	- [userGovProposalCount[msg.sender] += 1](contracts/dao/Property.sol#L313)

contracts/dao/Property.sol#L287-L318


 - [ ] ID-154
Reentrancy in [Subscription.activeSubscription(address,uint256)](contracts/dao/Subscription.sol#L200-L212):
	External calls:
	- [_handlePayment(_token,expectedAmount)](contracts/dao/Subscription.sol#L203)
		- [(success,None) = to.call{value: value}(new bytes(0))](contracts/libraries/Helper.sol#L58)
		- [(success,data) = token.call(abi.encodeWithSelector(0x23b872dd,from,to,value))](contracts/libraries/Helper.sol#L53)
		- [Helper.safeTransferETH(msg.sender,msg.value - expectedAmount)](contracts/dao/Subscription.sol#L283)
		- [Helper.safeTransferFrom(_token,msg.sender,address(this),expectedAmount)](contracts/dao/Subscription.sol#L286)
	- [_handleSwapsAndTransfers(_token,expectedAmount)](contracts/dao/Subscription.sol#L206)
		- [(success,None) = to.call{value: value}(new bytes(0))](contracts/libraries/Helper.sol#L58)
		- [Helper.safeTransferETH(UNI_HELPER,amount60)](contracts/dao/Subscription.sol#L294)
		- [(success,data) = token.call(abi.encodeWithSelector(0x095ea7b3,to,value))](contracts/libraries/Helper.sol#L32)
		- [(success,data) = token.call(abi.encodeWithSelector(0xa9059cbb,to,value))](contracts/libraries/Helper.sol#L42)
		- [Helper.safeApprove(_token,UNI_HELPER,expectedAmount)](contracts/dao/Subscription.sol#L297)
		- [vabAmount = IUniHelper(UNI_HELPER).swapAsset(abi.encode(amount60,_token,VAB_TOKEN))](contracts/dao/Subscription.sol#L302)
		- [Helper.safeApprove(VAB_TOKEN,STAKING_POOL,vabAmount)](contracts/dao/Subscription.sol#L304)
		- [IStakingPool(STAKING_POOL).depositVABTo(msg.sender,vabAmount)](contracts/dao/Subscription.sol#L307)
		- [Helper.safeTransfer(USDC_TOKEN,VAB_WALLET,usdcAmount)](contracts/dao/Subscription.sol#L311)
	External calls sending eth:
	- [_handlePayment(_token,expectedAmount)](contracts/dao/Subscription.sol#L203)
		- [(success,None) = to.call{value: value}(new bytes(0))](contracts/libraries/Helper.sol#L58)
	- [_handleSwapsAndTransfers(_token,expectedAmount)](contracts/dao/Subscription.sol#L206)
		- [(success,None) = to.call{value: value}(new bytes(0))](contracts/libraries/Helper.sol#L58)
	State variables written after the call(s):
	- [_updateSubscription(_period)](contracts/dao/Subscription.sol#L209)
		- [subscription.period += _period](contracts/dao/Subscription.sol#L320)
		- [subscription.expireTime = subscription.activeTime + PERIOD_UNIT * subscription.period](contracts/dao/Subscription.sol#L321)
		- [subscription.activeTime = currentTime](contracts/dao/Subscription.sol#L324)
		- [subscription.period = _period](contracts/dao/Subscription.sol#L325)
		- [subscription.expireTime = currentTime + PERIOD_UNIT * _period](contracts/dao/Subscription.sol#L326)

contracts/dao/Subscription.sol#L200-L212


 - [ ] ID-155
Reentrancy in [FactoryFilmNFT.__mint(uint256)](contracts/dao/FactoryFilmNFT.sol#L158-L165):
	External calls:
	- [tokenId = t.mintTo(msg.sender)](contracts/dao/FactoryFilmNFT.sol#L160)
	State variables written after the call(s):
	- [filmNFTTokenList[_filmId].push(tokenId)](contracts/dao/FactoryFilmNFT.sol#L162)

contracts/dao/FactoryFilmNFT.sol#L158-L165


 - [ ] ID-156
Reentrancy in [Vote.updateAgentStats(uint256)](contracts/dao/Vote.sol#L240-L269):
	External calls:
	- [IProperty(DAO_PROPERTY).updateGovProposal(_index,1,1)](contracts/dao/Vote.sol#L254)
	State variables written after the call(s):
	- [govPassedVoteCount[1] += 1](contracts/dao/Vote.sol#L255)

contracts/dao/Vote.sol#L240-L269


 - [ ] ID-157
Reentrancy in [Vote.setDAORewardAddress(uint256)](contracts/dao/Vote.sol#L445-L473):
	External calls:
	- [IProperty(DAO_PROPERTY).updateGovProposal(_index,3,1)](contracts/dao/Vote.sol#L459)
	State variables written after the call(s):
	- [govPassedVoteCount[4] += 1](contracts/dao/Vote.sol#L460)

contracts/dao/Vote.sol#L445-L473


 - [ ] ID-158
Reentrancy in [VabbleDAO.allocateToPool(address[],uint256[],uint256)](contracts/dao/VabbleDAO.sol#L362-L397):
	External calls:
	- [IStakingPool(STAKING_POOL).sendVAB(_users,OWNABLE,_amounts)](contracts/dao/VabbleDAO.sol#L377)
	- [StudioPool += IStakingPool(STAKING_POOL).sendVAB(_users,address(this),_amounts)](contracts/dao/VabbleDAO.sol#L379)
	State variables written after the call(s):
	- [edgePoolUsers.push(_users[i])](contracts/dao/VabbleDAO.sol#L387)
	- [isEdgePoolUser[_users[i]] = true](contracts/dao/VabbleDAO.sol#L386)
	- [isStudioPoolUser[_users[i]] = true](contracts/dao/VabbleDAO.sol#L391)
	- [studioPoolUsers.push(_users[i])](contracts/dao/VabbleDAO.sol#L392)

contracts/dao/VabbleDAO.sol#L362-L397


 - [ ] ID-159
Reentrancy in [Property.proposalRewardFund(address,string,string)](contracts/dao/Property.sol#L252-L283):
	External calls:
	- [__paidFee(10 * proposalFeeAmount)](contracts/dao/Property.sol#L264)
		- [(success,data) = token.call(abi.encodeWithSelector(0x23b872dd,from,to,value))](contracts/libraries/Helper.sol#L53)
		- [(success,data) = token.call(abi.encodeWithSelector(0x095ea7b3,to,value))](contracts/libraries/Helper.sol#L32)
		- [Helper.safeTransferFrom(vabToken,msg.sender,address(this),expectVABAmount)](contracts/dao/Property.sol#L244)
		- [Helper.safeApprove(vabToken,STAKING_POOL,IERC20(vabToken).totalSupply())](contracts/dao/Property.sol#L246)
		- [IStakingPool(STAKING_POOL).addRewardToPool(expectVABAmount)](contracts/dao/Property.sol#L248)
	- [rp.proposalID = IStakingPool(STAKING_POOL).addProposalData(msg.sender,block.timestamp,rewardVotePeriod)](contracts/dao/Property.sol#L274)
	State variables written after the call(s):
	- [allGovProposalInfo[3].push(_rewardAddress)](contracts/dao/Property.sol#L279)
	- [governanceProposalCount += 1](contracts/dao/Property.sol#L277)
	- [userGovProposalCount[msg.sender] += 1](contracts/dao/Property.sol#L278)

contracts/dao/Property.sol#L252-L283


 - [ ] ID-160
Reentrancy in [DeployerScript.deployForMainOrTestnet()](scripts/foundry/01_Deploy.s.sol#L78-L82):
	External calls:
	- [_getConfig()](scripts/foundry/01_Deploy.s.sol#L79)
		- [activeConfig = helperConfig.getActiveNetworkConfig()](scripts/foundry/01_Deploy.s.sol#L129)
	State variables written after the call(s):
	- [_deployAllContracts(vabbleWallet,auditor)](scripts/foundry/01_Deploy.s.sol#L80)
		- [contracts.uniHelper = new UniHelper(_uniswapFactory,_uniswapRouter,_ownablee)](scripts/foundry/01_Deploy.s.sol#L231)
		- [contracts.vote = new Vote(_ownablee)](scripts/foundry/01_Deploy.s.sol#L239)
		- [contracts.vabbleFund = new VabbleFund(_ownablee,_uniHelper,_stakingPool,_property,_factoryFilmNFT)](scripts/foundry/01_Deploy.s.sol#L272)
		- [contracts.ownablee = new Ownablee(_vabWallet,_vab,_usdc,_auditor)](scripts/foundry/01_Deploy.s.sol#L227)
		- [contracts.factoryFilmNFT = new FactoryFilmNFT(_ownablee)](scripts/foundry/01_Deploy.s.sol#L256)
		- [contracts.vabbleDAO = new VabbleDAO(_ownablee,_uniHelper,_vote,_stakingPool,_property,_vabbleFund)](scripts/foundry/01_Deploy.s.sol#L285)
		- [contracts.subscription = new Subscription(_ownablee,_uniHelper,_property,stakingPool,discountPercents)](scripts/foundry/01_Deploy.s.sol#L300)
		- [contracts.property = new Property(_ownablee,_uniHelper,_vote,_stakingPool,propertyTimePeriodConfig,propertyRatesConfig,propertyAmountsConfig,propertyMinMaxListConfig)](scripts/foundry/01_Deploy.s.sol#L243-L252)
		- [contracts.factorySubNFT = new FactorySubNFT(_ownablee,_uniHelper)](scripts/foundry/01_Deploy.s.sol#L260)
		- [contracts.factoryTierNFT = new FactoryTierNFT(_ownablee,_vabbleDAO,_vabbleFund)](scripts/foundry/01_Deploy.s.sol#L289)
		- [contracts.stakingPool = new StakingPool(_ownablee)](scripts/foundry/01_Deploy.s.sol#L235)

scripts/foundry/01_Deploy.s.sol#L78-L82


 - [ ] ID-161
Reentrancy in [FactoryTierNFT.mintTierNft(uint256)](contracts/dao/FactoryTierNFT.sol#L135-L164):
	External calls:
	- [tokenId = t.mintTo(msg.sender)](contracts/dao/FactoryTierNFT.sol#L160)
	State variables written after the call(s):
	- [tierNFTTokenList[_filmId][tier].push(tokenId)](contracts/dao/FactoryTierNFT.sol#L161)

contracts/dao/FactoryTierNFT.sol#L135-L164


 - [ ] ID-162
Reentrancy in [DeployerScript._getConfig()](scripts/foundry/01_Deploy.s.sol#L127-L145):
	External calls:
	- [activeConfig = helperConfig.getActiveNetworkConfig()](scripts/foundry/01_Deploy.s.sol#L129)
	State variables written after the call(s):
	- [auditor = activeConfig.networkConfig.auditor](scripts/foundry/01_Deploy.s.sol#L134)
	- [depositAssets = activeConfig.networkConfig.depositAssets](scripts/foundry/01_Deploy.s.sol#L139)
	- [discountPercents = activeConfig.networkConfig.discountPercents](scripts/foundry/01_Deploy.s.sol#L138)
	- [propertyAmountsConfig = activeConfig.propertyAmountsConfig](scripts/foundry/01_Deploy.s.sol#L143)
	- [propertyMinMaxListConfig = activeConfig.propertyMinMaxListConfig](scripts/foundry/01_Deploy.s.sol#L144)
	- [propertyRatesConfig = activeConfig.propertyRatesConfig](scripts/foundry/01_Deploy.s.sol#L142)
	- [propertyTimePeriodConfig = activeConfig.propertyTimePeriodConfig](scripts/foundry/01_Deploy.s.sol#L141)
	- [uniswapFactory = activeConfig.networkConfig.uniswapFactory](scripts/foundry/01_Deploy.s.sol#L136)
	- [uniswapRouter = activeConfig.networkConfig.uniswapRouter](scripts/foundry/01_Deploy.s.sol#L137)
	- [usdc = activeConfig.networkConfig.usdc](scripts/foundry/01_Deploy.s.sol#L131)
	- [usdt = activeConfig.networkConfig.usdt](scripts/foundry/01_Deploy.s.sol#L133)
	- [vab = activeConfig.networkConfig.vab](scripts/foundry/01_Deploy.s.sol#L132)
	- [vabbleWallet = activeConfig.networkConfig.vabbleWallet](scripts/foundry/01_Deploy.s.sol#L135)

scripts/foundry/01_Deploy.s.sol#L127-L145


 - [ ] ID-163
Reentrancy in [VabbleFund.withdrawFunding(uint256)](contracts/dao/VabbleFund.sol#L239-L272):
	External calls:
	- [Helper.safeTransferETH(msg.sender,assetArr[i].amount)](contracts/dao/VabbleFund.sol#L255)
	- [Helper.safeTransfer(assetArr[i].token,msg.sender,assetArr[i].amount)](contracts/dao/VabbleFund.sol#L260)
	State variables written after the call(s):
	- [__removeFilmInvestorList(_filmId,msg.sender)](contracts/dao/VabbleFund.sol#L268)
		- [filmInvestorList[_filmId][k] = filmInvestorList[_filmId][filmInvestorList[_filmId].length - 1]](contracts/dao/VabbleFund.sol#L280)
		- [filmInvestorList[_filmId].pop()](contracts/dao/VabbleFund.sol#L281)

contracts/dao/VabbleFund.sol#L239-L272


 - [ ] ID-164
Reentrancy in [StakingPool.stakeVAB(uint256)](contracts/dao/StakingPool.sol#L132-L153):
	External calls:
	- [Helper.safeTransferFrom(IOwnablee(OWNABLE).PAYOUT_TOKEN(),msg.sender,address(this),_amount)](contracts/dao/StakingPool.sol#L138)
	State variables written after the call(s):
	- [__updateMinProposalIndex(msg.sender)](contracts/dao/StakingPool.sol#L150)
		- [minProposalIndex[_user] = i](contracts/dao/StakingPool.sol#L381)
	- [si.outstandingReward += calcRealizedRewards(msg.sender)](contracts/dao/StakingPool.sol#L144)
	- [si.stakeAmount += _amount](contracts/dao/StakingPool.sol#L145)
	- [si.stakeTime = block.timestamp](contracts/dao/StakingPool.sol#L146)
	- [__stakerSet(msg.sender)](contracts/dao/StakingPool.sol#L142)
		- [stakerMap.indexOf[key] = stakerMap.keys.length + 1](contracts/dao/StakingPool.sol#L821)
		- [stakerMap.keys.push(key)](contracts/dao/StakingPool.sol#L822)
	- [totalStakingAmount += _amount](contracts/dao/StakingPool.sol#L148)

contracts/dao/StakingPool.sol#L132-L153


 - [ ] ID-165
Reentrancy in [StakingPool.withdrawAllFund()](contracts/dao/StakingPool.sol#L696-L721):
	External calls:
	- [Helper.safeTransfer(vabToken,to,totalMigrationVAB)](contracts/dao/StakingPool.sol#L706)
	State variables written after the call(s):
	- [totalRewardAmount = totalRewardAmount - totalMigrationVAB](contracts/dao/StakingPool.sol#L708)

contracts/dao/StakingPool.sol#L696-L721


 - [ ] ID-166
Reentrancy in [Property.proposalAuditor(address,string,string)](contracts/dao/Property.sol#L201-L233):
	External calls:
	- [__paidFee(proposalFeeAmount)](contracts/dao/Property.sol#L214)
		- [(success,data) = token.call(abi.encodeWithSelector(0x23b872dd,from,to,value))](contracts/libraries/Helper.sol#L53)
		- [(success,data) = token.call(abi.encodeWithSelector(0x095ea7b3,to,value))](contracts/libraries/Helper.sol#L32)
		- [Helper.safeTransferFrom(vabToken,msg.sender,address(this),expectVABAmount)](contracts/dao/Property.sol#L244)
		- [Helper.safeApprove(vabToken,STAKING_POOL,IERC20(vabToken).totalSupply())](contracts/dao/Property.sol#L246)
		- [IStakingPool(STAKING_POOL).addRewardToPool(expectVABAmount)](contracts/dao/Property.sol#L248)
	- [ap.proposalID = IStakingPool(STAKING_POOL).addProposalData(msg.sender,block.timestamp,agentVotePeriod)](contracts/dao/Property.sol#L224)
	State variables written after the call(s):
	- [allGovProposalInfo[1].push(_agent)](contracts/dao/Property.sol#L229)
	- [governanceProposalCount += 1](contracts/dao/Property.sol#L226)
	- [userGovProposalCount[msg.sender] += 1](contracts/dao/Property.sol#L227)

contracts/dao/Property.sol#L201-L233


 - [ ] ID-167
Reentrancy in [StakingPool.addRewardToPool(uint256)](contracts/dao/StakingPool.sol#L122-L129):
	External calls:
	- [Helper.safeTransferFrom(IOwnablee(OWNABLE).PAYOUT_TOKEN(),msg.sender,address(this),_amount)](contracts/dao/StakingPool.sol#L125)
	State variables written after the call(s):
	- [totalRewardAmount = totalRewardAmount + _amount](contracts/dao/StakingPool.sol#L126)

contracts/dao/StakingPool.sol#L122-L129


 - [ ] ID-168
Reentrancy in [Property.proposalRewardFund(address,string,string)](contracts/dao/Property.sol#L252-L283):
	External calls:
	- [__paidFee(10 * proposalFeeAmount)](contracts/dao/Property.sol#L264)
		- [(success,data) = token.call(abi.encodeWithSelector(0x23b872dd,from,to,value))](contracts/libraries/Helper.sol#L53)
		- [(success,data) = token.call(abi.encodeWithSelector(0x095ea7b3,to,value))](contracts/libraries/Helper.sol#L32)
		- [Helper.safeTransferFrom(vabToken,msg.sender,address(this),expectVABAmount)](contracts/dao/Property.sol#L244)
		- [Helper.safeApprove(vabToken,STAKING_POOL,IERC20(vabToken).totalSupply())](contracts/dao/Property.sol#L246)
		- [IStakingPool(STAKING_POOL).addRewardToPool(expectVABAmount)](contracts/dao/Property.sol#L248)
	State variables written after the call(s):
	- [rp.title = _title](contracts/dao/Property.sol#L267)
	- [rp.description = _description](contracts/dao/Property.sol#L268)
	- [rp.createTime = block.timestamp](contracts/dao/Property.sol#L269)
	- [rp.value = _rewardAddress](contracts/dao/Property.sol#L270)
	- [rp.creator = msg.sender](contracts/dao/Property.sol#L271)
	- [rp.status = Helper.Status.LISTED](contracts/dao/Property.sol#L272)

contracts/dao/Property.sol#L252-L283


 - [ ] ID-169
Reentrancy in [VabbleDAO.withdrawVABFromStudioPool(address)](contracts/dao/VabbleDAO.sol#L417-L428):
	External calls:
	- [Helper.safeTransfer(vabToken,_to,poolBalance)](contracts/dao/VabbleDAO.sol#L421)
	State variables written after the call(s):
	- [StudioPool = 0](contracts/dao/VabbleDAO.sol#L423)
	- [delete studioPoolUsers](contracts/dao/VabbleDAO.sol#L424)

contracts/dao/VabbleDAO.sol#L417-L428


 - [ ] ID-170
Reentrancy in [VabbleFund.fundProcess(uint256)](contracts/dao/VabbleFund.sol#L184-L236):
	External calls:
	- [Helper.safeTransferETH(UNI_HELPER,rewardAmount)](contracts/dao/VabbleFund.sol#L211)
	- [Helper.safeApprove(assetArr[i].token,UNI_HELPER,IERC20(assetArr[i].token).totalSupply())](contracts/dao/VabbleFund.sol#L214)
	- [rewardSumAmount += IUniHelper(UNI_HELPER).swapAsset(swapArgs)](contracts/dao/VabbleFund.sol#L218)
	- [Helper.safeTransferAsset(assetArr[i].token,msg.sender,(assetArr[i].amount - rewardAmount))](contracts/dao/VabbleFund.sol#L221)
	- [Helper.safeApprove(vabToken,STAKING_POOL,IERC20(vabToken).totalSupply())](contracts/dao/VabbleFund.sol#L226)
	- [IStakingPool(STAKING_POOL).addRewardToPool(rewardSumAmount)](contracts/dao/VabbleFund.sol#L229)
	State variables written after the call(s):
	- [fundProcessedFilmIds.push(_filmId)](contracts/dao/VabbleFund.sol#L232)

contracts/dao/VabbleFund.sol#L184-L236


 - [ ] ID-171
Reentrancy in [StakingPool._depositVAB(address,uint256)](contracts/dao/StakingPool.sol#L530-L538):
	External calls:
	- [Helper.safeTransferFrom(IOwnablee(OWNABLE).PAYOUT_TOKEN(),msg.sender,address(this),_amount)](contracts/dao/StakingPool.sol#L534)
	State variables written after the call(s):
	- [userRentInfo[subscriber].vabAmount += _amount](contracts/dao/StakingPool.sol#L535)

contracts/dao/StakingPool.sol#L530-L538


 - [ ] ID-172
Reentrancy in [Vote.addFilmBoard(uint256)](contracts/dao/Vote.sol#L381-L409):
	External calls:
	- [IProperty(DAO_PROPERTY).updateGovProposal(_index,2,1)](contracts/dao/Vote.sol#L395)
	State variables written after the call(s):
	- [govPassedVoteCount[3] += 1](contracts/dao/Vote.sol#L396)

contracts/dao/Vote.sol#L381-L409


 - [ ] ID-173
Reentrancy in [Property.proposalProperty(uint256,uint256,string,string)](contracts/dao/Property.sol#L398-L516):
	External calls:
	- [__paidFee(proposalFeeAmount)](contracts/dao/Property.sol#L412)
		- [(success,data) = token.call(abi.encodeWithSelector(0x23b872dd,from,to,value))](contracts/libraries/Helper.sol#L53)
		- [(success,data) = token.call(abi.encodeWithSelector(0x095ea7b3,to,value))](contracts/libraries/Helper.sol#L32)
		- [Helper.safeTransferFrom(vabToken,msg.sender,address(this),expectVABAmount)](contracts/dao/Property.sol#L244)
		- [Helper.safeApprove(vabToken,STAKING_POOL,IERC20(vabToken).totalSupply())](contracts/dao/Property.sol#L246)
		- [IStakingPool(STAKING_POOL).addRewardToPool(expectVABAmount)](contracts/dao/Property.sol#L248)
	- [pp.proposalID = IStakingPool(STAKING_POOL).addProposalData(msg.sender,block.timestamp,propertyVotePeriod)](contracts/dao/Property.sol#L509)
	State variables written after the call(s):
	- [governanceProposalCount += 1](contracts/dao/Property.sol#L511)
	- [userGovProposalCount[msg.sender] += 1](contracts/dao/Property.sol#L512)

contracts/dao/Property.sol#L398-L516


 - [ ] ID-174
Reentrancy in [VabbleDAO.proposalFilmCreate(uint256,uint256,address)](contracts/dao/VabbleDAO.sol#L130-L152):
	External calls:
	- [__paidFee(_feeToken,_noVote)](contracts/dao/VabbleDAO.sol#L137)
		- [(success,None) = to.call{value: value}(new bytes(0))](contracts/libraries/Helper.sol#L58)
		- [(success,data) = token.call(abi.encodeWithSelector(0x095ea7b3,to,value))](contracts/libraries/Helper.sol#L32)
		- [(success,data) = token.call(abi.encodeWithSelector(0x23b872dd,from,to,value))](contracts/libraries/Helper.sol#L53)
		- [Helper.safeTransferETH(msg.sender,msg.value - expectTokenAmount)](contracts/dao/VabbleDAO.sol#L305)
		- [Helper.safeTransferETH(UNI_HELPER,expectTokenAmount)](contracts/dao/VabbleDAO.sol#L308)
		- [Helper.safeTransferFrom(_dToken,msg.sender,address(this),expectTokenAmount)](contracts/dao/VabbleDAO.sol#L310)
		- [Helper.safeApprove(_dToken,UNI_HELPER,IERC20(_dToken).totalSupply())](contracts/dao/VabbleDAO.sol#L312)
		- [vabAmount = IUniHelper(UNI_HELPER).swapAsset(swapArgs)](contracts/dao/VabbleDAO.sol#L318)
		- [Helper.safeApprove(vabToken,STAKING_POOL,IERC20(vabToken).totalSupply())](contracts/dao/VabbleDAO.sol#L321)
		- [IStakingPool(STAKING_POOL).addRewardToPool(vabAmount)](contracts/dao/VabbleDAO.sol#L323)
	External calls sending eth:
	- [__paidFee(_feeToken,_noVote)](contracts/dao/VabbleDAO.sol#L137)
		- [(success,None) = to.call{value: value}(new bytes(0))](contracts/libraries/Helper.sol#L58)
	State variables written after the call(s):
	- [fInfo.fundType = _fundType](contracts/dao/VabbleDAO.sol#L143)
	- [fInfo.noVote = _noVote](contracts/dao/VabbleDAO.sol#L144)
	- [fInfo.studio = msg.sender](contracts/dao/VabbleDAO.sol#L145)
	- [fInfo.status = Helper.Status.LISTED](contracts/dao/VabbleDAO.sol#L146)
	- [totalFilmIds[1].push(filmId)](contracts/dao/VabbleDAO.sol#L148)
	- [userFilmIds[msg.sender][1].push(filmId)](contracts/dao/VabbleDAO.sol#L149)

contracts/dao/VabbleDAO.sol#L130-L152


 - [ ] ID-175
Reentrancy in [StakingPool.__withdrawReward(uint256)](contracts/dao/StakingPool.sol#L221-L235):
	External calls:
	- [Helper.safeTransfer(IOwnablee(OWNABLE).PAYOUT_TOKEN(),msg.sender,_amount)](contracts/dao/StakingPool.sol#L222)
	State variables written after the call(s):
	- [__updateMinProposalIndex(msg.sender)](contracts/dao/StakingPool.sol#L234)
		- [minProposalIndex[_user] = i](contracts/dao/StakingPool.sol#L381)
	- [receivedRewardAmount[msg.sender] += _amount](contracts/dao/StakingPool.sol#L225)
	- [stakeInfo[msg.sender].stakeTime = block.timestamp](contracts/dao/StakingPool.sol#L228)
	- [stakeInfo[msg.sender].outstandingReward = 0](contracts/dao/StakingPool.sol#L229)
	- [totalRewardAmount -= _amount](contracts/dao/StakingPool.sol#L224)
	- [totalRewardIssuedAmount += _amount](contracts/dao/StakingPool.sol#L226)

contracts/dao/StakingPool.sol#L221-L235


 - [ ] ID-176
Reentrancy in [DeployerScript.deployForLocalTesting(bool)](scripts/foundry/01_Deploy.s.sol#L92-L117):
	External calls:
	- [vm.startPrank(deployer)](scripts/foundry/01_Deploy.s.sol#L110)
	- [_getConfig()](scripts/foundry/01_Deploy.s.sol#L111)
		- [activeConfig = helperConfig.getActiveNetworkConfig()](scripts/foundry/01_Deploy.s.sol#L129)
	State variables written after the call(s):
	- [_getConfig()](scripts/foundry/01_Deploy.s.sol#L111)
		- [auditor = activeConfig.networkConfig.auditor](scripts/foundry/01_Deploy.s.sol#L134)
	- [_deployAllContracts(vabbleWallet,auditor)](scripts/foundry/01_Deploy.s.sol#L112)
		- [contracts.uniHelper = new UniHelper(_uniswapFactory,_uniswapRouter,_ownablee)](scripts/foundry/01_Deploy.s.sol#L231)
		- [contracts.vote = new Vote(_ownablee)](scripts/foundry/01_Deploy.s.sol#L239)
		- [contracts.vabbleFund = new VabbleFund(_ownablee,_uniHelper,_stakingPool,_property,_factoryFilmNFT)](scripts/foundry/01_Deploy.s.sol#L272)
		- [contracts.ownablee = new Ownablee(_vabWallet,_vab,_usdc,_auditor)](scripts/foundry/01_Deploy.s.sol#L227)
		- [contracts.factoryFilmNFT = new FactoryFilmNFT(_ownablee)](scripts/foundry/01_Deploy.s.sol#L256)
		- [contracts.vabbleDAO = new VabbleDAO(_ownablee,_uniHelper,_vote,_stakingPool,_property,_vabbleFund)](scripts/foundry/01_Deploy.s.sol#L285)
		- [contracts.subscription = new Subscription(_ownablee,_uniHelper,_property,stakingPool,discountPercents)](scripts/foundry/01_Deploy.s.sol#L300)
		- [contracts.property = new Property(_ownablee,_uniHelper,_vote,_stakingPool,propertyTimePeriodConfig,propertyRatesConfig,propertyAmountsConfig,propertyMinMaxListConfig)](scripts/foundry/01_Deploy.s.sol#L243-L252)
		- [contracts.factorySubNFT = new FactorySubNFT(_ownablee,_uniHelper)](scripts/foundry/01_Deploy.s.sol#L260)
		- [contracts.factoryTierNFT = new FactoryTierNFT(_ownablee,_vabbleDAO,_vabbleFund)](scripts/foundry/01_Deploy.s.sol#L289)
		- [contracts.stakingPool = new StakingPool(_ownablee)](scripts/foundry/01_Deploy.s.sol#L235)
	- [_getConfig()](scripts/foundry/01_Deploy.s.sol#L111)
		- [depositAssets = activeConfig.networkConfig.depositAssets](scripts/foundry/01_Deploy.s.sol#L139)
	- [_getConfig()](scripts/foundry/01_Deploy.s.sol#L111)
		- [discountPercents = activeConfig.networkConfig.discountPercents](scripts/foundry/01_Deploy.s.sol#L138)
	- [_getConfig()](scripts/foundry/01_Deploy.s.sol#L111)
		- [propertyAmountsConfig = activeConfig.propertyAmountsConfig](scripts/foundry/01_Deploy.s.sol#L143)
	- [_getConfig()](scripts/foundry/01_Deploy.s.sol#L111)
		- [propertyMinMaxListConfig = activeConfig.propertyMinMaxListConfig](scripts/foundry/01_Deploy.s.sol#L144)
	- [_getConfig()](scripts/foundry/01_Deploy.s.sol#L111)
		- [propertyRatesConfig = activeConfig.propertyRatesConfig](scripts/foundry/01_Deploy.s.sol#L142)
	- [_getConfig()](scripts/foundry/01_Deploy.s.sol#L111)
		- [propertyTimePeriodConfig = activeConfig.propertyTimePeriodConfig](scripts/foundry/01_Deploy.s.sol#L141)
	- [_getConfig()](scripts/foundry/01_Deploy.s.sol#L111)
		- [uniswapFactory = activeConfig.networkConfig.uniswapFactory](scripts/foundry/01_Deploy.s.sol#L136)
	- [_getConfig()](scripts/foundry/01_Deploy.s.sol#L111)
		- [uniswapRouter = activeConfig.networkConfig.uniswapRouter](scripts/foundry/01_Deploy.s.sol#L137)
	- [_getConfig()](scripts/foundry/01_Deploy.s.sol#L111)
		- [usdc = activeConfig.networkConfig.usdc](scripts/foundry/01_Deploy.s.sol#L131)
	- [_getConfig()](scripts/foundry/01_Deploy.s.sol#L111)
		- [usdt = activeConfig.networkConfig.usdt](scripts/foundry/01_Deploy.s.sol#L133)
	- [_getConfig()](scripts/foundry/01_Deploy.s.sol#L111)
		- [vab = activeConfig.networkConfig.vab](scripts/foundry/01_Deploy.s.sol#L132)
	- [_getConfig()](scripts/foundry/01_Deploy.s.sol#L111)
		- [vabbleWallet = activeConfig.networkConfig.vabbleWallet](scripts/foundry/01_Deploy.s.sol#L135)

scripts/foundry/01_Deploy.s.sol#L92-L117


 - [ ] ID-177
Reentrancy in [Property.proposalProperty(uint256,uint256,string,string)](contracts/dao/Property.sol#L398-L516):
	External calls:
	- [__paidFee(proposalFeeAmount)](contracts/dao/Property.sol#L412)
		- [(success,data) = token.call(abi.encodeWithSelector(0x23b872dd,from,to,value))](contracts/libraries/Helper.sol#L53)
		- [(success,data) = token.call(abi.encodeWithSelector(0x095ea7b3,to,value))](contracts/libraries/Helper.sol#L32)
		- [Helper.safeTransferFrom(vabToken,msg.sender,address(this),expectVABAmount)](contracts/dao/Property.sol#L244)
		- [Helper.safeApprove(vabToken,STAKING_POOL,IERC20(vabToken).totalSupply())](contracts/dao/Property.sol#L246)
		- [IStakingPool(STAKING_POOL).addRewardToPool(expectVABAmount)](contracts/dao/Property.sol#L248)
	State variables written after the call(s):
	- [agentVotePeriodList.push(_property)](contracts/dao/Property.sol#L422)
	- [availableVABAmountList.push(_property)](contracts/dao/Property.sol#L478)
	- [boardRewardRateList.push(_property)](contracts/dao/Property.sol#L498)
	- [boardVotePeriodList.push(_property)](contracts/dao/Property.sol#L482)
	- [boardVoteWeightList.push(_property)](contracts/dao/Property.sol#L486)
	- [disputeGracePeriodList.push(_property)](contracts/dao/Property.sol#L426)
	- [filmRewardClaimPeriodList.push(_property)](contracts/dao/Property.sol#L442)
	- [filmVotePeriodList.push(_property)](contracts/dao/Property.sol#L418)
	- [fundFeePercentList.push(_property)](contracts/dao/Property.sol#L454)
	- [lockPeriodList.push(_property)](contracts/dao/Property.sol#L434)
	- [maxAllowPeriodList.push(_property)](contracts/dao/Property.sol#L446)
	- [maxDepositAmountList.push(_property)](contracts/dao/Property.sol#L462)
	- [maxMintFeePercentList.push(_property)](contracts/dao/Property.sol#L466)
	- [minDepositAmountList.push(_property)](contracts/dao/Property.sol#L458)
	- [minStakerCountPercentList.push(_property)](contracts/dao/Property.sol#L474)
	- [minVoteCountList.push(_property)](contracts/dao/Property.sol#L470)
	- [pp.title = _title](contracts/dao/Property.sol#L502)
	- [pp.description = _description](contracts/dao/Property.sol#L503)
	- [pp.createTime = block.timestamp](contracts/dao/Property.sol#L504)
	- [pp.value = _property](contracts/dao/Property.sol#L505)
	- [pp.creator = msg.sender](contracts/dao/Property.sol#L506)
	- [pp.status = Helper.Status.LISTED](contracts/dao/Property.sol#L507)
	- [propertyVotePeriodList.push(_property)](contracts/dao/Property.sol#L430)
	- [proposalFeeAmountList.push(_property)](contracts/dao/Property.sol#L450)
	- [rewardRateList.push(_property)](contracts/dao/Property.sol#L438)
	- [rewardVotePeriodList.push(_property)](contracts/dao/Property.sol#L490)
	- [subscriptionAmountList.push(_property)](contracts/dao/Property.sol#L494)

contracts/dao/Property.sol#L398-L516


 - [ ] ID-178
Reentrancy in [FilmMigration.run()](scripts/foundry/05_FilmMigration.s.sol#L18-L53):
	External calls:
	- [contractAddress = vm.prompt(string.concat(Enter the VabbleDAO contract address you want to migrate ,Strings.toString(length), films to (Chain ID: ,blockChainId,)))](scripts/foundry/05_FilmMigration.s.sol#L29-L37)
	State variables written after the call(s):
	- [vabbleDAO = VabbleDAO(address(vm.parseAddress(contractAddress)))](scripts/foundry/05_FilmMigration.s.sol#L39)

scripts/foundry/05_FilmMigration.s.sol#L18-L53


## timestamp
Impact: Low
Confidence: Medium
 - [ ] ID-179
[StakingPool.__updateMinProposalIndex(address)](contracts/dao/StakingPool.sol#L376-L385) uses timestamp for comparisons
	Dangerous comparisons:
	- [propsList[i].cTime + propsList[i].period >= stakeInfo[_user].stakeTime](contracts/dao/StakingPool.sol#L380)

contracts/dao/StakingPool.sol#L376-L385


 - [ ] ID-180
[VabbleDAO.checkSetFinalFilms(uint256[])](contracts/dao/VabbleDAO.sol#L431-L444) uses timestamp for comparisons
	Dangerous comparisons:
	- [finalFilmCalledTime[_filmIds[i]] != 0](contracts/dao/VabbleDAO.sol#L438)
	- [_valids[i] = block.timestamp - finalFilmCalledTime[_filmIds[i]] >= fPeriod](contracts/dao/VabbleDAO.sol#L439)

contracts/dao/VabbleDAO.sol#L431-L444


 - [ ] ID-181
[VabbleDAO.__setFinalAmountToPayees(uint256,uint256,uint256)](contracts/dao/VabbleDAO.sol#L507-L516) uses timestamp for comparisons
	Dangerous comparisons:
	- [k < payeeLength](contracts/dao/VabbleDAO.sol#L510)

contracts/dao/VabbleDAO.sol#L507-L516


 - [ ] ID-182
[StakingPool.calcRealizedRewards(address)](contracts/dao/StakingPool.sol#L388-L418) uses timestamp for comparisons
	Dangerous comparisons:
	- [i < intervalCount](contracts/dao/StakingPool.sol#L399)

contracts/dao/StakingPool.sol#L388-L418


 - [ ] ID-183
[StakingPool.calcPendingRewards(address)](contracts/dao/StakingPool.sol#L420-L452) uses timestamp for comparisons
	Dangerous comparisons:
	- [i < intervalCount](contracts/dao/StakingPool.sol#L431)

contracts/dao/StakingPool.sol#L420-L452


 - [ ] ID-184
[VabbleFund.depositToFilm(uint256,uint256,uint256,address)](contracts/dao/VabbleFund.sol#L78-L116) uses timestamp for comparisons
	Dangerous comparisons:
	- [require(bool,string)(fundPeriod >= block.timestamp - pApproveTime,depositToFilm: passed funding period)](contracts/dao/VabbleFund.sol#L95)

contracts/dao/VabbleFund.sol#L78-L116


 - [ ] ID-185
[VabbleDAO.isEnabledClaimer(uint256)](contracts/dao/VabbleDAO.sol#L674-L677) uses timestamp for comparisons
	Dangerous comparisons:
	- [filmInfo[_filmId].enableClaimer == 1](contracts/dao/VabbleDAO.sol#L675)

contracts/dao/VabbleDAO.sol#L674-L677


 - [ ] ID-186
[StakingPool.__calcProposalTimeIntervals(address)](contracts/dao/StakingPool.sol#L251-L290) uses timestamp for comparisons
	Dangerous comparisons:
	- [propsList[i].cTime + propsList[i].period >= stakeInfo[_user].stakeTime](contracts/dao/StakingPool.sol#L261)
	- [pData.cTime + pData.period >= stakeTime](contracts/dao/StakingPool.sol#L276)
	- [times_[2 * count + 2] > end](contracts/dao/StakingPool.sol#L280)

contracts/dao/StakingPool.sol#L251-L290


 - [ ] ID-187
[StakingPool.calcRewardAmount(address)](contracts/dao/StakingPool.sol#L238-L249) uses timestamp for comparisons
	Dangerous comparisons:
	- [si.stakeAmount == 0](contracts/dao/StakingPool.sol#L241)

contracts/dao/StakingPool.sol#L238-L249


 - [ ] ID-188
[VabbleDAO.proposalFilmUpdate(uint256,string,string,uint256[],address[],uint256,uint256,uint256,uint256)](contracts/dao/VabbleDAO.sol#L154-L228) uses timestamp for comparisons
	Dangerous comparisons:
	- [require(bool,string)(fInfo.status == Helper.Status.LISTED,pU: NL)](contracts/dao/VabbleDAO.sol#L191)
	- [require(bool,string)(fInfo.studio == msg.sender,pU: NFO)](contracts/dao/VabbleDAO.sol#L192)
	- [fInfo.fundType != 0](contracts/dao/VabbleDAO.sol#L216)
	- [fInfo.noVote == 1](contracts/dao/VabbleDAO.sol#L219)

contracts/dao/VabbleDAO.sol#L154-L228


 - [ ] ID-189
[FactorySubNFT.lockNFT(uint256)](contracts/dao/FactorySubNFT.sol#L207-L219) uses timestamp for comparisons
	Dangerous comparisons:
	- [require(bool,string)(msg.sender == lockInfo[_tokenId].minter,lock: not token minter)](contracts/dao/FactorySubNFT.sol#L209)

contracts/dao/FactorySubNFT.sol#L207-L219


 - [ ] ID-190
[StakingPool.withdrawReward(uint256)](contracts/dao/StakingPool.sol#L188-L218) uses timestamp for comparisons
	Dangerous comparisons:
	- [require(bool,string)(stakeInfo[msg.sender].stakeAmount > 0,wR: zero amount)](contracts/dao/StakingPool.sol#L190)
	- [require(bool,string)(migrationStatus > 0 || block.timestamp > withdrawTime,wR: lock)](contracts/dao/StakingPool.sol#L193)
	- [require(bool,string)(rewardAmount > 0,wR: zero reward)](contracts/dao/StakingPool.sol#L200)
	- [require(bool,string)(totalRewardAmount >= rewardAmount,wR: insufficient total)](contracts/dao/StakingPool.sol#L214)

contracts/dao/StakingPool.sol#L188-L218


 - [ ] ID-191
[VabbleDAO.__setFinalFilm(uint256,uint256)](contracts/dao/VabbleDAO.sol#L477-L504) uses timestamp for comparisons
	Dangerous comparisons:
	- [require(bool,string)(fInfo.status == Helper.Status.APPROVED_LISTING || fInfo.status == Helper.Status.APPROVED_FUNDING,sFF: Not approved)](contracts/dao/VabbleDAO.sol#L479-L482)
	- [fInfo.status == Helper.Status.APPROVED_LISTING](contracts/dao/VabbleDAO.sol#L485)
	- [fInfo.status == Helper.Status.APPROVED_FUNDING](contracts/dao/VabbleDAO.sol#L487)
	- [rewardAmount != 0](contracts/dao/VabbleDAO.sol#L497)
	- [payAmount != 0](contracts/dao/VabbleDAO.sol#L500)

contracts/dao/VabbleDAO.sol#L477-L504


 - [ ] ID-192
[Subscription.isActivedSubscription(address)](contracts/dao/Subscription.sol#L214-L217) uses timestamp for comparisons
	Dangerous comparisons:
	- [subscriptionInfo[_customer].expireTime > block.timestamp](contracts/dao/Subscription.sol#L215)

contracts/dao/Subscription.sol#L214-L217


 - [ ] ID-193
[Subscription._updateSubscription(uint256)](contracts/dao/Subscription.sol#L315-L328) uses timestamp for comparisons
	Dangerous comparisons:
	- [subscription.expireTime > currentTime](contracts/dao/Subscription.sol#L319)

contracts/dao/Subscription.sol#L315-L328


 - [ ] ID-194
[StakingPool.calcMigrationVAB()](contracts/dao/StakingPool.sol#L723-L741) uses timestamp for comparisons
	Dangerous comparisons:
	- [totalRewardAmount >= totalAmount](contracts/dao/StakingPool.sol#L736)

contracts/dao/StakingPool.sol#L723-L741


 - [ ] ID-195
[StakingPool.__calcRewards(address,uint256,uint256)](contracts/dao/StakingPool.sol#L454-L469) uses timestamp for comparisons
	Dangerous comparisons:
	- [si.stakeAmount == 0](contracts/dao/StakingPool.sol#L456)
	- [startTime == 0](contracts/dao/StakingPool.sol#L457)

contracts/dao/StakingPool.sol#L454-L469


 - [ ] ID-196
[FactoryTierNFT.setTierInfo(uint256,uint256[],uint256[])](contracts/dao/FactoryTierNFT.sol#L77-L109) uses timestamp for comparisons
	Dangerous comparisons:
	- [require(bool,string)(fundPeriod < block.timestamp - pApproveTime,setTier: fund period yet)](contracts/dao/FactoryTierNFT.sol#L90)

contracts/dao/FactoryTierNFT.sol#L77-L109


 - [ ] ID-197
[VabbleDAO.__claimAllReward(uint256[])](contracts/dao/VabbleDAO.sol#L550-L576) uses timestamp for comparisons
	Dangerous comparisons:
	- [finalFilmCalledTime[_filmIds[i]] == 0](contracts/dao/VabbleDAO.sol#L559)

contracts/dao/VabbleDAO.sol#L550-L576


 - [ ] ID-198
[VabbleDAO.updateEnabledClaimer(uint256,uint256)](contracts/dao/VabbleDAO.sol#L680-L684) uses timestamp for comparisons
	Dangerous comparisons:
	- [require(bool,string)(filmInfo[_filmId].studio == msg.sender,uEC: not film owner)](contracts/dao/VabbleDAO.sol#L681)

contracts/dao/VabbleDAO.sol#L680-L684


 - [ ] ID-199
[Vote.__isVotePeriod(uint256,uint256)](contracts/dao/Vote.sol#L545-L552) uses timestamp for comparisons
	Dangerous comparisons:
	- [_period >= block.timestamp - _startTime](contracts/dao/Vote.sol#L550)

contracts/dao/Vote.sol#L545-L552


 - [ ] ID-200
[UniHelper._executeSwap(uint256,address,address)](contracts/dao/UniHelper.sol#L155-L174) uses timestamp for comparisons
	Dangerous comparisons:
	- [address(this).balance < _amount](contracts/dao/UniHelper.sol#L162)

contracts/dao/UniHelper.sol#L155-L174


 - [ ] ID-201
[StakingPool.withdrawAllFund()](contracts/dao/StakingPool.sol#L696-L721) uses timestamp for comparisons
	Dangerous comparisons:
	- [IERC20(vabToken).balanceOf(address(this)) >= totalMigrationVAB && totalMigrationVAB > 0](contracts/dao/StakingPool.sol#L705)

contracts/dao/StakingPool.sol#L696-L721


 - [ ] ID-202
[VabbleFund.withdrawFunding(uint256)](contracts/dao/VabbleFund.sol#L239-L272) uses timestamp for comparisons
	Dangerous comparisons:
	- [require(bool,string)(fundPeriod < block.timestamp - pApproveTime,withdrawFunding: funding period)](contracts/dao/VabbleFund.sol#L245)

contracts/dao/VabbleFund.sol#L239-L272


 - [ ] ID-203
[StakingPool.__getProposalVoteCount(address,uint256,uint256,uint256)](contracts/dao/StakingPool.sol#L329-L374) uses timestamp for comparisons
	Dangerous comparisons:
	- [pData.cTime <= _start && _end <= pData.cTime + pData.period](contracts/dao/StakingPool.sol#L348)
	- [_start >= stakeInfo[_user].stakeTime](contracts/dao/StakingPool.sol#L351)
	- [pData.creator == _user || votedTime[_user][pData.proposalID] <= stakeInfo[_user].stakeTime](contracts/dao/StakingPool.sol#L356)
	- [block.timestamp <= pData.cTime + pData.period](contracts/dao/StakingPool.sol#L365)

contracts/dao/StakingPool.sol#L329-L374


 - [ ] ID-204
[StakingPool.unstakeVAB(uint256)](contracts/dao/StakingPool.sol#L156-L185) uses timestamp for comparisons
	Dangerous comparisons:
	- [require(bool,string)(si.stakeAmount >= _amount,usVAB: insufficient)](contracts/dao/StakingPool.sol#L161)
	- [require(bool,string)(migrationStatus > 0 || block.timestamp > withdrawTime,usVAB: lock)](contracts/dao/StakingPool.sol#L162)
	- [totalRewardAmount >= rewardAmount && rewardAmount > 0](contracts/dao/StakingPool.sol#L166)
	- [si.stakeAmount == 0](contracts/dao/StakingPool.sol#L177)

contracts/dao/StakingPool.sol#L156-L185


 - [ ] ID-205
[FactorySubNFT.unlockNFT(uint256)](contracts/dao/FactorySubNFT.sol#L222-L235) uses timestamp for comparisons
	Dangerous comparisons:
	- [require(bool,string)(msg.sender == lockInfo[_tokenId].minter,unlock: not token minter)](contracts/dao/FactorySubNFT.sol#L224)
	- [require(bool,string)(block.timestamp > sInfo.lockPeriod + sInfo.lockTime,unlock: locked yet)](contracts/dao/FactorySubNFT.sol#L227)

contracts/dao/FactorySubNFT.sol#L222-L235


 - [ ] ID-206
[VabbleFund.fundProcess(uint256)](contracts/dao/VabbleFund.sol#L184-L236) uses timestamp for comparisons
	Dangerous comparisons:
	- [require(bool,string)(fundPeriod < block.timestamp - pApproveTime,fundProcess: funding period)](contracts/dao/VabbleFund.sol#L194)

contracts/dao/VabbleFund.sol#L184-L236


 - [ ] ID-207
[UniHelper._approveIfNeeded(address,address,uint256)](contracts/dao/UniHelper.sol#L176-L180) uses timestamp for comparisons
	Dangerous comparisons:
	- [IERC20(_token).allowance(address(this),_spender) < _amount](contracts/dao/UniHelper.sol#L177)

contracts/dao/UniHelper.sol#L176-L180


 - [ ] ID-208
[VabbleDAO.updateFilmFundPeriod(uint256,uint256)](contracts/dao/VabbleDAO.sol#L351-L358) uses timestamp for comparisons
	Dangerous comparisons:
	- [require(bool,string)(msg.sender == filmInfo[_filmId].studio,uFP: 1)](contracts/dao/VabbleDAO.sol#L352)
	- [require(bool,string)(filmInfo[_filmId].fundType != 0,uFP: 2)](contracts/dao/VabbleDAO.sol#L353)

contracts/dao/VabbleDAO.sol#L351-L358


 - [ ] ID-209
[Property.removeFilmBoardMember(address)](contracts/dao/Property.sol#L321-L331) uses timestamp for comparisons
	Dangerous comparisons:
	- [require(bool,string)(maxAllowPeriod < block.timestamp - IVote(VOTE).getLastVoteTime(_member),rFBM: e1)](contracts/dao/Property.sol#L323)
	- [require(bool,string)(maxAllowPeriod > block.timestamp - IStakingPool(STAKING_POOL).lastfundProposalCreateTime(),rFBM: e2)](contracts/dao/Property.sol#L324)

contracts/dao/Property.sol#L321-L331


## assembly
Impact: Informational
Confidence: High
 - [ ] ID-210
[ERC721._checkOnERC721Received(address,address,uint256,bytes)](node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol#L399-L421) uses assembly
	- [INLINE ASM](node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol#L413-L415)

node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol#L399-L421


 - [ ] ID-211
[Arrays._swap(uint256,uint256)](contracts/libraries/Arrays.sol#L140-L147) uses assembly
	- [INLINE ASM](contracts/libraries/Arrays.sol#L141-L146)

contracts/libraries/Arrays.sol#L140-L147


 - [ ] ID-212
[Arrays._mload(uint256)](contracts/libraries/Arrays.sol#L131-L135) uses assembly
	- [INLINE ASM](contracts/libraries/Arrays.sol#L132-L134)

contracts/libraries/Arrays.sol#L131-L135


 - [ ] ID-213
[Arrays._castToBytes32Comp(function(address,address) returns(bool))](contracts/libraries/Arrays.sol#L169-L175) uses assembly
	- [INLINE ASM](contracts/libraries/Arrays.sol#L172-L174)

contracts/libraries/Arrays.sol#L169-L175


 - [ ] ID-214
[Arrays._castToBytes32Comp(function(uint256,uint256) returns(bool))](contracts/libraries/Arrays.sol#L178-L184) uses assembly
	- [INLINE ASM](contracts/libraries/Arrays.sol#L181-L183)

contracts/libraries/Arrays.sol#L178-L184


 - [ ] ID-215
[Math.mulDiv(uint256,uint256,uint256)](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L55-L134) uses assembly
	- [INLINE ASM](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L62-L66)
	- [INLINE ASM](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L85-L92)
	- [INLINE ASM](node_modules/@openzeppelin/contracts/utils/math/Math.sol#L99-L108)

node_modules/@openzeppelin/contracts/utils/math/Math.sol#L55-L134


 - [ ] ID-216
[Arrays._begin(bytes32[])](contracts/libraries/Arrays.sol#L111-L116) uses assembly
	- [INLINE ASM](contracts/libraries/Arrays.sol#L113-L115)

contracts/libraries/Arrays.sol#L111-L116


 - [ ] ID-217
[Strings.toString(uint256)](node_modules/@openzeppelin/contracts/utils/Strings.sol#L19-L39) uses assembly
	- [INLINE ASM](node_modules/@openzeppelin/contracts/utils/Strings.sol#L25-L27)
	- [INLINE ASM](node_modules/@openzeppelin/contracts/utils/Strings.sol#L31-L33)

node_modules/@openzeppelin/contracts/utils/Strings.sol#L19-L39


 - [ ] ID-218
[Arrays._castToBytes32Array(address[])](contracts/libraries/Arrays.sol#L155-L159) uses assembly
	- [INLINE ASM](contracts/libraries/Arrays.sol#L156-L158)

contracts/libraries/Arrays.sol#L155-L159


 - [ ] ID-219
[Address._revert(bytes,string)](node_modules/@openzeppelin/contracts/utils/Address.sol#L231-L243) uses assembly
	- [INLINE ASM](node_modules/@openzeppelin/contracts/utils/Address.sol#L236-L239)

node_modules/@openzeppelin/contracts/utils/Address.sol#L231-L243


 - [ ] ID-220
[Arrays._castToBytes32Array(uint256[])](contracts/libraries/Arrays.sol#L162-L166) uses assembly
	- [INLINE ASM](contracts/libraries/Arrays.sol#L163-L165)

contracts/libraries/Arrays.sol#L162-L166


## costly-loop
Impact: Informational
Confidence: Medium
 - [ ] ID-221
[Ownablee.removeDepositAsset(address[])](contracts/dao/Ownablee.sol#L104-L121) has costly operations inside a loop:
	- [depositAssetList.pop()](contracts/dao/Ownablee.sol#L113)

contracts/dao/Ownablee.sol#L104-L121


 - [ ] ID-222
[ERC721Enumerable._removeTokenFromAllTokensEnumeration(uint256)](node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol#L140-L158) has costly operations inside a loop:
	- [_allTokens.pop()](node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol#L157)

node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol#L140-L158


 - [ ] ID-223
[ERC721Enumerable._removeTokenFromAllTokensEnumeration(uint256)](node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol#L140-L158) has costly operations inside a loop:
	- [delete _allTokensIndex[tokenId]](node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol#L156)

node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol#L140-L158


 - [ ] ID-224
[ERC721Enumerable._removeTokenFromOwnerEnumeration(address,uint256)](node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol#L115-L133) has costly operations inside a loop:
	- [delete _ownedTokensIndex[tokenId]](node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol#L131)

node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol#L115-L133


## cyclomatic-complexity
Impact: Informational
Confidence: High
 - [ ] ID-225
[Property.updatePropertyProposal(uint256,uint256,uint256)](contracts/dao/Property.sol#L578-L639) has a high cyclomatic complexity (24).

contracts/dao/Property.sol#L578-L639


 - [ ] ID-226
[Property.proposalProperty(uint256,uint256,string,string)](contracts/dao/Property.sol#L398-L516) has a high cyclomatic complexity (22).

contracts/dao/Property.sol#L398-L516


 - [ ] ID-227
[Property.getPropertyProposalList(uint256)](contracts/dao/Property.sol#L519-L541) has a high cyclomatic complexity (22).

contracts/dao/Property.sol#L519-L541


## dead-code
Impact: Informational
Confidence: Medium
 - [ ] ID-228
[Context._contextSuffixLength()](node_modules/@openzeppelin/contracts/utils/Context.sol#L25-L27) is never used and should be removed

node_modules/@openzeppelin/contracts/utils/Context.sol#L25-L27


 - [ ] ID-229
[ERC1155._burn(address,uint256,uint256)](node_modules/@openzeppelin/contracts/token/ERC1155/ERC1155.sol#L325-L343) is never used and should be removed

node_modules/@openzeppelin/contracts/token/ERC1155/ERC1155.sol#L325-L343


 - [ ] ID-230
[ERC2981._setTokenRoyalty(uint256,address,uint96)](node_modules/@openzeppelin/contracts/token/common/ERC2981.sol#L94-L99) is never used and should be removed

node_modules/@openzeppelin/contracts/token/common/ERC2981.sol#L94-L99


 - [ ] ID-231
[ERC721._burn(uint256)](node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol#L299-L320) is never used and should be removed

node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol#L299-L320


 - [ ] ID-232
[ERC2981._deleteDefaultRoyalty()](node_modules/@openzeppelin/contracts/token/common/ERC2981.sol#L82-L84) is never used and should be removed

node_modules/@openzeppelin/contracts/token/common/ERC2981.sol#L82-L84


 - [ ] ID-233
[Context._msgData()](node_modules/@openzeppelin/contracts/utils/Context.sol#L21-L23) is never used and should be removed

node_modules/@openzeppelin/contracts/utils/Context.sol#L21-L23


 - [ ] ID-234
[ERC721.__unsafe_increaseBalance(address,uint256)](node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol#L463-L465) is never used and should be removed

node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol#L463-L465


 - [ ] ID-235
[ERC1155._burnBatch(address,uint256[],uint256[])](node_modules/@openzeppelin/contracts/token/ERC1155/ERC1155.sol#L354-L376) is never used and should be removed

node_modules/@openzeppelin/contracts/token/ERC1155/ERC1155.sol#L354-L376


 - [ ] ID-236
[ERC721._baseURI()](node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol#L105-L107) is never used and should be removed

node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol#L105-L107


 - [ ] ID-237
[ERC2981._resetTokenRoyalty(uint256)](node_modules/@openzeppelin/contracts/token/common/ERC2981.sol#L104-L106) is never used and should be removed

node_modules/@openzeppelin/contracts/token/common/ERC2981.sol#L104-L106


 - [ ] ID-238
[ERC2981._setDefaultRoyalty(address,uint96)](node_modules/@openzeppelin/contracts/token/common/ERC2981.sol#L72-L77) is never used and should be removed

node_modules/@openzeppelin/contracts/token/common/ERC2981.sol#L72-L77


 - [ ] ID-239
[ERC1155._mintBatch(address,uint256[],uint256[],bytes)](node_modules/@openzeppelin/contracts/token/ERC1155/ERC1155.sol#L291-L313) is never used and should be removed

node_modules/@openzeppelin/contracts/token/ERC1155/ERC1155.sol#L291-L313


 - [ ] ID-240
[ReentrancyGuard._reentrancyGuardEntered()](node_modules/@openzeppelin/contracts/security/ReentrancyGuard.sol#L74-L76) is never used and should be removed

node_modules/@openzeppelin/contracts/security/ReentrancyGuard.sol#L74-L76


## low-level-calls
Impact: Informational
Confidence: High
 - [ ] ID-241
Low level call in [Address.functionCallWithValue(address,bytes,uint256,string)](node_modules/@openzeppelin/contracts/utils/Address.sol#L128-L137):
	- [(success,returndata) = target.call{value: value}(data)](node_modules/@openzeppelin/contracts/utils/Address.sol#L135)

node_modules/@openzeppelin/contracts/utils/Address.sol#L128-L137


 - [ ] ID-242
Low level call in [Helper.safeTransfer(address,address,uint256)](contracts/libraries/Helper.sol#L36-L44):
	- [(success,data) = token.call(abi.encodeWithSelector(0xa9059cbb,to,value))](contracts/libraries/Helper.sol#L42)

contracts/libraries/Helper.sol#L36-L44


 - [ ] ID-243
Low level call in [Helper.safeApprove(address,address,uint256)](contracts/libraries/Helper.sol#L25-L34):
	- [(success,data) = token.call(abi.encodeWithSelector(0x095ea7b3,to,value))](contracts/libraries/Helper.sol#L32)

contracts/libraries/Helper.sol#L25-L34


 - [ ] ID-244
Low level call in [Helper.safeTransferFrom(address,address,address,uint256)](contracts/libraries/Helper.sol#L46-L55):
	- [(success,data) = token.call(abi.encodeWithSelector(0x23b872dd,from,to,value))](contracts/libraries/Helper.sol#L53)

contracts/libraries/Helper.sol#L46-L55


 - [ ] ID-245
Low level call in [Address.sendValue(address,uint256)](node_modules/@openzeppelin/contracts/utils/Address.sol#L64-L69):
	- [(success,None) = recipient.call{value: amount}()](node_modules/@openzeppelin/contracts/utils/Address.sol#L67)

node_modules/@openzeppelin/contracts/utils/Address.sol#L64-L69


 - [ ] ID-246
Low level call in [Address.functionStaticCall(address,bytes,string)](node_modules/@openzeppelin/contracts/utils/Address.sol#L155-L162):
	- [(success,returndata) = target.staticcall(data)](node_modules/@openzeppelin/contracts/utils/Address.sol#L160)

node_modules/@openzeppelin/contracts/utils/Address.sol#L155-L162


 - [ ] ID-247
Low level call in [Address.functionDelegateCall(address,bytes,string)](node_modules/@openzeppelin/contracts/utils/Address.sol#L180-L187):
	- [(success,returndata) = target.delegatecall(data)](node_modules/@openzeppelin/contracts/utils/Address.sol#L185)

node_modules/@openzeppelin/contracts/utils/Address.sol#L180-L187


 - [ ] ID-248
Low level call in [Helper.safeTransferETH(address,uint256)](contracts/libraries/Helper.sol#L57-L60):
	- [(success,None) = to.call{value: value}(new bytes(0))](contracts/libraries/Helper.sol#L58)

contracts/libraries/Helper.sol#L57-L60


## unused-import
Impact: Informational
Confidence: High
 - [ ] ID-249
The following unused import(s) in test/foundry/unit/UniHelper.t.sol should be removed:
	-import { IERC20 } from "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol"; (test/foundry/unit/UniHelper.t.sol#10)

 - [ ] ID-250
The following unused import(s) in test/foundry/mocks/MockUSDC.sol should be removed:
	-import { console } from "lib/forge-std/src/console.sol"; (test/foundry/mocks/MockUSDC.sol#4)

 - [ ] ID-251
The following unused import(s) in test/foundry/utils/BaseForkTest.sol should be removed:
	-import { IERC20 } from "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol"; (test/foundry/utils/BaseForkTest.sol#6)

 - [ ] ID-252
The following unused import(s) in test/foundry/scripts/FilmMigration.t.sol should be removed:
	-import { Helper } from "../../../contracts/libraries/Helper.sol"; (test/foundry/scripts/FilmMigration.t.sol#8)

	-import { Test, console2 } from "lib/forge-std/src/Test.sol"; (test/foundry/scripts/FilmMigration.t.sol#4)

 - [ ] ID-253
The following unused import(s) in scripts/foundry/HelperConfigFork.s.sol should be removed:
	-import { ERC20Mock } from "../../test/foundry/mocks/ERC20Mock.sol"; (scripts/foundry/HelperConfigFork.s.sol#7)

	-import { MockUSDC } from "../../test/foundry/mocks/MockUSDC.sol"; (scripts/foundry/HelperConfigFork.s.sol#6)

 - [ ] ID-254
The following unused import(s) in test/foundry/utils/BaseTest.sol should be removed:
	-import { VabbleNFT } from "../../../contracts/dao/VabbleNFT.sol"; (test/foundry/utils/BaseTest.sol#21)

	-import { IERC20 } from "lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol"; (test/foundry/utils/BaseTest.sol#7)

	-import { MockUSDC } from "../mocks/MockUSDC.sol"; (test/foundry/utils/BaseTest.sol#9)

	-import { ERC20Mock } from "../mocks/ERC20Mock.sol"; (test/foundry/utils/BaseTest.sol#10)

 - [ ] ID-255
The following unused import(s) in scripts/foundry/05_FilmMigration.s.sol should be removed:
	-import { console2 } from "lib/forge-std/src/Test.sol"; (scripts/foundry/05_FilmMigration.s.sol#5)

## unused-state
Impact: Informational
Confidence: High
 - [ ] ID-256
[HelperConfig.ETH_MAINNET_CHAIN_ID](scripts/foundry/HelperConfig.s.sol#L50) is never used in [HelperConfig](scripts/foundry/HelperConfig.s.sol#L32-L324)

scripts/foundry/HelperConfig.s.sol#L50


 - [ ] ID-257
[DeployerScript.sushiSwapRouter](scripts/foundry/01_Deploy.s.sol#L62) is never used in [DeployerScript](scripts/foundry/01_Deploy.s.sol#L24-L302)

scripts/foundry/01_Deploy.s.sol#L62


 - [ ] ID-258
[DeployerScript.sushiSwapFactory](scripts/foundry/01_Deploy.s.sol#L61) is never used in [DeployerScript](scripts/foundry/01_Deploy.s.sol#L24-L302)

scripts/foundry/01_Deploy.s.sol#L61


 - [ ] ID-259
[HelperConfig.BASE__CHAIN_ID](scripts/foundry/HelperConfig.s.sol#L52) is never used in [HelperConfig](scripts/foundry/HelperConfig.s.sol#L32-L324)

scripts/foundry/HelperConfig.s.sol#L52


## cache-array-length
Impact: Optimization
Confidence: High
 - [ ] ID-260
Loop condition [k < agentList.length](contracts/dao/Property.sol#L350) should use cached array length instead of referencing `length` member of the storage array.
 
contracts/dao/Property.sol#L350


## constable-states
Impact: Optimization
Confidence: High
 - [ ] ID-261
[DeployerScript.sushiSwapFactory](scripts/foundry/01_Deploy.s.sol#L61) should be constant 

scripts/foundry/01_Deploy.s.sol#L61


 - [ ] ID-262
[DeployerScript.sushiSwapRouter](scripts/foundry/01_Deploy.s.sol#L62) should be constant 

scripts/foundry/01_Deploy.s.sol#L62


## immutable-states
Impact: Optimization
Confidence: High
 - [ ] ID-263
[Ownablee.VAB_WALLET](contracts/dao/Ownablee.sol#L14) should be immutable 

contracts/dao/Ownablee.sol#L14


