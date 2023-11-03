// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {TOKENBOUND_REGISTRY} from "../Constants.sol";
import {IERC6551Registry} from "../interfaces/IERC6551Registry.sol";

error InvalidChainId();

library TBALib {
    function createAccount(address implmentation, address tokenContract, uint256 tokenId) external returns (address) {
        address account;

        if (block.chainid == 420) {
            account = IERC6551Registry(TOKENBOUND_REGISTRY).createAccount(
                implmentation,
                420,
                tokenContract,
                tokenId,
                7,
                ""
            );

        } else if (block.chainid == 80001) {
            account = IERC6551Registry(TOKENBOUND_REGISTRY).createAccount(
                implmentation,
                80001,
                tokenContract,
                tokenId,
                7,
                ""
            );
        } else if (block.chainid == 534351) {
            account = IERC6551Registry(TOKENBOUND_REGISTRY).createAccount(
                implmentation,
                534351,
                tokenContract,
                tokenId,
                7,
                ""
            );
        } else {
            revert InvalidChainId();
        }

        return account;
    }

    function getAccount(address implmentation, address tokenContract, uint256 tokenId) external view returns (address) {
        address account;

        if (block.chainid == 420) {
            account = IERC6551Registry(TOKENBOUND_REGISTRY).account(
                implmentation,
                420,
                tokenContract,
                tokenId,
                7
            );

        } else if (block.chainid == 80001) {
            account = IERC6551Registry(TOKENBOUND_REGISTRY).account(
                implmentation,
                80001,
                tokenContract,
                tokenId,
                7
            );
        } else if (block.chainid == 534351) {
            account = IERC6551Registry(TOKENBOUND_REGISTRY).account(
                implmentation,
                534351,
                tokenContract,
                tokenId,
                7
            );
        } else {
            revert InvalidChainId();
        }

        return account;
    }
}
