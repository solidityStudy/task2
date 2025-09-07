// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @title MyToken
 * @dev 一个完整的 ERC20 代币合约实现
 * 包含标准 ERC20 功能和 mint 增发功能
 */
contract MyToken is IERC20 {
    // 代币基本信息
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 private _totalSupply;
    
    // 合约所有者
    address public owner;
    
    // 存储账户余额的映射
    mapping(address => uint256) private _balances;
    
    // 存储授权信息的映射：owner => spender => amount
    mapping(address => mapping(address => uint256)) private _allowances;
    
    // 修饰符：仅合约所有者可调用
    modifier onlyOwner() {
        require(msg.sender == owner, "MyToken: caller is not the owner");
        _;
    }
    
    /**
     * @dev 构造函数
     * @param _name 代币名称
     * @param _symbol 代币符号
     * @param _decimals 小数位数
     * @param _initialSupply 初始供应量
     */
    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _initialSupply
    ) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        owner = msg.sender;
        
        // 将初始供应量分配给合约部署者
        _totalSupply = _initialSupply * 10**_decimals;
        _balances[msg.sender] = _totalSupply;
        
        // 触发转账事件（从零地址到部署者）
        emit Transfer(address(0), msg.sender, _totalSupply);
    }
    
    /**
     * @dev 返回代币总供应量
     */
    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }
    
    /**
     * @dev 返回指定账户的代币余额
     */
    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }
    
    /**
     * @dev 转账功能
     */
    function transfer(address to, uint256 amount) public override returns (bool) {
        address from = msg.sender;
        _transfer(from, to, amount);
        return true;
    }
    
    /**
     * @dev 查询授权额度
     */
    function allowance(address tokenOwner, address spender) public view override returns (uint256) {
        return _allowances[tokenOwner][spender];
    }
    
    /**
     * @dev 授权功能
     */
    function approve(address spender, uint256 amount) public override returns (bool) {
        address tokenOwner = msg.sender;
        _approve(tokenOwner, spender, amount);
        return true;
    }
    
    /**
     * @dev 代扣转账功能
     */
    function transferFrom(address from, address to, uint256 amount) public override returns (bool) {
        address spender = msg.sender;
        
        // 检查并更新授权额度
        uint256 currentAllowance = allowance(from, spender);
        require(currentAllowance >= amount, "MyToken: insufficient allowance");
        
        // 执行转账
        _transfer(from, to, amount);
        
        // 减少授权额度
        _approve(from, spender, currentAllowance - amount);
        
        return true;
    }
    
    /**
     * @dev 增发代币功能（仅合约所有者可调用）
     */
    function mint(address to, uint256 amount) public onlyOwner {
        require(to != address(0), "MyToken: mint to the zero address");
        
        _totalSupply += amount;
        _balances[to] += amount;
        
        emit Transfer(address(0), to, amount);
    }
    
    /**
     * @dev 内部转账函数
     */
    function _transfer(address from, address to, uint256 amount) internal {
        require(from != address(0), "MyToken: transfer from the zero address");
        require(to != address(0), "MyToken: transfer to the zero address");
        
        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "MyToken: transfer amount exceeds balance");
        
        // 更新余额
        _balances[from] = fromBalance - amount;
        _balances[to] += amount;
        
        emit Transfer(from, to, amount);
    }
    
    /**
     * @dev 内部授权函数
     */
    function _approve(address tokenOwner, address spender, uint256 amount) internal {
        require(tokenOwner != address(0), "MyToken: approve from the zero address");
        require(spender != address(0), "MyToken: approve to the zero address");
        
        _allowances[tokenOwner][spender] = amount;
        emit Approval(tokenOwner, spender, amount);
    }
    
    /**
     * @dev 转移合约所有权
     */
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "MyToken: new owner is the zero address");
        owner = newOwner;
    }
    
    /**
     * @dev 销毁代币功能（仅合约所有者可调用）
     */
    function burn(uint256 amount) public onlyOwner {
        require(_balances[msg.sender] >= amount, "MyToken: burn amount exceeds balance");
        
        _balances[msg.sender] -= amount;
        _totalSupply -= amount;
        
        emit Transfer(msg.sender, address(0), amount);
    }
}
