// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;
import "../types/factories/soccer.sol";

contract StateSoccer is IStateSoccer{
  string private team1;
  string private team2;
  address[] private composes;
  mapping(address => uint256) public vault_team1;
  mapping(address => uint256) public vault_team2;


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

  function update_vault(string memory team, uint256 value) external payable {
    if (keccak256(abi.encodePacked(team)) == keccak256(abi.encodePacked(team1))) {
      vault_team1[msg.sender] = value;
    }
    if (keccak256(abi.encodePacked(team)) == keccak256(abi.encodePacked(team2))) {
      vault_team2[msg.sender] = value;
    }
  }

  function get_compose() public view returns (address[] memory) {
    return composes;
  }
}