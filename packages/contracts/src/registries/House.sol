// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import {ERC721} from "openzeppelin-contracts/token/ERC721/ERC721.sol";
import {ERC721Burnable} from "openzeppelin-contracts/token/ERC721/extensions/ERC721Burnable.sol";
import {Ownable} from "openzeppelin-contracts/access/Ownable.sol";

import {TBALib} from "../lib/TBA.sol";
import {HouseTable} from "../tables/House.sol";

error NotHouseOwner();

contract HouseRegistry is ERC721, ERC721Burnable, Ownable {
    uint256 private _nextTokenId;
    address private _houseTable;
    address private _houseAccountImplementation;

    constructor(address houseTable, address houseAccountImplementation, string memory _name) ERC721(_name, "HOUSE") {
        _houseTable = houseTable;
        _houseAccountImplementation = houseAccountImplementation;
    }

    function createHouse(string memory name, string memory description, uint style) public {
        require(MemberAccount(msg.sender), NotMember());

        uint256 tokenId = _nextTokenId++;
        _mint(msg.sender, tokenId);

        address houseAccount = TBALib.createAccount(_houseAccountImplementation, address(this), tokenId);

        HouseTable(_houseTable).insert(houseAccount, name, description, style);
    }

    function destroyHouse(uint256 tokenId) public {
        require(MemberAccount(msg.sender), NotMember());

        if (ownerOf(tokenId) != msg.sender) {
            revert NotHouseOwner();
        }

        address houseAccount = TBALib.getAccount(_houseAccountImplementation, address(this), tokenId);

        HouseTable(_houseTable).deleteRow(houseAccount);

        _burn(tokenId);
    }
}
