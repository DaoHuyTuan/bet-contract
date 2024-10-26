// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;
import "../interfaces/Rate.sol";

interface IGame {
    struct GameInfo {
        string team_1_name;
        string team_2_name;
        IRate.Rate base_rate;
    }
    struct GameMetaData {
        string name;
    }
    // Function
    function bet(string memory side) external payable;
    function withdraw() external payable;
    function claim() external payable;
}

