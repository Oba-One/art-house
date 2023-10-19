// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import {ERC721} from "openzeppelin-contracts/token/ERC721/ERC721.sol";
import {ERC721Burnable} from "openzeppelin-contracts/token/ERC721/extensions/ERC721Burnable.sol";
import {Ownable} from "openzeppelin-contracts/access/Ownable.sol";

// error NotAuthorized();
// error InvalidInput();
// error AccountLocked();
// error ExceedsMaxLockTime();
// error UntrustedImplementation();
// error OwnershipCycle();

contract ArtRegistry is ERC721, ERC721Burnable, Ownable {
    uint256 private _nextTokenId;

    constructor(address _initialOwner, string memory _name) ERC721(_name, "ART") {
        transferOwnership(_initialOwner);
    }

    function mintArt(address house, string memory nfcId, string memory metadata) external {
        if (block.chainid == 420) {
            // TODO: make attestations for each chain
        } else if (block.chainid == 80001) {
            // TODO: make attestations for each chain
        } else if (block.chainid == 534351) {
            // TODO: make attestations for each chain
        } else {
            revert("Invalid chain id");
        }

        uint256 tokenId = _nextTokenId++;
        _safeMint(house, tokenId);
    }

    function burnArt(uint256 tokenId) external {
        _burn(tokenId);
    }
}