// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;
import "../interfaces/Rate.sol";

interface IGame {

    enum BetType {
        NORMAL,
        HANDICAP
    }

    enum GameType {
        SPORT,
        ESPORT
    }

    enum GameCategory {
        DOTA2,
        CSGO,
        LOL,
        VALORANT,
        DEADLOCK
    }

    struct GameInfo {
        string team_1_name;
        string team_2_name;
        IRate.Rate base_rate;
    }
    struct GameMetaData {
        string name; // bet-type_type_team1-name_team2-name_
        BetType bet_type;
        GameType types;
        GameCategory category;
    }
    // Function
    function bet(string memory side) external payable;
    function withdraw() external payable;
    function claim() external payable;
}

