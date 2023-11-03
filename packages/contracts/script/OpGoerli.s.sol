// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";

import {AccountGuardian} from "tokenbound/AccountGuardian.sol";
import {Create2} from "openzeppelin-contracts/utils/Create2.sol";
import {Strings} from "openzeppelin-contracts/utils/Strings.sol";

import {GoodTransferResolver} from "../src/resolvers/GoodTransfer.sol";

import {ArtAccount} from "../src/accounts/Art.sol";
import {HouseAccount} from "../src/accounts/House.sol";

import {NFCRegistry} from "../src/registries/NFC.sol";
import {ArtRegistry} from "../src/registries/Art.sol";
import {HouseRegistry} from "../src/registries/House.sol";

import {ArtTable} from "../src/tables/Art.sol";
import {HouseTable} from "../src/tables/House.sol";

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
        bytes32 salt = 0x655165516551655165516551655165516551655165516551655165516557;
        address factory = 0x4e59b44847b379578588920cA78FbF26c0B4956C;

        address artHouseSafe = 0x3F35aC99149fD564f9a3f5eC78d146aeE1db7387;
        address erc4337EntryPoint = 0x5FF137D4b0FDCD49DcA30c7CF57E578a026d2789;
        address multicallForwarder = 0xcA1167915584462449EE5b4Ea51c37fE81eCDCCD;
        address erc6551Registry = 0x8deDFee9BEEe2D64817Dd8dB8cff138C468Bd3Ef;

        address artTable = Create2.computeAddress(
            salt,
            keccak256(
                abi.encodePacked(
                    type(ArtTable).creationCode, abi.encode()
                )
            ),
            factory
        );

        address houseTable = Create2.computeAddress(
            salt,
            keccak256(
                abi.encodePacked(
                    type(HouseTable).creationCode, abi.encode()
                )
            ),
            factory
        );

        address guardian = Create2.computeAddress(
            salt,
            keccak256(
                abi.encodePacked(type(AccountGuardian).creationCode, abi.encode(artHouseSafe))
            ),
            factory
        );

        address artImplementation = Create2.computeAddress(
            salt,
            keccak256(
                abi.encodePacked(
                    type(ArtAccount).creationCode,
                    abi.encode(artTable , erc4337EntryPoint, multicallForwarder, erc6551Registry, guardian)
                )
            ),
            factory
        );

        address houseImplementation = Create2.computeAddress(
            salt,
            keccak256(
                abi.encodePacked(
                    type(HouseAccount).creationCode,
                    abi.encode(houseTable, erc4337EntryPoint, multicallForwarder, erc6551Registry, guardian)
                )
            ),
            factory
        );

        address artProxy = Create2.computeAddress(
            salt,
            keccak256(
                abi.encodePacked(
                    type(AccountProxy).creationCode, abi.encode(guardian, artImplementation)
                )
            ),
            factory
        );

        address houseProxy = Create2.computeAddress(
            salt,
            keccak256(
                abi.encodePacked(
                    type(AccountProxy).creationCode, abi.encode(guardian, houseImplementation)
                )
            ),
            factory
        );

        address goodTransferResolver = Create2.computeAddress(
            salt,
            keccak256(
                abi.encodePacked(
                    type(GoodTransferResolver).creationCode, abi.encode(EAS_OP)
                )
            ),
            factory
        );

        address nfcRegistry = Create2.computeAddress(
            salt,
            keccak256(
                abi.encodePacked(
                    type(NFCRegistry).creationCode, abi.encode()
                )
            ),
            factory
        );

        address artRegistry = Create2.computeAddress(
            salt,
            keccak256(
                abi.encodePacked(
                    type(ArtRegistry).creationCode, abi.encode(artTable, artImplementation, nfcRegistry, goodTransferResolver, "Art")
                )
            ),
            factory
        );

        address houseRegistry = Create2.computeAddress(
            salt,
            keccak256(
                abi.encodePacked(
                    type(HouseRegistry).creationCode, abi.encode(houseTable, houseImplementation, "House")
                )
            ),
            factory
        );

        uint256 deployerPrivateKey = vm.envUint("FORGE_PRIVATE_KEY");

         // Deploy Art Table
        if (artTable.code.length == 0) {
            vm.startBroadcast(deployerPrivateKey);
            new ArtTable{salt: salt}();
            vm.stopBroadcast();

            console.log("ArtTable:", artTable, "(deployed)");
        } else {
            console.log("ArtTable:", artTable, "(exists)");
        }

        // Deploy House Table
        if (houseTable.code.length == 0) {
            vm.startBroadcast(deployerPrivateKey);
            new HouseTable{salt: salt}();
            vm.stopBroadcast();

            console.log("HouseTable:", houseTable, "(deployed)");
        } else {
            console.log("HouseTable:", houseTable, "(exists)");
        }

        // Deploy AccountGuardian
        if (guardian.code.length == 0) {
            vm.startBroadcast(deployerPrivateKey);
            new AccountGuardian{salt: salt}(artHouseSafe);
            vm.stopBroadcast();

            console.log("AccountGuardian:", guardian, "(deployed)");
        } else {
            console.log("AccountGuardian:", guardian, "(exists)");
        }

        // Deploy Art Account Implementation
        if (artImplementation.code.length == 0) {
            vm.startBroadcast(deployerPrivateKey);
            new ArtAccount{salt: salt}(
                erc4337EntryPoint,
                multicallForwarder,
                erc6551Registry,
                guardian
            );
            vm.stopBroadcast();

            console.log("ArtAccount:", implementation, "(deployed)");
        } else {
            console.log("ArtAccount:", implementation, "(exists)");
        }

        // Deploy House Account Implementation
        if (houseImplementation.code.length == 0) {
            vm.startBroadcast(deployerPrivateKey);
            new HouseAccount{salt: salt}(
                erc4337EntryPoint,
                multicallForwarder,
                erc6551Registry,
                guardian
            );
            vm.stopBroadcast();

            console.log("HouseAccount:", implementation, "(deployed)");
        } else {
            console.log("HouseAccount:", implementation, "(exists)");
        }

        // Deploy Art Account Proxy
        if (artProxy.code.length == 0) {
            vm.startBroadcast(deployerPrivateKey);
            new ArtAccount{salt: salt}(guardian, artImplementation);
            vm.stopBroadcast();

            console.log("ArtAccount:", artProxy, "(deployed)");
        } else {
            console.log("ArtAccount:", artProxy, "(exists)");
        }

        // Deploy House Account Proxy
        if (houseProxy.code.length == 0) {
            vm.startBroadcast(deployerPrivateKey);
            new HouseAccount{salt: salt}(guardian, houseImplementation);
            vm.stopBroadcast();

            console.log("HouseAccount:", houseProxy, "(deployed)");
        } else {
            console.log("HouseAccount:", houseProxy, "(exists)");
        }

        // Deploy Good Transfer Resolver
        if (goodTransferResolver.code.length == 0) {
            vm.startBroadcast(deployerPrivateKey);
            new GoodTransferResolver{salt: salt}(EAS_OP);
            vm.stopBroadcast();

            console.log("GoodTransferResolver:", goodTransferResolver, "(deployed)");
        } else {
            console.log("GoodTransferResolver:", goodTransferResolver, "(exists)");
        }

        // Deploy NFC Registry
        if (nfcRegistry.code.length == 0) {
            vm.startBroadcast(deployerPrivateKey);
            new NFCRegistry{salt: salt}();
            vm.stopBroadcast();

            console.log("NFCRegistry:", nfcRegistry, "(deployed)");
        } else {
            console.log("NFCRegistry:", nfcRegistry, "(exists)");
        }

        // Deploy Art Registry
        if (artRegistry.code.length == 0) {
            vm.startBroadcast(deployerPrivateKey);
            new ArtRegistry{salt: salt}(
                artTable,
                artImplementation,
                nfcRegistry,
                goodTransferResolver,
                "Art"
            );
            vm.stopBroadcast();

            console.log("ArtRegistry:", artRegistry, "(deployed)");
        } else {
            console.log("ArtRegistry:", artRegistry, "(exists)");
        }

        // Deploy House Registry
        if (houseRegistry.code.length == 0) {
            vm.startBroadcast(deployerPrivateKey);
            new HouseRegistry{salt: salt}(
                houseTable,
                houseImplementation,
                "House"
            );
            vm.stopBroadcast();

            console.log("HouseRegistry:", houseRegistry, "(deployed)");
        } else {
            console.log("HouseRegistry:", houseRegistry, "(exists)");
        }
    }
}
