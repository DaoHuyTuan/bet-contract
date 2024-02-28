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

    function place_bet(string _team, value) external payable {
        StateSoccer state_contract = StateSoccer(state_address_contract);
        state_contract.
    }

    function withdraw() external {}
}
    