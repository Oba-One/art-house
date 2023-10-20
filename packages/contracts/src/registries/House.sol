// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import {ERC721} from "openzeppelin-contracts/token/ERC721/ERC721.sol";
import {ERC721Burnable} from "openzeppelin-contracts/token/ERC721/extensions/ERC721Burnable.sol";
import {Ownable} from "openzeppelin-contracts/access/Ownable.sol";

import {TBALib} from "../lib/TBA.sol";
import {HouseTable} from "../tables/House.sol";

contract HouseRegistry is ERC721, ERC721Burnable, Ownable {
    uint256 private _nextTokenId;
    address private _houseTable;
    address private _houseAccountImplementation;

    constructor(address houseTable, address houseAccountImplementation, string memory _name) ERC721(_name, "HOUSE") {
        _houseTable = houseTable;
        _houseAccountImplementation = houseAccountImplementation;
    }

    function createHouse(address to) public {
        uint256 tokenId = _nextTokenId++;
        _mint(to, tokenId);
    }

    function destroyHouse(uint256 tokenId) public {
        _burn(tokenId);
    }
}
