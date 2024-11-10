// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Tournament.sol";

contract TournamentsManager is Ownable {

    struct STournament {
        string name;
        address tournament_address;
    }


    STournament[] private tournaments;

    event TournamentCreated(string indexed tournament_name, address indexed tournament_address);

    constructor() Ownable(msg.sender) {

    }

    function create_tournament(string memory name, uint256 genre, uint256 category) external payable {
        Tournament new_tournament = new Tournament(name, genre, category);
        tournaments.push(STournament(name, address(new_tournament)));
        emit TournamentCreated(name, address(new_tournament));
    }

}