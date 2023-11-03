// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import {AccountV3} from "tokenbound/AccountV3.sol";
import {Initializable} from "openzeppelin-contracts/proxy/utils/Initializable.sol";

import {EASLib} from "../lib/EAS.sol";
import {HouseTable} from "../tables/House.sol";
import {NFCRegistry} from "../registries/NFC.sol";

error NotArtOwner();
error TransferNotStarted();
error NotGoodTransferResolver();

contract ArtAccount is AccountV3, Initializable {
    enum TransferStatus {
        None,
        Started,
        Approved
    }

    string public nfcId;
    address private _artTable;
    address private _nfcRegistry;
    address private _artRegistry;
    address private _goodTransferResolver;

    address private _buyer;
    string public transferStartedAt;
    TransferStatus public transferStatus;

    constructor(
        address artTable,
        address goodTransferResolver,
        address erc4337EntryPoint,
        address multicallForwarder,
        address erc6551Registry,
        address guardian
    ) AccountV3(erc4337EntryPoint, multicallForwarder, erc6551Registry, guardian) {
        _artTable = artTable;
        _goodTransferResolver = goodTransferResolver;
    }

    function initialize(string memory _nfcId) external initializer {
        nfcId = _nfcId;
    }

    function startTransfer(address buyer) external {
        if (msg.sender != _goodTransferResolver) {
            revert NotGoodTransferResolver();
        }

        transferStatus = TransferStatus.Started;
        transferStartedAt = block.timestamp;
        _buyer = buyer;
    }

    function approveTransfer() external {
        if (_isValidSigner(msg.sender) == false) {
            revert NotArtOwner();
        }

        if (transferStatus != TransferStatus.Started) {
            revert TransferNotStarted();
        }

        transferStatus = TransferStatus.Approved;
    }

    function completeTransfer() external {
        if (msg.sender != _goodTransferResolver) {
            revert NotGoodTransferResolver();
        }

        if (transferStatus != TransferStatus.Approved) {
            revert TransferNotStarted();
        }


        transferStatus = TransferStatus.None;
        transferStartedAt = "";
        _buyer = address(0);

    }

    function cancelTransfer() external {
        if (_isValidSigner(msg.sender) == false) {
            revert NotArtOwner();
        }

        if (transferStatus != TransferStatus.Started) {
            revert TransferNotStarted();
        }
    }

    function updateName(string memory name) external returns () {
        if (_isValidSigner(msg.sender) == false) {
            revert NotArtOwner();
        }

        ArtTable(_houseTable).updateName(name);
    }

    function updateDescription(string memory description) external returns () {
        if (_isValidSigner(msg.sender) == false) {
            revert NotArtOwner();
        }

        ArtTable(_houseTable).updateDescription(description);
    }

    function updateStyle(uint style) external returns () {
        if (_isValidSigner(msg.sender) == false) {
            revert NotArtOwner();
        }

        ArtTable(_houseTable).updateStyle(style);
    }

    function updateImage(string memory image) external returns () {
        if (_isValidSigner(msg.sender) == false) {
            revert NotArtOwner();
        }

        ArtTable(_houseTable).updateImage(image);
    }
}
