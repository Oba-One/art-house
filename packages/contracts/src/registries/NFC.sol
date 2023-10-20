// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import {Ownable} from "openzeppelin-contracts/access/Ownable.sol";

import {EASLib} from "../lib/EAS.sol";

contract NFCRegistry is Ownable {
    struct NFCSchema {
        string id;
        address issuer;
    }

    mapping(string => address) public nfcIdToIssuer;

    constructor() {}

    function registerNFC(string memory nfcId) public {
    // TODO Check that id is not registered
    }
}
