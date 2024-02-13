// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract StateSoccer {
  string public team1;
  string public team2;
  
  constructor(string memory _team1, string memory _team2) {
    team1 = _team1;
    team2 = _team2;
  }

  function get_names() public view returns (string memory, string memory) {
    return (team1, team2);
  }
}