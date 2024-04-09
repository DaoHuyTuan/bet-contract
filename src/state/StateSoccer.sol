// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;
import "../types/factories/soccer.sol";

contract StateSoccer is IStateSoccer{
  string private team1;
  string private team2;
  address[] private composes;
  struct Vault {
    string team_name;
    uint256 value;
  }
  mapping(address => Vault) public vault;

  function update_composer(address[3] memory _composer) external payable {
    composes = _composer;
  }

  function update_teams(string memory _team1, string memory _team2) external payable {
    team1 = _team1;
    team2 = _team2;
  }

  function get_names() public view returns (string memory, string memory) {
    return (team1, team2);
  }

  function update_vault(address sender, string memory team, uint256 amount) external payable {
    if (vault[sender].value == 0) {
      vault[sender] = Vault(team, amount);
    } else {
      uint256 new_amount = vault[sender].value + amount;
      vault[sender].team_name = team;
      vault[sender].value = new_amount;
    }
  }

  function switch_team(address sender, string memory team) external payable {
    vault[sender].team_name = team;
  }

  function find_my_bet() external view returns (Vault memory) {
    return vault[msg.sender];
  }

  function get_compose() public view returns (address[] memory) {
    return composes;
  }

  function am_i_on_here() external view returns (bool) {
    if (vault[msg.sender].value != 0) {
      return true;
    } else {
      return false;
    }
  }

  function update_rate() external {

  }
}