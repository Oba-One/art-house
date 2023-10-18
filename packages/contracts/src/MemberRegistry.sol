pragma solidity ^0.8.21;

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { ERC721Burnable } from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract MemberRegistry is ERC721, ERC721Burnable, Ownable {
    uint256 private _nextTokenId;

    constructor(address initialOwner)
        ERC721("Member", "MBR")
        Ownable()
    {}

    function mintMember(address to) public {
        uint256 tokenId = _nextTokenId++;
        _mint(to, tokenId);
    }

    function burnMember(uint256 tokenId) public {
        _burn(tokenId);
    }
}