// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

interface ITaxManager {
    function pay_tax(uint256 amount) external payable;
}

contract TaxManager is Ownable {
    using SafeMath for uint256;
    // Immutable values
    uint256 public constant TAX_BASIS_POINTS = 20; // 0.2% = 20 basis points
    uint256 public constant BASIS_POINTS = 10000;   // 100% = 10000 basis points
    
    constructor(address _owner) Ownable(_owner) {
    }

    function calculateFee(uint256 amount) pure internal returns (uint256) {
        return amount.mul(TAX_BASIS_POINTS).div(BASIS_POINTS);
    }

    function pay_tax(uint256 amount) external payable {
        uint256 tax = calculateFee(amount);
        require(msg.value >= tax, "Insufficient tax payment");
        if (msg.value > tax) {
            (bool success, ) = payable(msg.sender).call{value: msg.value.sub(tax)}("");
            require(success, "Refund failed");
        }
    }

    function withdraw_tax() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No tax to withdraw");
        (bool success, ) = payable(owner()).call{value: balance}("");
        require(success, "Withdrawal failed");
        // emit TaxWithdrawn(owner(), balance);
    }

    /**
     * @dev Ensures the contract can receive ETH
     */
    receive() external payable {}
}