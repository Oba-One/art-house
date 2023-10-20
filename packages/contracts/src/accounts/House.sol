// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import {Account} from "tokenbound/Account.sol";

import {HouseTable} from "../tables/House.sol";

contract HouseAccount is Account {
    address public houseTable;

    constructor(address _houseTable, address _guardian, address _entryPoint) Account(_guardian, _entryPoint) {
        houseTable = _houseTable;
    }

    function update() external returns (uint256, uint256) {
        return (0, 0);
    }
}
