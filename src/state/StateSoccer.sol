// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;
import "../types/factories/soccer.sol";

contract StateSoccer is IStateSoccer{
  string private team1;
  string private team2;
  address[] private composes;

  function update_composer(address[3] memory _composer) public payable  {
    composes = _composer;
  }

  function update_teams(string memory _team1, string memory _team2) external payable {
    team1 = _team1;
    team2 = _team2;
  }

  function get_names() public view returns (string memory, string memory) {
    return (team1, team2);
  }

  function get_compose() public view returns (address[] memory) {
    return composes;
  }
}