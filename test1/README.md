# MyToken - ERC20 代币合约项目

这是一个完整的 ERC20 代币合约实现项目，使用 Remix 在线 IDE 进行部署。

## 📁 项目结构

```
task2/
├── MyTokenForRemix.sol     # ERC20 代币合约（使用 OpenZeppelin 导入）
├── README.md               # 项目说明文档
└── Remix部署指南.md        # 详细的 Remix 部署步骤
```

## 📋 文件详细说明

### MyTokenForRemix.sol
- **作用**: 完整的 ERC20 代币合约实现
- **特点**: 
  - 使用 `@openzeppelin/contracts/token/ERC20/IERC20.sol` 远程导入
  - 适合 Remix 在线 IDE 直接编译和部署
  - 无需本地环境配置
- **功能特性**:
  - ✅ 实现所有标准 ERC20 功能
  - ✅ 包含 `mint()` 增发功能（仅合约所有者）
  - ✅ 包含 `burn()` 销毁功能（仅合约所有者）
  - ✅ 所有者权限管理
  - ✅ 完整的安全检查
  - ✅ 详细的中文注释

## 🚀 快速开始

### 重要说明
在 Remix 中，OpenZeppelin 导入会自动处理。当你编译合约时，Remix 会自动下载所需的依赖包。

### 部署步骤

1. **打开 Remix IDE**
   - 访问 [https://remix.ethereum.org/](https://remix.ethereum.org/)

2. **创建合约文件**
   - 创建新文件 `MyToken.sol`
   - 复制 `MyTokenForRemix.sol` 的完整代码

3. **编译合约**
   - 选择 Solidity 编译器版本 `0.8.0` 以上
   - 点击编译，Remix 会自动下载 OpenZeppelin 依赖

4. **部署到 Sepolia**
   - 连接 MetaMask 钱包
   - 选择 Sepolia 测试网
   - 设置构造函数参数并部署

详细步骤请参考 `Remix部署指南.md` 文件。

## 🔧 合约功能

### 标准 ERC20 功能
- `totalSupply()` - 查询总供应量
- `balanceOf(address)` - 查询账户余额
- `transfer(address, uint256)` - 直接转账
- `approve(address, uint256)` - 授权功能
- `transferFrom(address, address, uint256)` - 代扣转账
- `allowance(address, address)` - 查询授权额度

### 扩展功能
- `mint(address, uint256)` - 增发代币（仅所有者）
- `burn(uint256)` - 销毁代币（仅所有者）
- `transferOwnership(address)` - 转移所有权

## 📱 添加到 MetaMask

部署成功后：
1. 打开 MetaMask → "导入代币"
2. 输入合约地址
3. 代币符号：MTK，小数位数：18

## 🎯 技术特点

- ✅ 使用 OpenZeppelin 标准库
- ✅ 完整的安全检查
- ✅ 详细的中文注释
- ✅ 适合初学者学习

---

**详细部署步骤请查看 `Remix部署指南.md`** 🚀

## 🔍 在 Etherscan 上查看

部署成功后，可以在 Sepolia Etherscan 上查看合约：
```
https://sepolia.etherscan.io/address/你的合约地址
```

## ⚠️ 重要提示

1. **测试网部署**: 这是在测试网上部署，使用的是测试 ETH，没有实际价值
2. **私钥安全**: 永��不要泄露你的私钥或助记词
3. **合约验证**: 可以在 Etherscan 上验证合约源码以增加透明度
4. **Gas 费用**: 部署和交互都需要支付 Gas 费用（测试网免费）

## 🎯 学习要点

通过这个项目，你将学会：
- ERC20 代币标准的完整实现
- Solidity 合约开发基础
- 使用 Remix 进行合约部署
- MetaMask 钱包的使用
- 以太坊测试网的操作

## 📚 扩展学习

- 了解更多 ERC 标准（ERC721, ERC1155）
- 学习 DeFi 协议开发
- 探索智能合约安全最佳实践
- 学习使用 Hardhat 等开发框架

---

**祝你学习愉快！如果遇到问题，可以随时询问。** 🚀
