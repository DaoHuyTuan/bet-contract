// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "../Utils.sol";

contract ServiceSoccer {
  
  constructor(address service_contract) {
    
  }

  function get_id() external view returns (uint256) {
    return service_id;
  }
}