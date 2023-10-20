// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import {IEAS, Attestation} from "eas-contracts/IEAS.sol";
import {SchemaResolver} from "eas-contracts/resolver/SchemaResolver.sol";
import {Ownable} from "openzeppelin-contracts/access/Ownable.sol";

import {GoodTransferSchema} from "../Constants.sol";

/// @title GoodTransferResolver
/// @notice A schema resolver for the GoodTransfer event schema
contract GoodTransferResolver is SchemaResolver, Ownable {
    constructor(address easAddrs) SchemaResolver(IEAS(easAddrs)) {}

    function onAttest(Attestation calldata attestation, uint256 /*value*/ ) internal override returns (bool) {
        // require(attesters[attestation.attester], "GoodTransferCompleteResolver: not valid attester");

        GoodTransferSchema memory schema = abi.decode(attestation.data, (GoodTransferSchema));

        return true;
    }

    function onRevoke(Attestation calldata attestation, uint256 /*value*/ ) internal override returns (bool) {
        // require(attesters[attestation.attester], "GoodTransferCompleteResolver: not valid attester");

        return true;
    }
}
