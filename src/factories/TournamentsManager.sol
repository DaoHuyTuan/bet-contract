// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;
import "./Tournament.sol";
// import "../tax/TaxManager.sol";

contract TournamentsManager is Ownable {

    struct ITournament {
        string name;
        uint256 genre;
        uint256 category;
        address tournament_address;
    }

    // address private tax_address;

    // STournament[] public tournaments;
    mapping(uint256 => ITournament) tournaments;
    uint256 public total = 0;
    event TournamentCreated(string indexed tournament_name, address indexed tournament_address, uint256 genre, uint256 category);

    constructor() Ownable(msg.sender) {
        // TaxManager new_tax_contract = new TaxManager(msg.sender);
        // tax_address = address(tax_contract);
    }

    function create_tournament(string memory name, uint256 genre, uint256 category) external onlyOwner {
        Tournament new_tournament = new Tournament(name, genre, category);
        tournaments[total] = ITournament(name, genre, category, address(new_tournament));
        total += 1;
        emit TournamentCreated(name, address(new_tournament), genre, category);
    }

    function get_tournament(uint256 index) external view returns (ITournament memory) {
        return tournaments[index];
    }

}