// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.24;
import "../libraries/Permission.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "../error/GameError.sol";

contract TimeManager is Permission, Pausable {
    uint256 public immutable mint_time;
    uint256 public time_start;
    uint256 public time_end;
    uint256 public time_prepare;
    bool public isStarted = false;
    bool public isEnded = false;
    uint256 public winner;
    constructor() {
        mint_time = block.timestamp;
    }

    function update_prepare_time(uint256 time) external {
        onlyManager();
        time_prepare = time;
        isStarted = true;
    }

    function update_start_time(uint256 time) external {
        onlyManager();
        time_start = time;
    }

    function update_end_time(uint256 time) external {
        onlyManager();
        time_end = time;
    }

    function start_game() external {
        onlyManager();
        if (!paused()) revert GameError.GameStarted();
        _unpause();  
    }

    function pause_game() external {
        onlyManager();
        if (paused()) revert GameError.GameNotStart();
        _pause();
    }

    function isCanBet() internal view returns (bool) {
        return block.timestamp > time_start && !paused();
    }

    function set_winner(uint256 _winner) external {
        onlyManager();
        winner = _winner;
    }

}