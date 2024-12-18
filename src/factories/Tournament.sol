// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;
import "@openzeppelin/contracts/access/Ownable.sol";
import "../state/Game.sol";
import "../libraries/Permission.sol";

// import "../vaults/VaultSoccer.sol";
// import "../services/ServiceSoccer.sol";

import "../interfaces/Rate.sol";
import "../interfaces/Game.sol";

interface ITournamentContract {
    function init(string calldata _name, uint256 _genre, uint256 _category) external;
}

contract Tournament is Permission {
    address[] private states;
    string public tournament_name;
    address private tax_contract;
    uint256 public genre;
    uint256 public category;
    // address public tax_contract;
    struct Factory {
        string name;
        address state;
    }

    struct StateResponse {
        bool status;
        uint256 index;
    }

    Factory[] private factories;
    // constructor() Ownable(msg.sender) {}
    function init(string calldata _name, uint256 _genre, uint256 _category, address first_admin, address _tax_contract) external {
        tournament_name = _name;
        genre = _genre;
        category = _category;   
        tax_contract = _tax_contract;
        _grantRole(ADMIN_ROLE, first_admin);
    }

    event GameCreated(string indexed game_name, address indexed state);
    event GameVaultCreated(address);
    event GameServiceCreated(address);

    function create_game(string memory _team_name_1, string memory _team_name_2, uint256 _team_rate_1, uint256 _team_rate_2, string memory name, address _tax_contract) external {
        onlyManager();
        IGame.GameMetaData memory meta_data;
        if (bytes(name).length > 0) {
            meta_data.name = name;
        }
        Game state_contract = new Game(_team_name_1, _team_name_2,_team_rate_1, _team_rate_2, name, _tax_contract, msg.sender);
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
