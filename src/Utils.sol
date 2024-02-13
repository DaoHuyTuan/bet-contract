// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

library Utils {
    function generate_unique_id(string memory type_contract) internal view returns (uint256) {
        bytes32 hash = keccak256(abi.encodePacked(block.timestamp, block.number, msg.sender, address(this), type_contract));
        uint256 id = uint256(hash);
        return id;
    }
}