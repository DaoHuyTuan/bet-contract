// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;
import "@openzeppelin/contracts/access/Ownable.sol";


contract TaxManager is Ownable {
    // Immutable values
    uint256 public constant TAX_BASIS_POINTS = 20; // 0.2% = 20 basis points
    uint256 public constant BASIS_POINTS = 10000;   // 100% = 10000 basis points
    
    constructor() Ownable(msg.sender) {
    }

    function calculateFee() external {

    }

    function payTax() external payable {}
}