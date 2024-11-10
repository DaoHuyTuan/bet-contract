// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/Roles.sol";
import "../state/Game.sol";
// import "../vaults/VaultSoccer.sol";
// import "../services/ServiceSoccer.sol";

import "../interfaces/Rate.sol";
import "../interfaces/Game.sol";
contract Tournament is AccessControl, Ownable {
    bytes32 public constant OWNER_ROLE = keccak256("OWNER_ROLE");
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    address[] private states;
    string public tournament_name;
    uint256 public immutable genre;
    uint256 public immutable category;
    struct Factory {
        string name;
        address state;
    }

    struct StateResponse {
        bool status;
        uint256 index;
    }

    Factory[] private factories;
    constructor(uint256 _genre, uint256 _category) Ownable(msg.sender) {
        // tournament_name = _name;
        genre = _genre;
        category = _category;
    }

    event GameCreated(string indexed game_name, address indexed state);
    event GameVaultCreated(address);
    event GameServiceCreated(address);

    function create_game(string memory _team_name_1, string memory _team_name_2, uint256 _team_rate_1, uint256 _team_rate_2, string memory name) external payable onlyOwner {
        IRate.Rate memory base_rate = IRate.Rate({
            team_1_rate: _team_rate_1,
            team_2_rate: _team_rate_2
        });
        IGame.GameInfo memory game_info = IGame.GameInfo({
            team_1_name: _team_name_1,
            team_2_name: _team_name_2,
            base_rate: base_rate
        });
        IGame.GameMetaData memory meta_data;
        if (bytes(name).length > 0) {
            meta_data.name = name;
        }
        Game state_contract = new Game(game_info, meta_data);
        // address vault_contract = create_vault(address(state_contract));
        // address service_contract = create_service(address(state_contract));
        // string memory name_game = string(abi.encodePacked(_team_name_1, "-", _team_name_2));
        factories.push(Factory(name, address(state_contract)));
        emit GameCreated(name, address(state_contract));
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
