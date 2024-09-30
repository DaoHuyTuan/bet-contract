// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.25;


contract AccountState {
    address public owner;
    uint256 total;
    struct Order {
        string token;
        uint256 value;
        uint256 price;
        bool existed;
    }
    mapping(string => Order) private orders;
    constructor(address _owner) {
        owner = _owner;
    }

    modifier onlyOwner(string memory message) {
        require(msg.sender == owner, string(abi.encodePacked("Only contract owner can", message)));
        _;
    }

    function create_order(string memory _id, string memory _token, uint256 _value, uint256 _price) external payable  {
        // require(msg.sender == owner, string(abi.encodePacked("Only contract owner can create")));
        orders[_id] = Order(_token, _value, _price, true);
        total++;    
    }
    
    function update_order(string memory _id, Order memory _newOrder) external payable onlyOwner("update") {
         require(orders[_id].existed, "Order does not exist");
         orders[_id] = _newOrder;
    }

    // function get_orders() external view returns (Order[] memory) {
    //     Order[] memory _orders = new Order[](1);
    //     for (uint256 i = 0; i < total; i++) {
    //         _orders[i] = orders[i];
    //     }
    //     return _orders;
    // }

    function test(string memory _id) public view returns (Order memory) {
        return orders[_id];
    }
}