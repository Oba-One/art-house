// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {Account} from "@tokenbound/contracts/Account.sol";

contract HouseAccount is Account {
    enum PaletteEnum {
        MARKER,
        CRAYON,
        PENCIL
    }

    function update() external returns (uint256, uint256) {
        return (0, 0);
    }
}
