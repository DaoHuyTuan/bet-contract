// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract StateSoccer {
  string private team1;
  string private team2;
  address[] private composes;
  
  constructor(string memory _team1, string memory _team2, address[] memory _composes) {
    team1 = _team1;
    team2 = _team2;
    composes = _composes;
  }

  function get_names() public view returns (string memory, string memory) {
    return (team1, team2);
  }

  function get_compose() public view returns (address[] memory) {
    return composes;
  }
}