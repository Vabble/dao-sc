// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "../libraries/Helper.sol";
import "../libraries/Ownable.sol";
import "../interfaces/IUniHelper.sol";
import "../interfaces/IStakingPool.sol";
import "hardhat/console.sol";

contract FactoryNFT is Ownable, ERC721, ReentrancyGuard {
    using Counters for Counters.Counter;
    using Strings for uint256;

    event BatchMinted(address from, address to, uint256 mintAmount, uint256 revenueAmount);

    struct Mint {
        uint256 maxMintAmount;    // mint amount(ex: 10000 nft)
        uint256 mintPrice;        // mint price in usdc(ex: 5 usdc = 5*1e6)
        uint256 feePercent;       // it will be send to reward pool(2% max=10%)
        uint256 mintedAmount;     // current minted amount(<= maxMintAmount)
    }

    IERC20 private immutable PAYOUT_TOKEN;     // VAB token      
    address private immutable STAKING_POOL;    // StakingPool contract address
    address private immutable UNI_HELPER;      // UniHelper contract address
    address private immutable USDC_TOKEN;      // USDC token 

    Counters.Counter private nftCount;
    string public baseUri;                     // Base URI
    uint256 public immutable MAX_FEE_PERCENT;  // 10%(1% = 1e8, 100% = 1e10)

    mapping(uint256 => string) private tokenUriInfo; // (tokenId => tokenUri)    
    mapping(address => Mint) private mintInfo;       // (studio => Mint)
    
    constructor(
        address _payoutToken,
        address _stakingContract,
        address _uniHelperContract,
        address _usdcToken,
        string memory _name,
        string memory _symbol
    ) ERC721(_name, _symbol) {
        require(_payoutToken != address(0), "_payoutToken: Zero address");
        PAYOUT_TOKEN = IERC20(_payoutToken);        
        require(_stakingContract != address(0), "_stakingContract: Zero address");
        STAKING_POOL = _stakingContract;
        require(_uniHelperContract != address(0), "_uniHelperContract: Zero address");
        UNI_HELPER = _uniHelperContract;       
        require(_usdcToken != address(0), "_usdcToken: Zeor address");
        USDC_TOKEN = _usdcToken;

        MAX_FEE_PERCENT = 1e9;
    }

    /// @notice Set baseURI by Auditor.
    function setBaseURI(string memory _baseUri) external onlyAuditor {
        baseUri = _baseUri;
    }

    /// @notice Set mint info by Studio
    function setMintInfo(uint256 _amount, uint256 _price, uint256 _percent) external onlyStudio nonReentrant {
        require(_amount > 0 && _price > 0 && _percent > 0 && _percent <= MAX_FEE_PERCENT, "setMint: Zero value");

        Mint storage _mintInfo = mintInfo[msg.sender];
        _mintInfo.maxMintAmount = _amount; // 100
        _mintInfo.mintPrice = _price;      // 5 usdc = 5 * 1e6
        _mintInfo.feePercent = _percent;   // 2% = 2 * 1e9(1% = 1e9, 100% = 1e10)
    }    

    /// @notice Mint the multiple tokens to _to address
    function batchMintTo(
        address _to, 
        address _studio,
        address _payToken,
        uint256 _mintAmount, 
        string memory _tokenUri
    ) public payable nonReentrant {
        uint256 maxMintAmount = mintInfo[_studio].maxMintAmount;
        uint256 currentMintedAmount = mintInfo[_studio].mintedAmount;
        require(maxMintAmount > 0, "batchMintTo: should set mint info by studio");
        require(maxMintAmount >= _mintAmount + currentMintedAmount, "batchMintTo: exceed mint amount");

        uint256 totalPrice = mintInfo[_studio].mintPrice * _mintAmount;        
        uint256 expectAmount = IUniHelper(UNI_HELPER).expectedAmount(totalPrice, USDC_TOKEN, _payToken);
        console.log("sol=>amount::", totalPrice, expectAmount);
        
        // Return remain ETH to user back if case of ETH
        // Transfer Asset from buyer to this contract
        if(_payToken == address(0)) {
            require(msg.value >= expectAmount, "batchMintTo: Insufficient paid");
            if (msg.value > expectAmount) {
                Helper.safeTransferETH(msg.sender, msg.value - expectAmount);
            }
        } else {
            Helper.safeTransferFrom(_payToken, msg.sender, address(this), expectAmount);
        }                

        // Add VAB token to rewardPool after swap feeAmount(2%) from UniswapV2
        uint256 feeAmount = expectAmount * mintInfo[_studio].feePercent / 1e10;       
        if(_payToken == address(PAYOUT_TOKEN)) {
            IStakingPool(STAKING_POOL).addRewardToPool(feeAmount);
        } else {
            __addReward(feeAmount, _payToken);        
        }

        // Transfer token to "_studio" address
        uint256 revenueAmount = expectAmount - feeAmount;
        Helper.safeTransferAsset(_payToken, _studio, revenueAmount);
        
        // Mint nft to "_to" address
        for(uint256 i = 0; i < _mintAmount; i++) {
            __mintTo(_to, _studio, _tokenUri);
        }

        emit BatchMinted(_studio, _to, _mintAmount, revenueAmount);
    }

    /// @dev Add fee amount to rewardPool after swap from uniswap
    function __addReward(uint256 _feeAmount, address _payToken) private {
        if(_payToken == address(0)) {
            Helper.safeTransferETH(UNI_HELPER, _feeAmount);
        } else {
            if(IERC20(_payToken).allowance(address(this), UNI_HELPER) == 0) {
                Helper.safeApprove(_payToken, UNI_HELPER, IERC20(_payToken).totalSupply());
            }
        }         
        bytes memory swapArgs = abi.encode(_feeAmount, _payToken, address(PAYOUT_TOKEN));
        uint256 feeVABAmount = IUniHelper(UNI_HELPER).swapAsset(swapArgs);

        // Transfer it(VAB token) to rewardPool
        if(PAYOUT_TOKEN.allowance(address(this), STAKING_POOL) == 0) {
            Helper.safeApprove(address(PAYOUT_TOKEN), STAKING_POOL, PAYOUT_TOKEN.totalSupply());
        } 

        IStakingPool(STAKING_POOL).addRewardToPool(feeVABAmount);
    }

    /// @dev Mint the token to _to address
    function __mintTo(
        address _to, 
        address _studio,
        string memory _tokenUri
    ) private returns (uint256 newTokenId_) {
        newTokenId_ = __getNextTokenId();
        _safeMint(_to, newTokenId_);
        __setTokenURI(newTokenId_, _tokenUri);
        mintInfo[_studio].mintedAmount += 1;
    }

    function __getNextTokenId() private returns (uint256 newTokenId_) {
        nftCount.increment();
        newTokenId_ = nftCount.current();
    }

    function __setTokenURI(uint256 _tokenId, string memory _tokenUri) private {
        require(_exists(_tokenId), "ERC721Metadata: URI set of nonexistent token");
        tokenUriInfo[_tokenId] = _tokenUri;
    }

    /// @notice Set tokenURI in all available cases
    function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
        require(_exists(_tokenId), "ERC721Metadata: URI query for nonexistent token");
        
        string memory tokenUri = tokenUriInfo[_tokenId];
        
        // If there is no base URI, return the token URI.
        if (bytes(baseUri).length == 0) return tokenUri;

        // If both are set, concatenate the baseURI and tokenURI (via abi.encodePacked).
        if (bytes(tokenUri).length > 0) return string(abi.encodePacked(baseUri, tokenUri));

        // If there is a baseURI but no tokenURI, concatenate the tokenID to the baseURI.
        return string(abi.encodePacked(baseUri, _tokenId.toString()));
    }
    // function tokenURI_test(uint256 tokenId) public pure returns (string memory) {
    //     string[17] memory parts;
    //     parts[0] = '<svg xmlns="http://www.w3.org/2000/svg" preserveAspectRatio="xMinYMin meet" viewBox="0 0 350 350"><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width="100%" height="100%" fill="black" /><text x="10" y="20" class="base">';

    //     parts[1] = Strings.toString(tokenId);

    //     parts[2] = '</text></svg>';

    //     string memory output = string(abi.encodePacked(parts[0], parts[1], parts[2]));

    //     string memory json = Base64.encode(bytes(string(abi.encodePacked('{"name": "Badge #', Strings.toString(tokenId), '", "description": "A concise Hardhat tutorial Badge NFT with on-chain SVG images like look.", "image": "data:image/svg+xml;base64,', Base64.encode(bytes(output)), '"}'))));
    //     output = string(abi.encodePacked('data:application/json;base64,', json));

    //     return output;
    // }

    /// @notice Return total minited NFT count
    function totalSupply() public view returns (uint256) {
        return nftCount.current();
    }

    /// @notice Get mint information per studio
    function getMintInfo(address _studio) public view 
    returns (
        uint256 maxMintAmount_,
        uint256 mintPrice_,
        uint256 feePercent_,
        uint256 mintedAmount_
    ) {
        Mint storage info = mintInfo[_studio];
        maxMintAmount_ = info.maxMintAmount;
        mintPrice_ = info.mintPrice;
        feePercent_ = info.feePercent;
        mintedAmount_ = info.mintedAmount;
    }    
}