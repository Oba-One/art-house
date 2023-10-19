// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

library EASLib {
    function attest(address house, string memory nfcId, string memory metadata) external {
        if (block.chainid == 420) {
            // TODO: make attestations for each chain
        } else if (block.chainid == 80001) {
            // TODO: make attestations for each chain
        } else if (block.chainid == 534351) {
            // TODO: make attestations for each chain
        } else {
            revert("Invalid chain id");
        }
    }

    function revoke(address house, string memory nfcId, string memory metadata) external {
        if (block.chainid == 420) {
            // TODO: make attestations for each chain
        } else if (block.chainid == 80001) {
            // TODO: make attestations for each chain
        } else if (block.chainid == 534351) {
            // TODO: make attestations for each chain
        } else {
            revert("Invalid chain id");
        }
    }
}
