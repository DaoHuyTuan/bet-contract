// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.24;
import "../interfaces/Rate.sol";
import "../interfaces/Game.sol";
// import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "../interfaces/Event.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "./TimeManager.sol";
import "./RoleManager.sol";
import "../libraries/Permission.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "../tax/TaxManager.sol";

contract Game is TimeManager, IGame, ReentrancyGuard, IEvents {
  using SafeMath for uint256;
  
  using Address for address;
  address immutable game_id;
  struct Vault {
    uint256 team_side;
    uint256 value;
  }
  ITaxManager public tax_contract;
  uint256 public total1 = 0;
  uint256 public total2 = 0;
  string public game_name;
  string public team_1_name;
  string public team_2_name;
  uint256 public team_1_rate;
  uint256 public team_2_rate;
  uint256 public constant PRECISION = 1e18;
  string public info;
  mapping(address => Vault) public vault;
  uint256 public rate;
  constructor(string memory _team_1_name, string memory _team_2_name, uint256 _team_1_rate, uint256 _team_2_rate, string memory _game_name, address  _tax_contract) {
    game_name = _game_name;
    team_1_name = _team_1_name;
    team_2_name = _team_2_name;
    team_1_rate = _team_1_rate;
    team_2_rate = _team_2_rate;
    tax_contract = ITaxManager(_tax_contract);
    game_id = address(this);
  }

  function update_rate() internal nonReentrant {
    rate = total1.mul(PRECISION).div(total2);
  }

  function bet(uint256 side) external payable nonReentrant {
    if (!isCanBet()) revert GameError.GameNotStart();
    tax_contract = ITaxManager(tax_contract);
    tax_contract.pay_tax(msg.value);
    require(msg.value != 0, "Amount must more than 0 ether");  
    require(side == 0 || side == 1, "Side only 0 and 1") ;
    Vault storage user = vault[msg.sender];
    if (user.value > 0) {
      user.value += msg.value;
      emit UpdateBet(msg.sender, msg.value);
    } else {
      vault[msg.sender] = Vault({
        value: msg.value,
        team_side: side
      });
      emit Bet(side, msg.sender, msg.value);
    }
    if (side == 0) {
      total1 += msg.value;
    } else {
      total2 += msg.value;
    }
    update_rate();
  }

  

  function withdraw() external payable nonReentrant  {
    if (!isCanBet()) revert GameError.GameNotStart();
    onlyParticipant();

  }
  function claim() external payable nonReentrant {
    onlyParticipant();
  }
  function switch_side() external payable nonReentrant {
    onlyParticipant();
  }
}