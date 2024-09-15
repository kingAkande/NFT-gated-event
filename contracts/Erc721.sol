// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract OlaToken is ERC20 {

    address owner;

    constructor() ERC20("OlaToken", "OTK") {
            owner = msg.sender;
             _mint(msg.sender, 1);
    }
  

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}
