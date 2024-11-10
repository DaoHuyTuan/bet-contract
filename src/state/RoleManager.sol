// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RoleManager is AccessControl, Ownable {
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant SUPPORT_ROLE = keccak256("SUPPORT_ROLE");
    bytes32 public constant PARTICIPANT_ROLE = keccak256("PARTICIPANT_ROLE");
    constructor() Ownable(msg.sender) {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }
    // modifier onlyAdmin() {
    //     require(hasRole(ADMIN_ROLE, msg.sender));
    //     _;
    // }

    // modifier onlyManagerTeam() {
        
    // }

    function grantAdminRole(address admin) external onlyOwner {
        _grantRole(ADMIN_ROLE, admin);
        renounceOwnership();
    }

    function isManagerTeam() private view {
        require(hasRole(ADMIN_ROLE, msg.sender) || hasRole(SUPPORT_ROLE, msg.sender));
    }

    function grantSupportRole(address supporter) external {
        isManagerTeam();
        _grantRole(SUPPORT_ROLE, supporter);
    }

    function revokeSupporter(address supporter) external {
        isManagerTeam();
        _revokeRole(SUPPORT_ROLE, supporter);
    }

 
}