//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract CreatorRegistry {
    struct Creator {
        string name;
        uint256 verifiedIdentity;
        string academicHistory;
    }

    mapping(address => Creator) public creators;

    event CreatorRegistered(address indexed creatorAddress, string name);

    function registerCreator(string memory _name, uint256 _verifiedIdentity, string memory _academicHistory) public {
        require(creators[msg.sender].verifiedIdentity == 0, "Creator already registered");

        creators[msg.sender] = Creator(_name, _verifiedIdentity, _academicHistory);
        emit CreatorRegistered(msg.sender, _name);
    }
}

