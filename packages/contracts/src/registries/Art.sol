// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import {Ownable} from "openzeppelin-contracts/access/Ownable.sol";
import {ERC721} from "openzeppelin-contracts/token/ERC721/ERC721.sol";

import {NFCRegistry} from "./NFC.sol";
import {TBALib} from "../lib/TBA.sol";
import {ArtTable} from "../tables/Art.sol";
import {HouseAccount} from "../account/House.sol";

error NotHouse();
error NotHouseOwner();
error NotArtOwner();
error NFCNotRegistered();

contract ArtRegistry is ERC721, Ownable {
    uint256 private _nextTokenId;
    address private _artTable;
    address private _artAccountImplementation;
    address private _nfcRegistry;
    address private _goodTransferResolver;

    constructor(
        address artTable,
        address artAccountImplementation,
        address nfcRegistry,
        address goodTransferResolver,
        string memory _name
    ) ERC721(_name, "ART") {
        _artTable = artTable;
        _artAccountImplementation = artAccountImplementation;
        _goodTransferResolver = goodTransferResolver;
        _nfcRegistry = nfcRegistry;
    }

    function registerArt(
        address house,
        string memory nfcId,
        string memory name,
        string memory description,
        string memory image,
        uint style
    ) external {
        if (HouseAccount(house).owner() != msg.sender) {
            revert NotHouseOwner();
        }

        if (NFCRegistry(_nfcRegistry).nfcIdToIssuer(nfcId) == address(0)) {
            revert NFCNotRegistered();
        }

        uint256 tokenId = _nextTokenId++;
        _safeMint(house, tokenId);

        address artAccount = TBALib.createAccount(_artAccountImplementation, address(this), tokenId);

        ArtAccount(artAccount).initialize(nfcId);

        ArtTable(_artTable).insert(artAccount, house, nfcId, name, description, image, style);
    }

    function transferArt(address oldHouse, address newHouse, uint256 tokenId) public {
        require(HouseAccount(oldHouse), NotHouse());
        require(HouseAccount(newHouse), NotHouse());

        if (msg.sender != _goodTransferResolver) {
            revert NotAuthorized();
        }

        transferFrom(oldHouse, newHouse, tokenId);
    }
}
