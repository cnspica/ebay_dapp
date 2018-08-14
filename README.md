# ebay_dapp

## 区块链环境

- 打开Ganache，设置RPC server为127.0.0.1:8545
- npm install -g truffle
- cd ebay_dapp && truffle compile && truffle migrate --reset
- metamask通过private_key导入 Ganache中的一个账号，设置custom rpc为127.0.0.1:8545

## ipfs环境

- 安装ipfs
- ipfs init
- 跨域设置
    
    ```bash
    ipfs config --json API.HTTPHeaders.Access-Control-Allow-Methods '["PUT","GET", "POST", "OPTIONS"]'
    ipfs config --json API.HTTPHeaders.Access-Control-Allow-Origin '["*"]'
    ipfs config --json API.HTTPHeaders.Access-Control-Allow-Credentials '["true"]'
    ipfs config --json API.HTTPHeaders.Access-Control-Allow-Headers '["Authorization"]'
    ipfs config --json API.HTTPHeaders.Access-Control-Expose-Headers '["Location"]'
    ```
- ipfs daemon

## node环境

```bash
$ cd ebay_dapp
$ vim truffle.js
$ npm install
$ npm run dev
```

## tools

```bash
truffle compile
truffle migrate --reset


```

```
exec seed.js
var c
c = EcommerceStore.deployed().then(i=> c=i;); 

```
