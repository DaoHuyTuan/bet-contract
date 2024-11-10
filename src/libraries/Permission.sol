// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;
import "@openzeppelin/contracts/access/AccessControl.sol";


library Permission {
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant SUPPORT_ROLE = keccak256("SUPPORT_ROLE");
    bytes32 public constant PARTICIPANT_ROLE = keccak256("PARTICIPANT_ROLE");

    function init(AccessControl ac) internal {
        ac.grantRole(ADMIN_ROLE, msg.sender);
        
    }

    function onlyAdmin(AccessControl accessControl) internal view {
        require(accessControl.hasRole(ADMIN_ROLE, msg.sender), "You are't Admin");
    } 

    function onlyManager(AccessControl accessControl) internal view {
        require(accessControl.hasRole(ADMIN_ROLE, msg.sender) || accessControl.hasRole(SUPPORT_ROLE, msg.sender), "You are't Manager");
    }

    function onlyParticipant(AccessControl accessControl) internal view {
        require(accessControl.hasRole(PARTICIPANT_ROLE, msg.sender), "You are not in vault");
    }

    function notManager(AccessControl accessControl) internal view {
        require(!accessControl.hasRole(ADMIN_ROLE, msg.sender) && !accessControl.hasRole(SUPPORT_ROLE, msg.sender), "You must not be manager");
    }

    function grant_admin(AccessControl accessControl, address account) internal {
        accessControl.grantRole(ADMIN_ROLE, account);
    } 
} 