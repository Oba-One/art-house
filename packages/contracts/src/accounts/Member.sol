// SPDX-License-Identifier: MIT
pragma solidity >=0.8.21;

import {Account} from "tokenbound/Account.sol";

contract MemberAccount is Account {
    enum Vote {
        Yay,
        Nay,
        Abstain
    }

    constructor(address _guardian, address _entryPoint) Account(_guardian, _entryPoint) {}

    function makeProposal(string memory _name, string memory _description) external returns (uint256, uint256) {
        return (0, 0);
    }

    function proposalVote(uint256 _proposalId, Vote _vote) external returns (uint256, uint256) {
        return (0, 0);
    }

    function createHouse() external returns (uint256, uint256) {
        return (0, 0);
    }

    function resgisterArt() external returns (uint256, uint256) {
        return (0, 0);
    }

    function update() external returns (uint256, uint256) {
        return (0, 0);
    }
}
