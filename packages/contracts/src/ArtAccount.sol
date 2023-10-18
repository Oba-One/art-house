// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import { Account } from "tokenbound/contracts/Account.sol";

contract ArtAccount is Account {

    string nfcID;
    
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

    function initialize(string memory _nfcID, address _organizer) external initializer {
        nfcID = _nfcID;
    }

    function startTransfer(Order memory _order) external returns (uint256, uint256) {
      

        return (tokenId, 0);
    }

    function approveTransfer(address _art, PaletteEnum _palette) external returns (uint256, uint256) {
        return (tokenId, 0);
    }

    function completeTransfer(address _art, PaletteEnum _palette) external returns (uint256, uint256) {
    }

    function moveHouse(address _art, PaletteEnum _palette) external returns (uint256, uint256) {
        return (tokenId, 0);
    }

    function update(address _art, PaletteEnum _palette) external returns (uint256, uint256) {
        return (tokenId, 0);
    }

}
