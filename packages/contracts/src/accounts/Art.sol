// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import {Account} from "tokenbound/Account.sol";
import {Initializable} from "openzeppelin-contracts/proxy/utils/Initializable.sol";

import {NFCRegistry} from "../registries/NFC.sol";
import {EASLib} from "../lib/EAS.sol";

contract ArtAccount is Account, Initializable {
    string public nfcId;
    address public artTable;

    constructor(address _artTable, address _guardian, address _entryPoint) Account(_guardian, _entryPoint) {
        artTable = _artTable;
    }

    function initialize(string memory _nfcId) external initializer {
        nfcId = _nfcId;
    }

    function startTransfer() external returns (uint256, uint256) {
        return (0, 0);
    }

    function approveTransfer() external onlyOwner returns (uint256, uint256) {
        return (0, 0);
    }

    function completeTransfer() external returns (uint256, uint256) {
        return (0, 0);
    }

    function update() external returns (uint256, uint256) {
        return (0, 0);
    }
}
