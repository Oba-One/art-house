// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { ERC721Burnable } from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract ArtRegistry is ERC721, ERC721Burnable, Ownable {
    uint256 private _nextTokenId;

    constructor(address initialOwner)
        ERC721("Art", "ART ")
        Ownable()
    {}

    function mintArt(address house, string memory nfcId, string memory metadata) public onlyOwner {
        uint256 tokenId = _nextTokenId++;
        _safeMint(house, tokenId);
    }

    function burnArt(uint256 tokenId) public onlyOwner {
        _burn(tokenId);
    }
}