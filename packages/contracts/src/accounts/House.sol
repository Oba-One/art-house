// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import {AccountV3} from "tokenbound/AccountV3.sol";

import {HouseTable} from "../tables/House.sol";

error NotHouseOwner();

contract HouseAccount is AccountV3 {
    address private _houseTable;

    constructor(
        address houseTable,
        address erc4337EntryPoint,
        address multicallForwarder,
        address erc6551Registry,
        address guardian
    ) AccountV3(erc4337EntryPoint, multicallForwarder, erc6551Registry, guardian) {
        _houseTable = houseTable;
    }

    function updateName(string memory name) external returns () {
        if (_isValidSigner(msg.sender) == false) {
            revert NotHouseOwner();
        }

        HouseTable(_houseTable).updateName(name);
    }

    function updateDescription(string memory description) external returns () {
        if (_isValidSigner(msg.sender) == false) {
            revert NotHouseOwner();
        }

        HouseTable(_houseTable).updateDescription(description);
    }

    function updateStyle(uint style) external returns () {
        if (_isValidSigner(msg.sender) == false) {
            revert NotHouseOwner();
        }

        HouseTable(_houseTable).updateStyle(style);
    }

    function updateImage(string memory image) external returns () {
        if (_isValidSigner(msg.sender) == false) {
            revert NotHouseOwner();
        }

        HouseTable(_houseTable).updateImage(image);
    }
}
