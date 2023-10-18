// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import { Account } from "tokenbound/contracts/Account.sol";

contract MemberAccount is Account {
    event PrintPurchased(
        address indexed buyer, address art, uint256 indexed tokenId, uint256 indexed orderId, StyleEnum style
    );
    event PalettePurchased(
        address indexed buyer, address art, uint256 indexed tokenId, uint256 indexed orderId, PaletteEnum palette
    );
    
    enum PaletteEnum {
        MARKER,
        CRAYON,
        PENCIL
    }

    struct Order {
        uint8 quantity;
        StyleEnum style;
        address art;
    }

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function makeProposal(Order memory _order) external returns (uint256, uint256) {
      

        return (tokenId, 0);
    }

    function vote(address _art, PaletteEnum _palette) external returns (uint256, uint256) {
        require(_isValidSigner(_msgSender()), "Invalid signer");
        require(!artPalettePurchased[_palette], "Palette already purchased");

        (, address synth,) = _token();

        bool artWhitelisted = Synth(synth).artWhitelist(_art);

        require(artWhitelisted, "Art not whitelisted");

        uint256 tokenId = IERC721GeneralMint(_art).mintOneToOneRecipient(_msgSender());
        // TODO: Send order ro Market Contract

        --purchasesRemaining;
        artPalettePurchased[_palette] = true;

        emit PalettePurchased(_msgSender(), _art, tokenId, 0, _palette);

        return (tokenId, 0);
    }

    function update(address _art, PaletteEnum _palette) external returns (uint256, uint256) {
        return (tokenId, 0);
    }
}
