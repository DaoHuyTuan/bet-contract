// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "../state/StateSoccer.sol";
import "../pools/PoolSoccer.sol";
import "../services/ServiceSoccer.sol";
import "../types/factories/soccer.sol";

contract FactorySoccer {
    address public owner;
    address[] private states;
    address[] private pools;
    address[] private services;
    address[3] private composer;
    constructor() {
        owner = msg.sender;
    }

    event GameCreated(address indexed pl, address indexed sv, address indexed st);

    modifier onlyOwner(string memory message) {
        require(msg.sender == owner, string(abi.encodePacked("Only contract owner can", message)));
        _;
    }

    function create_fool() external payable returns (address contract_address) {
        PoolSoccer newPoolSoccer = new PoolSoccer();
        return address(newPoolSoccer);
    }

    function create_service() external payable returns (address contract_address) {
        ServiceSoccer newServiceSoccer = new ServiceSoccer();
        return address(newServiceSoccer);
    }

    function init(string memory _team_name_1, string memory _team_name_2) external payable onlyOwner("Init") {
        address[3] memory _composer;
        address pool_contract = this.create_fool();
        address service_contract = this.create_service();
        StateSoccer state_contract = new StateSoccer();
        _composer[0] = pool_contract;
        _composer[1] = service_contract;
        _composer[2] = address(state_contract);
        state_contract.update_composer(_composer);
        state_contract.update_teams(_team_name_1, _team_name_2);
        states.push(address(state_contract));
    }

    function get_states_address() external view returns (address[] memory) {
        return states;
    }
}
