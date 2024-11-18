// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;
import "@openzeppelin/contracts/access/AccessControl.sol";
import "../error/PermissionError.sol";

// library Permission {
//     bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
//     bytes32 public constant SUPPORT_ROLE = keccak256("SUPPORT_ROLE");
//     bytes32 public constant PARTICIPANT_ROLE = keccak256("PARTICIPANT_ROLE");

//     function init(AccessControl ac) internal {
//         ac.grantRole(ADMIN_ROLE, msg.sender);
        
//     }

//     function onlyAdmin(AccessControl accessControl) internal view {
//         require(accessControl.hasRole(ADMIN_ROLE, msg.sender), "You are't Admin");
//     } 

//     function onlyManager(AccessControl accessControl) internal view {
//         require(accessControl.hasRole(ADMIN_ROLE, msg.sender) || accessControl.hasRole(SUPPORT_ROLE, msg.sender), "You are't Manager");
//     }

//     function onlyParticipant(AccessControl accessControl) internal view {
//         require(accessControl.hasRole(PARTICIPANT_ROLE, msg.sender), "You are not in vault");
//     }

//     function notManager(AccessControl accessControl) internal view {
//         require(!accessControl.hasRole(ADMIN_ROLE, msg.sender) && !accessControl.hasRole(SUPPORT_ROLE, msg.sender), "You must not be manager");
//     }

//     function grant_admin(AccessControl accessControl, address account) internal {
//         accessControl.grantRole(ADMIN_ROLE, account);
//     } 
// } 

contract Permission is AccessControl {
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant SUPPORT_ROLE = keccak256("SUPPORT_ROLE");
    bytes32 public constant PARTICIPANT_ROLE = keccak256("PARTICIPANT_ROLE");

    function onlyAdmin() internal view {
        require(hasRole(ADMIN_ROLE, msg.sender));
        
    } 

    function onlyManager() internal view {
        if (!hasRole(ADMIN_ROLE, msg.sender)) revert PermissionError.NotManager();
        // require(accessControl.hasRole(ADMIN_ROLE, msg.sender) || accessControl.hasRole(SUPPORT_ROLE, msg.sender), "You are't Manager");
    }

    function onlyParticipant() internal view {
        if (!hasRole(PARTICIPANT_ROLE, msg.sender)) revert PermissionError.NotParticipant();
        // require(accessControl.hasRole(PARTICIPANT_ROLE, msg.sender), "You are not in vault");
    }

    function notManager() internal view {
        if (!hasRole(ADMIN_ROLE, msg.sender)) revert PermissionError.NotManager();
        // require(!accessControl.hasRole(ADMIN_ROLE, msg.sender) && !accessControl.hasRole(SUPPORT_ROLE, msg.sender), "You must not be manager");
    }

    function grant_support(address account) internal {
        onlyAdmin();
        _grantRole(SUPPORT_ROLE, account);
    }
}