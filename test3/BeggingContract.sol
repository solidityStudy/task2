// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title BeggingContract - 讨饭合约
 * @dev 允许用户向合约捐赠以太币，合约所有者可以提取资金
 * @author Solidity学习者
 */
contract BeggingContract {
    // 合约所有者地址
    address public owner;
    
    // 记录每个捐赠者的总捐赠金额
    mapping(address => uint256) public donations;
    
    // 记录所有捐赠者的地址数组（用于遍历）
    address[] public donors;
    
    // 合约总接收金额
    uint256 public totalDonations;
    
    // 事件：记录捐赠行为
    event DonationReceived(address indexed donor, uint256 amount, uint256 timestamp);
    
    // 事件：记录提取行为
    event FundsWithdrawn(address indexed owner, uint256 amount, uint256 timestamp);
    
    /**
     * @dev 构造函数，设置合约部署者为所有者
     */
    constructor() {
        owner = msg.sender;
    }
    
    /**
     * @dev 只有合约所有者可以执行的修饰符
     */
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can perform this action");
        _;
    }
    
    /**
     * @dev 捐赠函数，允许用户向合约发送以太币
     * 使用payable修饰符接收以太币
     */
    function donate() public payable {
        require(msg.value > 0, "Donation amount must be greater than 0");
        
        // 如果是首次捐赠，将地址添加到捐赠者数组
        if (donations[msg.sender] == 0) {
            donors.push(msg.sender);
        }
        
        // 记录捐赠金额
        donations[msg.sender] += msg.value;
        totalDonations += msg.value;
        
        // 触发捐赠事件
        emit DonationReceived(msg.sender, msg.value, block.timestamp);
    }
    
    /**
     * @dev 提取函数，只有合约所有者可以提取所有资金
     */
    function withdraw() public onlyOwner {
        uint256 contractBalance = address(this).balance;
        require(contractBalance > 0, "No funds available for withdrawal");
        
        // 使用call方法转账（推荐的安全方式）
        (bool success, ) = payable(owner).call{value: contractBalance}("");
        require(success, "Transfer failed");
        
        // 触发提取事件
        emit FundsWithdrawn(owner, contractBalance, block.timestamp);
    }
    
    /**
     * @dev 查询某个地址的捐赠金额
     * @param donor 捐赠者地址
     * @return 该地址的总捐赠金额
     */
    function getDonation(address donor) public view returns (uint256) {
        return donations[donor];
    }
    
    /**
     * @dev 获取合约当前余额
     * @return 合约当前的以太币余额
     */
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
    
    /**
     * @dev 获取捐赠者总数
     * @return 捐赠者数量
     */
    function getDonorCount() public view returns (uint256) {
        return donors.length;
    }
    
    /**
     * @dev 获取指定索引的捐赠者地址
     * @param index 捐赠者在数组中的索引
     * @return 捐赠者地址
     */
    function getDonorByIndex(uint256 index) public view returns (address) {
        require(index < donors.length, "Index out of bounds");
        return donors[index];
    }
    
    /**
     * @dev 获取所有捐赠者地址（注意：如果捐赠者很多，可能会消耗大量gas）
     * @return 所有捐赠者地址数组
     */
    function getAllDonors() public view returns (address[] memory) {
        return donors;
    }
    
    /**
     * @dev 紧急停止函数，允许所有者在紧急情况下提取资金
     * 这是一个额外的安全功能
     */
    function emergencyWithdraw() public onlyOwner {
        uint256 contractBalance = address(this).balance;
        require(contractBalance > 0, "No funds available");
        
        (bool success, ) = payable(owner).call{value: contractBalance}("");
        require(success, "Emergency withdrawal failed");
        
        emit FundsWithdrawn(owner, contractBalance, block.timestamp);
    }
    
    /**
     * @dev 转移合约所有权
     * @param newOwner 新所有者地址
     */
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "New owner cannot be zero address");
        require(newOwner != owner, "New owner must be different from current owner");
        
        owner = newOwner;
    }
    
    /**
     * @dev 接收以太币的回退函数
     * 当有人直接向合约地址发送以太币时会调用此函数
     */
    receive() external payable {
        donate();
    }
    
    /**
     * @dev 回退函数，处理不匹配任何函数的调用
     */
    fallback() external payable {
        donate();
    }
}
