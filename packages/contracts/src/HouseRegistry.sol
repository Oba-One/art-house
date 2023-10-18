// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { ERC721Burnable } from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract HouseResgistry is ERC721, ERC721Burnable, Ownable {
    uint256 private _nextTokenId;

    constructor(address initialOwner)
        ERC721("House", "HOUSE")
        Ownable()
    {}

    function mintHouse(address to) public {
        uint256 tokenId = _nextTokenId++;
        _mint(to, tokenId);
    }

    function transferHouse(address to, uint256 tokenId) public {
        transferFrom(msg.sender, to, tokenId);
    }

    function burnHouse(uint256 tokenId) public {
        _burn(tokenId);
    }
}