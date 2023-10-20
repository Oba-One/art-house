// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {TOKENBOUND_REGISTRY} from "../Constants.sol";
import {IERC6551Registry} from "../interfaces/IERC6551Registry.sol";

error InvalidChainId();

library TBALib {
    function createAccount(address account, address tokenContract, uint256 tokenId) external {
        if (block.chainid == 420) {
            IERC6551Registry(TOKENBOUND_REGISTRY).createAccount(
                account,
                420,
                tokenContract,
                tokenId,
                7,
                ""
            );
        } else if (block.chainid == 80001) {
            IERC6551Registry(TOKENBOUND_REGISTRY).createAccount(
                account,
                80001,
                tokenContract,
                tokenId,
                7,
                ""
            );
        } else if (block.chainid == 534351) {
            IERC6551Registry(TOKENBOUND_REGISTRY).createAccount(
                account,
                534351,
                tokenContract,
                tokenId,
                7,
                ""
            );
        } else {
            revert InvalidChainId();
        }
    }
}
