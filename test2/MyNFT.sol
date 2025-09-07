// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

/**
 * @title MyNFT
 * @dev 一个基于ERC721标准的NFT合约，支持元数据存储和铸造功能
 */
contract MyNFT is ERC721, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    
    // 用于跟踪NFT的ID，确保每个NFT都有唯一的ID
    Counters.Counter private _tokenIdCounter;
    
    // 记录总铸造数量
    uint256 public totalMinted;
    
    // 最大铸造数量限制（可选）
    uint256 public constant MAX_SUPPLY = 10000;
    
    // 铸造事件，记录NFT的铸造信息
    event NFTMinted(address indexed to, uint256 indexed tokenId, string metadataURI);
    
    /**
     * @dev 构造函数，设置NFT的名称和符号
     * @param name NFT集合的名称
     * @param symbol NFT集合的符号
     */
    constructor(string memory name, string memory symbol) 
        ERC721(name, symbol) 
        Ownable(msg.sender)
    {
        // 从tokenId 1开始，0通常保留不用
        _tokenIdCounter.increment();
    }
    
    /**
     * @dev 铸造NFT函数，任何人都可以调用
     * @param recipient 接收NFT的地址
     * @param metadataURI NFT的元数据链接（IPFS链接）
     * @return 返回新铸造的NFT的tokenId
     */
    function mintNFT(address recipient, string memory metadataURI) 
        public 
        returns (uint256) 
    {
        require(recipient != address(0), "MyNFT: recipient cannot be zero address");
        require(bytes(metadataURI).length > 0, "MyNFT: metadataURI cannot be empty");
        require(totalMinted < MAX_SUPPLY, "MyNFT: maximum supply reached");
        
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        totalMinted++;
        
        // 铸造NFT到指定地址
        _safeMint(recipient, tokenId);
        
        // 设置NFT的元数据URI
        _setTokenURI(tokenId, metadataURI);
        
        // 触发铸造事件
        emit NFTMinted(recipient, tokenId, metadataURI);
        
        return tokenId;
    }
    
    /**
     * @dev 批量铸造NFT函数，只有合约拥有者可以调用
     * @param recipients 接收NFT的地址数组
     * @param metadataURIs NFT的元数据链接数组
     */
    function batchMintNFT(address[] memory recipients, string[] memory metadataURIs) 
        public 
        onlyOwner 
    {
        require(recipients.length == metadataURIs.length, "MyNFT: arrays length mismatch");
        require(recipients.length > 0, "MyNFT: empty arrays");
        require(totalMinted + recipients.length <= MAX_SUPPLY, "MyNFT: would exceed maximum supply");
        
        for (uint256 i = 0; i < recipients.length; i++) {
            mintNFT(recipients[i], metadataURIs[i]);
        }
    }
    
    /**
     * @dev 获取下一个将要铸造的tokenId
     * @return 下一个tokenId
     */
    function getNextTokenId() public view returns (uint256) {
        return _tokenIdCounter.current();
    }
    
    /**
     * @dev 检查某个tokenId是否存在
     * @param tokenId 要检查的tokenId
     * @return 是否存在
     */
    function exists(uint256 tokenId) public view returns (bool) {
        return _ownerOf(tokenId) != address(0);
    }
    
    /**
     * @dev 获取用户拥有的所有NFT的tokenId
     * @param owner 用户地址
     * @return 用户拥有的tokenId数组
     */
    function tokensOfOwner(address owner) public view returns (uint256[] memory) {
        uint256 tokenCount = balanceOf(owner);
        uint256[] memory tokenIds = new uint256[](tokenCount);
        uint256 index = 0;
        
        for (uint256 tokenId = 1; tokenId < _tokenIdCounter.current(); tokenId++) {
            if (exists(tokenId) && ownerOf(tokenId) == owner) {
                tokenIds[index] = tokenId;
                index++;
                if (index == tokenCount) break;
            }
        }
        
        return tokenIds;
    }
    
    // 重写必要的函数以支持ERC721URIStorage
    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
    
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
    
    /**
     * @dev 紧急情况下，合约拥有者可以暂停合约（可选功能）
     * 这里只是示例，实际使用时可以添加Pausable功能
     */
    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "MyNFT: no funds to withdraw");
        
        (bool success, ) = payable(owner()).call{value: balance}("");
        require(success, "MyNFT: withdrawal failed");
    }
}
