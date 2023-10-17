require("dotenv/config");
require("hardhat-contract-sizer");
require("@nomicfoundation/hardhat-foundry");
require("@nomicfoundation/hardhat-toolbox");
require("@openzeppelin/hardhat-upgrades");

const {
  ETHEREUM_SCROLL_SEPOLIA_PROVIDER_URL = "https://sepolia-rpc.scroll.io/",
  ETHEREUM_OP_GOERLI_PROVIDER_URL = "https://op-goerli.g.alchemy.com/v2/IoQ-Xhgcg-Yuc4h_6Yk_6c8iJoKysKWk",
  ETHEREUM_POLYGON_MUMBAI_PROVIDER_URL = "https://polygon-mumbai.g.alchemy.com/v2/V1ADvYFrja2nCZH19GPBcQootx5bHZYz",
  ETHERSCAN_API_KEY,
  FORGE_PRIVATE_KEY:
    deployer = "ledger://0x0000000000000000000000000000000000000000",

  PROFILE: isProfiling,
} = process.env;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: {
    version: "0.8.21",
    settings: {
      optimizer: {
        enabled: true,
        runs: 1000000,
      },
      metadata: {
        bytecodeHash: "none",
      },
    },
  },
  paths: {
    deploy: ["deploy"],
  },
  typechain: {
    target: "ethers-v6",
  },
  networks: {
    hardhat: {
      accounts: {
        count: 20,
        accountsBalance: "10000000000000000000000000000000000000000000000",
      },
      allowUnlimitedContractSize: true,
      saveDeployments: false,
      live: false,
    },
    "scroll-sepolia": {
      chainId: 534351,
      url: ETHEREUM_SCROLL_SEPOLIA_PROVIDER_URL,
      saveDeployments: true,
      live: true,
      accounts: [deployer],
    },
    "op-goerli": {
      chainId: 84531,
      url: ETHEREUM_OP_GOERLI_PROVIDER_URL,
      saveDeployments: true,
      live: true,
      // gasMultiplier: 2,
      // gasPrice: 1000000000,
      accounts: [deployer],
    },
    "polygon-mumbai": {
      chainId: 80001,
      url: ETHEREUM_POLYGON_MUMBAI_PROVIDER_URL,
      saveDeployments: true,
      live: true,
      accounts: [deployer],
    },
  },
  contractSizer: {
    alphaSort: true,
    runOnCompile: true,
    disambiguatePaths: false,
  },
  verify: {
    etherscan: {
      apiKey: ETHERSCAN_API_KEY,
    },
  },
  gasReporter: {
    currency: "USD",
    enabled: isProfiling,
  },
};
