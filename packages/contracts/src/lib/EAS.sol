// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import {IEAS, AttestationRequest, RevocationRequest} from "eas-contracts/IEAS.sol";

import {EAS_OP, EAS_POLYGON_MUMBAI, EAS_SCROLL_SEPOLIA} from "../Constants.sol";

error InvalidChainId();

library EASLib {
    function attest(AttestationRequest memory attestation) external {
        if (block.chainid == 420) {
            IEAS(EAS_OP).attest(attestation);
        } else if (block.chainid == 80001) {
            IEAS(EAS_POLYGON_MUMBAI).attest(attestation);
        } else if (block.chainid == 534351) {
            IEAS(EAS_SCROLL_SEPOLIA).attest(attestation);
        } else {
            revert InvalidChainId();
        }
    }

    function revoke(RevocationRequest memory revocation) external {
        if (block.chainid == 420) {
            IEAS(EAS_OP).revoke(revocation);
        } else if (block.chainid == 80001) {
            IEAS(EAS_POLYGON_MUMBAI).revoke(revocation);
        } else if (block.chainid == 534351) {
            IEAS(EAS_SCROLL_SEPOLIA).revoke(revocation);
        } else {
            revert InvalidChainId();
        }
    }
}
