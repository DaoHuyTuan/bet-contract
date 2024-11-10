// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.24;

contract TimeManager {
    uint256 public immutable mint_time;
    uint256 public time_start;
    uint256 public time_end;
    constructor() {
        mint_time = block.timestamp;
    }

    // modifier validStartTime(uint256 time) {
    //     require(time > time_start, "New start time can't not older current start time");
    //     _;
    // }

    // modifier validEndTime(uint256 time) {
    //     require(time > time_end, "New end time can't not older current end time");
    //     _;
    // }

    // function update_start_time(uint256 time) external validStartTime(time) {
    //     time_start = time;
    // }

    // function update_end_time(uint256 time) external validEndTime(time) {
    //     time_end = time;
    // }
    function update_start_time(uint256 time) external {
        time_start = time;
    }

    function update_end_time(uint256 time) external {
        time_end = time;
    }
}