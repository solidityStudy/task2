# BeggingContract Remix部署和测试指南

## 环境准备

### 1. 安装MetaMask钱包
1. 在Chrome浏览器中安装MetaMask插件
2. 创建或导入钱包
3. 保存好助记词（非常重要！）

### 2. 配置测试网络

#### 添加Sepolia测试网（推荐）
- **网络名称**：Sepolia Test Network
- **RPC URL**：https://sepolia.infura.io/v3/YOUR_PROJECT_ID 或 https://rpc.sepolia.org
- **链ID**：11155111
- **符号**：ETH
- **区块浏览器**：https://sepolia.etherscan.io

#### 或添加Goerli测试网
- **网络名称**：Goerli Test Network
- **RPC URL**：https://goerli.infura.io/v3/YOUR_PROJECT_ID
- **链ID**：5
- **符号**：ETH
- **区块浏览器**：https://goerli.etherscan.io

### 3. 获取测试ETH

#### Sepolia测试币水龙头
- https://sepoliafaucet.com/
- https://www.alchemy.com/faucets/ethereum-sepolia
- https://sepolia-faucet.pk910.de/

#### Goerli测试币水龙头
- https://goerlifaucet.com/
- https://faucets.chain.link/goerli

## Remix IDE部署步骤

### 第一步：打开Remix IDE
1. 访问 https://remix.ethereum.org/
2. 等待IDE完全加载

### 第二步：创建合约文件
1. 在文件浏览器中，点击"contracts"文件夹
2. 右键点击 → "New File"
3. 文件名：`BeggingContract.sol`
4. 复制粘贴合约代码到文件中

### 第三步：编译合约
1. 点击左侧的"Solidity Compiler"图标（第二个）
2. 选择编译器版本：`0.8.19` 或更高版本
3. 点击"Compile BeggingContract.sol"按钮
4. 确保编译成功，没有错误信息

### 第四步：连接MetaMask
1. 点击左侧的"Deploy & Run Transactions"图标（第三个）
2. 在"Environment"下拉菜单中选择"Injected Provider - MetaMask"
3. MetaMask会弹出连接请求，点击"连接"
4. 确保MetaMask显示的是测试网络（Sepolia或Goerli）

### 第五步：部署合约
1. 在"Contract"下拉菜单中选择"BeggingContract"
2. 点击橙色的"Deploy"按钮
3. MetaMask会弹出交易确认，点击"确认"
4. 等待交易被确认（通常需要15-30秒）
5. 部署成功后，合约会出现在"Deployed Contracts"部分

## 合约测试步骤

### 测试1：捐赠功能（donate）

#### 方法1：使用donate函数
1. 在部署的合约中找到"donate"函数
2. 在函数上方的"Value"输入框中输入捐赠金额（例如：0.01）
3. 选择单位为"Ether"
4. 点击红色的"donate"按钮
5. MetaMask确认交易
6. 查看交易是否成功

#### 方法2：直接转账测试
1. 复制合约地址
2. 在MetaMask中点击"发送"
3. 粘贴合约地址作为接收方
4. 输入金额（例如0.005 ETH）
5. 发送交易
6. 这会自动调用合约的receive()函数

### 测试2：查询捐赠（getDonation）
1. 找到"getDonation"函数
2. 在输入框中输入您的钱包地址
3. 点击蓝色的"getDonation"按钮
4. 查看返回的捐赠金额（以wei为单位）

### 测试3：查看合约余额
1. 点击"getContractBalance"函数
2. 查看合约当前的总余额

### 测试4：查看捐赠者信息
1. 点击"getDonorCount"查看捐赠者总数
2. 点击"getAllDonors"查看所有捐赠者地址
3. 使用"getDonorByIndex"根据索引查看特定捐赠者

### 测试5：提取资金（withdraw）
**注意：只有合约部署者可以执行此操作**
1. 确保当前MetaMask账户是合约部署者
2. 点击红色的"withdraw"按钮
3. MetaMask确认交易
4. 检查您的钱包余额是否增加
5. 检查合约余额是否变为0

## 在Etherscan上验证

### 查看交易记录
1. 复制交易哈希
2. 访问对应的区块浏览器：
   - Sepolia: https://sepolia.etherscan.io
   - Goerli: https://goerli.etherscan.io
3. 在搜索框中粘贴交易哈希
4. 查看交易详情和状态

### 查看合约信息
1. 复制合约地址
2. 在区块浏览器中搜索合约地址
3. 查看合约余额、交易历史等信息

## 常见问题解决

### 1. 编译错误
- 检查Solidity版本是否正确（推荐0.8.19+）
- 确保代码没有语法错误
- 清除浏览器缓存后重试

### 2. 部署失败
- 确保MetaMask连接到正确的测试网
- 检查账户是否有足够的测试ETH
- 增加Gas Limit（建议设置为300000）

### 3. 交易失败
- 检查网络连接
- 确保Gas费用充足
- 等待网络拥堵缓解后重试

### 4. MetaMask连接问题
- 刷新Remix页面
- 重新连接MetaMask
- 检查MetaMask是否解锁

## 测试用例检查清单

- [ ] 合约成功编译
- [ ] 合约成功部署到测试网
- [ ] donate函数可以接收ETH
- [ ] getDonation函数返回正确金额
- [ ] getContractBalance显示正确余额
- [ ] getDonorCount显示正确数量
- [ ] withdraw函数可以提取资金（仅所有者）
- [ ] 在Etherscan上可以查看交易记录
- [ ] 直接转账到合约地址也能正常工作

## 提交材料准备

### 1. 合约代码
- 文件：`BeggingContract.sol`
- 确保代码格式整洁，注释完整

### 2. 合约地址
- 记录部署成功的合约地址
- 例如：`0x1234567890123456789012345678901234567890`

### 3. 测试截图
准备以下截图：
- Remix编译成功界面
- 合约部署成功界面
- donate函数调用成功
- getDonation查询结果
- withdraw函数执行成功
- Etherscan上的合约页面
- Etherscan上的交易记录

### 4. 测试报告
记录测试过程中的：
- 使用的测试网络
- 部署的gas费用
- 各个函数的测试结果
- 遇到的问题和解决方案

## 安全提醒

1. **私钥安全**：永远不要分享您的私钥或助记词
2. **测试网使用**：确保在测试网上进行所有测试
3. **代码审查**：部署前仔细检查合约代码
4. **权限管理**：注意合约所有者权限的重要性
5. **Gas费用**：合理设置Gas费用，避免交易失败

完成所有测试后，您就成功掌握了智能合约的部署和测试流程！
