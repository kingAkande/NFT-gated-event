// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract MyToken is ERC721 {
    uint256 private _nextTokenId;

    constructor() ERC721("TokenOla", "TKL") {
        _nextTokenId++;
        _safeMint(msg.sender, _nextTokenId);
    }

    function safeMint(address to) public {
        _nextTokenId++;
        _safeMint(to, _nextTokenId);
    }
}
