// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "../Utils.sol";

contract ServiceSoccer {
  uint256 private service_id;
  constructor() {
    service_id = Utils.generate_unique_id("service");
  }

  function get_id() external view returns (uint256) {
    return service_id;
  }
}