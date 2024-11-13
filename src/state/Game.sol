// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.24;
import "../interfaces/Rate.sol";
import "../interfaces/Game.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import "../interfaces/Event.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "./TimeManager.sol";
import "./RoleManager.sol";
import "../libraries/Permission.sol";


contract Game is IGame, Permission, TimeManager, Pausable, ReentrancyGuard, IEvents {
  using SafeERC20 for IERC20;
  using Address for address;
  address immutable game_id;
  struct Vault {
    string team_name;
    uint256 value;
  }

  string public name;
  string public info;
  mapping(address => Vault) public vault;

  // constructor(string _team_1_name, string _team_2_name, uint256 _team_1_rate, uint256 _team_2_rate)
  constructor(IGame.GameInfo memory _game_info, IGame.GameMetaData memory meta_data) TimeManager() {
    if (bytes(meta_data.name).length > 0) {
      name = meta_data.name;
      info = _game_info.team_1_name;
    }
    game_id = address(this);
  }

  function bet(string memory side) external payable nonReentrant {
    require(msg.value > 0, "Amount must more than 0 ether");  
    Vault memory user = vault[msg.sender];
    if (user.value > 0) {
      user.value += msg.value;
      emit UpdateBet(msg.sender, msg.value);
    } else {
      vault[msg.sender] = Vault({
        value: msg.value,
        team_name: side
      });
      emit Bet(side, msg.sender, msg.value);
    }
  }

  function withdraw() external payable nonReentrant  {
    // onlyParticipant();
  }
  function claim() external payable nonReentrant {
    // onlyParticipant();
  }
  function switch_side() external payable nonReentrant {
    // onlyParticipant();
  }
}