// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;
import "@openzeppelin/contracts/access/Ownable.sol";

contract Registry is Ownable {
    mapping(string => uint256) public genre;
    mapping(string => uint256) public category;
    string[] aGenres = ["sport", "esport"];
    string[] aCategories = ["dota2", "csgo"];
    constructor() Ownable(msg.sender) {
        genre["sport"] = 0;
        genre["esport"] = 1;
        category["dota2"] = 0;
        category["csgo"] = 1;
    }

    modifier isGenreExisted(string memory name) {
        require(genre[name] == 0, "Genre already exists");
        _;
    }

    modifier isCategoryExisted(string memory name) {
        require(category[name] == 0, "Category already exists");
        _;
    }
    
    function create_genre(string memory genre_name) external isGenreExisted(genre_name) {
        genre[genre_name] = aGenres.length;
        aGenres.push(genre_name);
    }
    
    function create_category (string memory category_name) external isCategoryExisted(category_name) {
        category[category_name] = aCategories.length;
        aCategories.push(category_name);
    }

    function get_genres() public view returns (string[] memory) {
        return aGenres;
    }

    function get_categorys() public view returns (string[] memory) {
        return aCategories;
    }
}