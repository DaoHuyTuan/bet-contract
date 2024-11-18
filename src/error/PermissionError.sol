// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

library PermissionError {
    error NotOwner();
    error NotAdmin();
    error NotManager();
    error NotParticipant();
}