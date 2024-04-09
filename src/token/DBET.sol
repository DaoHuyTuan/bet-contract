// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract DeBetToken is ERC20 {
    constructor() ERC20("DeBetToken", "DBET") {
        uint256 totalSupply = 21_000_000 * (10 ** uint256(decimals()));
        _mint(msg.sender, totalSupply);
    }
}