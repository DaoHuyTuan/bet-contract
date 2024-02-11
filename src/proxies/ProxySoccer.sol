// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ProxySoccer {
    address public owner;
    string public game_status; // prepare, playing, settle
    uint256 public rate;
    string public winner;
    mapping(address => uint256) public team1;
    mapping(address => uint256) public team2;
    mapping(address => uint8) public bets;
    
    event Bet_Placed(address indexed bettor, uint amount);
    event Bet_Cancelled(address indexed bettor, uint amount);
    event Rate_Updated(uint newRate);
    event Status_Updated(string newStatus);
    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can perform this action");
        _;
    }

    function cancel_bet() public {}

    function place_bet(uint8 team_chose) external payable {
        require(msg.value > 0, "Bet amount must be greater than 0");
        bets[msg.sender] = team_chose;
        if (team_chose == 1) {
            team1[msg.sender] = msg.value;
        } else {
            team2[msg.sender] = msg.value;
        }

        emit Bet_Placed(msg.sender, msg.value);
        // update_rate();
    }

    function update_rate() private {}

    function get_rate() external view returns (uint256){
        return rate;
    }
    function windraw() public {}


    // game status
    function update_status(string memory status) external payable onlyOwner {
        game_status = status;
        emit Status_Updated(status);
    }

    function get_status() external view returns (string memory) {
        return game_status;
    }

    function get_bet_by_address() external view returns (uint8) {
        return bets[msg.sender];
    }
}
