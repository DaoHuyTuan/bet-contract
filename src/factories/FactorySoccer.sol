// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "../state/StateSoccer.sol";
import "../pools/PoolSoccer.sol";
import "../services/ServiceSoccer.sol";

contract FactorySoccer {
    address public owner;
    address[] private states;
    address[] private pools;
    address[] private services;
    constructor() {
        owner = msg.sender;
    }

    event GameCreated(address indexed pl, address indexed sv, address indexed st);

    modifier onlyOwner(string memory message) {
        require(msg.sender == owner, string(abi.encodePacked("Only contract owner can", message)));
        _;
    }

    function init(string memory _team_name_1, string memory _team_name_2) external payable onlyOwner("Init") {
        PoolSoccer newPoolSoccer = new PoolSoccer();
        pools.push(address(newPoolSoccer));
        ServiceSoccer newServiceSoccer = new ServiceSoccer();
        services.push(address(newServiceSoccer));
        address[] memory composer = new address[](2); 
        composer[0] = address(newPoolSoccer);
        composer[1] = address(newServiceSoccer);
        StateSoccer newStateSoccer = new StateSoccer(_team_name_1, _team_name_2, composer);
        states.push(address(newStateSoccer));
        emit GameCreated(address(newPoolSoccer), address(newServiceSoccer), address(newStateSoccer));
    }

    function create_fool() external payable onlyOwner("Create Pool contract") {}

    function create_state() external payable onlyOwner("Create State contract") {} 

    function create_store() external payable onlyOwner("Create store contract") {} 

    function get_states_address() external view returns (address[] memory) {
        return states;
    }
}
