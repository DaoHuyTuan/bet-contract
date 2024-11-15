// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;
interface IEvents {
    event Bet(uint256 indexed team_side, address indexed sender, uint256 amount);
    event UpdateBet(address indexed sender, uint256 amount);
    event Withdraw();
    // event SwitchSide();
    // event Claim();
}