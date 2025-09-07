# 🚀 Remix 部署 ERC20 代币完整指南

## 📋 快速开始清单

### 准备工作（5分钟）
- [ ] 安装 MetaMask 钱包
- [ ] 添加 Sepolia 测试网络
- [ ] 获取测试 ETH
- [ ] 打开 Remix IDE

### 部署步骤（10分钟）
- [ ] 复制合约代码到 Remix
- [ ] 编译合约
- [ ] 连接 MetaMask
- [ ] 部署合约
- [ ] 验证功能

---

## 🔧 详细操作步骤

### 第一步：准备 MetaMask 钱包

1. **安装 MetaMask**
   - 访问 [MetaMask官网](https://metamask.io/)
   - 下载并安装浏览器插件
   - 创建新钱包或导入现有钱包

2. **添加 Sepolia 测试网络**
   ```
   网络名称: Sepolia Test Network
   RPC URL: https://sepolia.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161
   链 ID: 11155111
   符号: ETH
   区块浏览器: https://sepolia.etherscan.io
   ```

3. **获取测试 ETH**
   - 访问 [Sepolia Faucet](https://sepoliafaucet.com/)
   - 输入你的钱包地址
   - 等待接收测试 ETH（通常几分钟内到账）

### 第二步：在 Remix 中部署合约

1. **打开 Remix IDE**
   - 访问 [https://remix.ethereum.org/](https://remix.ethereum.org/)

2. **创建合约文件**
   - 在左侧文件浏览器中，点击 "+" 创建新文件
   - 命名为 `MyToken.sol`
   - 复制 `MyTokenForRemix.sol` 的完整代码到文件中

3. **编译合约**
   - 点击左侧 "Solidity Compiler" 图标 📄
   - 选择编译器版本 `0.8.19` 或更高
   - 点击 "Compile MyToken.sol"
   - 确保显示绿色勾号，无错误提示

4. **部署合约**
   - 点击左侧 "Deploy & Run Transactions" 图标 🚀
   - Environment 选择 "Injected Provider - MetaMask"
   - 点击 "Connect to MetaMask" 并授权连接
   - 确保 MetaMask 切换到 Sepolia 网络
   - 在 Contract 下拉菜单选择 "MyToken"
   
5. **设置构造函数参数**
   ```
   _NAME: "My Token"
   _SYMBOL: "MTK"
   _DECIMALS: 18
   _INITIALSUPPLY: 1000000
   ```
   
6. **执行部署**
   - 点击橙色 "Deploy" 按钮
   - MetaMask 会弹出交易确认窗口
   - 检查 Gas 费用，点击 "确认"
   - 等待交易确认（通常1-2分钟）

### 第三步：验证部署结果

1. **查看部署的合约**
   - 部署成功后，在 "Deployed Contracts" 区域会显示合约
   - 记录合约地址（以 0x 开头的长字符串）

2. **测试合约功能**
   ```solidity
   // 点击蓝色按钮查询信息
   name()          // 返回: "My Token"
   symbol()        // 返回: "MTK"
   decimals()      // 返回: 18
   totalSupply()   // 返回: 1000000000000000000000000
   balanceOf()     // 输入你的地址，查看余额
   ```

3. **在 Etherscan 上查看**
   - 访问 `https://sepolia.etherscan.io/address/你的合约地址`
   - 可以看到合约的所有交易记录

### 第四步：添加到 MetaMask

1. **导入自定义代币**
   - 打开 MetaMask
   - 点击 "导入代币"
   - 选择 "自定义代币"
   - 填写信息：
     ```
     代币合约地址: 你的合约地址
     代币符号: MTK
     小数精度: 18
     ```
   - 点击 "添加自定义代币"

2. **查看代币余额**
   - 在 MetaMask 主界面应该能看到你的 MTK 代币
   - 余额应该显示 1,000,000 MTK

---

## 🧪 测试合约功能

### 基础功能测试

1. **查询功能**（蓝色按钮，不消耗 Gas）
   ```solidity
   totalSupply()                    // 查看总供应量
   balanceOf("地址")                // 查看指定地址余额
   allowance("所有者", "被授权者")   // 查看授权额度
   ```

2. **转账测试**（橙色按钮，消耗 Gas）
   ```solidity
   transfer("接收方地址", 1000000000000000000)  // 转账 1 个代币
   ```

3. **授权测试**
   ```solidity
   approve("被授权地址", 500000000000000000)   // 授权 0.5 个代币
   ```

4. **增发测试**（仅合约所有者）
   ```solidity
   mint("接收方地址", 1000000000000000000)     // 增发 1 个代币
   ```

### 注意事项

- **数量单位**: 由于小数位数是 18，所以 1 个代币 = 1000000000000000000 wei
- **Gas 费用**: 每次交易都需要支付少量 ETH 作为 Gas 费
- **交易确认**: 测试网交易通常 1-2 分钟确认
- **错误处理**: 如果交易失败，检查余额和授权额度是否足够

---

## 🎯 常见问题解决

### Q: MetaMask 连接失败
**A**: 确保浏览器允许弹窗，刷新 Remix 页面重试

### Q: 编译失败
**A**: 检查 Solidity 版本是否选择 0.8.0 以上

### Q: 部署时 Gas 估算失败
**A**: 确保钱包有足够的测试 ETH，至少 0.01 ETH

### Q: 代币不显示在 MetaMask
**A**: 手动添加代币合约地址到 MetaMask

### Q: 转账失败
**A**: 检查接收方地址格式是否正确，余额是否足够

---

## 🏆 恭喜！

你已经成功：
- ✅ 部署了自己的 ERC20 代币
- ✅ 学会了使用 Remix IDE
- ✅ 掌握了 MetaMask 钱包操作
- ✅ 理解了智能合约的基本交互

现在你可以：
- 转账给朋友测试
- 尝试增发更多代币
- 学习更高级的 DeFi 功能
- 探索其他类型的智能合约

**继续加油学习 Solidity！** 🚀
