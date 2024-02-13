// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;
import "../Utils.sol";

contract PoolSoccer {
    uint256 private pool_id;
    constructor() {
        pool_id = Utils.generate_unique_id("pool");
    }

    function get_id() external view returns (uint256) {
        return pool_id;
    }

    function deposit() external {}

    function withdraw() external {}
}
