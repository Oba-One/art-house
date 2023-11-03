// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import {Ownable} from "openzeppelin-contracts/access/Ownable.sol";

import {EASLib} from "../lib/EAS.sol";

error NFCAlreadyRegistered();
error NFCAlreadyPaired();
error NFCNotRegistered();

contract NFCRegistry is Ownable {
    mapping(string => address) public nfcIdToIssuer;
    mapping(string => address) public nfcIdToNFT;

    constructor() {}

    function registerNFC(string memory nfcId) public {
        if (nfcIdToIssuer[nfcId] != address(0)) {
            revert NFCAlreadyRegistered();
        }

        nfcIdToIssuer[nfcId] = msg.sender;
    }

    function pairNFT(string memory nfcId, address nft) public {
        if (nfcIdToIssuer[nfcId] == address(0)) {
            revert NFCNotRegistered();
        }

        if (nfcIdToNFT[nfcId] != address(0)) {
            revert NFCAlreadyPaired();
        }

        nfcIdToNFT[nfcId] = nft;
    }
}
