// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "../state/StateSoccer.sol";
import "../vaults/VaultSoccer.sol";
import "../services/ServiceSoccer.sol";
import "../types/factories/soccer.sol";

contract FactoryManager is AccessControl, Ownable {
    address public owner;
    address[] private states;
    struct Factory {
        string name;
        address state;
        address vault;
        address service;
    }

    struct StateResponse {
        bool status;
        uint256 index;
    }

    Factory[] private factories;
    constructor() {
        owner = msg.sender;
    }

    event GameCreated(string indexed game_name, address indexed state, address indexed vault, address service);
    event GameVaultCreated(address);
    event GameServiceCreated(address);

    modifier onlyOwner(string memory message) {
        require(msg.sender == owner, string(abi.encodePacked("Only contract owner can", message)));
        _;
    }

    function create_vault(address s) internal returns (address contract_address) {
        VaultSoccer newVaultSoccer = new VaultSoccer(s);
        emit GameVaultCreated(address(newVaultSoccer));
        return address(newVaultSoccer);
    }

    function create_service(address s) internal returns (address contract_address) {
        ServiceSoccer newServiceSoccer = new ServiceSoccer(s);
        emit GameServiceCreated(address(newServiceSoccer));
        return address(newServiceSoccer);
    }

    function create_game(string memory _team_name_1, string memory _team_name_2) external payable onlyOwner("Init") {
        address[3] memory _composer;
        StateSoccer state_contract = new StateSoccer();
        address vault_contract = create_vault(address(state_contract));
        address service_contract = create_service(address(state_contract));
        _composer[0] = vault_contract;
        _composer[1] = service_contract;
        _composer[2] = address(state_contract);
        state_contract.update_composer(_composer);
        state_contract.update_teams(_team_name_1, _team_name_2);
        string memory name_game = string(abi.encodePacked(_team_name_1, "-", _team_name_2));
        factories.push(Factory(name_game, address(state_contract), address(vault_contract), address(service_contract)));
        emit GameCreated(name_game, address(state_contract), address(vault_contract), address(service_contract));
    }

    function get_states_address_by_name(string memory _name) external view returns (StateResponse memory) {
        for (uint256 i = 0; i < factories.length; i++) {
            if (keccak256(abi.encodePacked(factories[i].name)) == keccak256(abi.encodePacked(_name))) {
                return StateResponse(true, i); // Return the index of the product if found
            }
        }
        return StateResponse(false, 0); // Return max uint256 if product not found
    }

    function get_all_states() external view returns (Factory[] memory) {
        return factories;
    }

    function get_states_address_by_index(uint256 idx) external view returns (Factory memory) {
        return factories[idx];
    }
}
