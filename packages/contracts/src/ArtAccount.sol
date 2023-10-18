// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Account} from "@tokenbound/contracts/Account.sol";

contract ArtAccount is Account {
    string public nfcID;

    function initialize(string memory _nfcID) external initializer {
        nfcID = _nfcID;
    }

    function startTransfer() external returns (uint256, uint256) {
        return (0, 0);
    }

    function approveTransfer() external returns (uint256, uint256) {
        return (0, 0);
    }

    function completeTransfer() external returns (uint256, uint256) {
        return (0, 0);
    }

    function moveHouse() external returns (uint256, uint256) {
        return (0, 0);
    }

    function update() external returns (uint256, uint256) {
        return (0, 0);
    }
}
