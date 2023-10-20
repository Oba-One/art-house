// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import {Script} from "forge-std/Script.sol";
import {AccountGuardian} from "tokenbound/AccountGuardian.sol";

import {ArtAccount} from "../src/accounts/Art.sol";
import {HouseAccount} from "../src/accounts/House.sol";
import {MemberAccount} from "../src/accounts/Member.sol";

import {NFCRegistry} from "../src/registries/NFC.sol";
import {ArtRegistry} from "../src/registries/Art.sol";
import {HouseRegistry} from "../src/registries/House.sol";
import {MemberRegistry} from "../src/registries/Member.sol";

import {ArtTable} from "../src/tables/Art.sol";
import {HouseTable} from "../src/tables/House.sol";
import {MemberTable} from "../src/tables/Member.sol";

import {GoodTransferResolver} from "../src/resolvers/GoodTransfer.sol";

import {EAS_OP} from "../src/Constants.sol";

/**
 * @title OpScript
 * @notice Script for deploying Contracts.
 * @dev https://book.getfoundry.sh/reference/forge/forge-script
 *
 * @dev This script is used to create Contracts
 * example start anvil with `anvil` command and then run
 * @dev Scripts can be used for development and testing, but they are not required for production.
 */
contract OpScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("FORGE_PRIVATE_KEY");

        // Start Broadcasting Transactions
        vm.startBroadcast(deployerPrivateKey);

        // 1. Deploy Good Transfer Resolver
        GoodTransferResolver goodTransferResolver = new GoodTransferResolver(EAS_OP);

        // 2. Deploy Tables
        ArtTable artTable = new ArtTable();
        HouseTable houseTable = new HouseTable();
        MemberTable memberTable = new MemberTable();

        // 3. Deploy Accounts to get implementations
        AccountGuardian accountGuardian = new AccountGuardian();

        ArtAccount artAccount = new ArtAccount(address(artTable), address(accountGuardian), address(goodTransferResolver));
        HouseAccount houseAccount = new HouseAccount(address(houseTable), address(accountGuardian), address(goodTransferResolver));
        MemberAccount memberAccount = new MemberAccount(address(memberTable), address(accountGuardian), address(goodTransferResolver));


        // 4. Deploy Registries
        NFCRegistry nfcRegistry = new NFCRegistry();
        ArtRegistry artRegistry = new ArtRegistry(
            address(artTable), address(NFCRegistry), address(goodTransferResolver), "Art"
        );

        // Stop Broadcasting Transactions
        vm.stopBroadcast();
    }
}
