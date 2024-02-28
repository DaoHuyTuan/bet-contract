// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;
import "../Utils.sol";
import "../state/StateSoccer.sol";

contract PoolSoccer {
    address state_address_contract;
    constructor(address _state_contract) {
        state_address_contract = _state_contract;
    }

    event Deposit(address indexed sender, uint256 amount);

    function place_bet(string memory _team) public payable {
        StateSoccer state_contract = StateSoccer(state_address_contract);
        state_contract.update_vault(msg.sender, _team, msg.value);
    }

    function switch_side(string memory _team) external payable {
        StateSoccer state_contract = StateSoccer(state_address_contract);
        state_contract.switch_team(msg.sender, _team);
    }

    function get_vault() public view returns (uint256) { 
        return address(this).balance;
    }

    function withdraw() external payable  {}

    function claim() external payable {}
}
    