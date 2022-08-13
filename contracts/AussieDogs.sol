// SPDX-License-Identifier: MIT
pragma solidity 0.8.1;

import "openzeppelin-solidity/contracts/token/ERC721/ERC721.sol";

contract AussieDogs is ERC721 {
    uint public totalSupply = 0;
    uint public constant MAX_SUPPLY = 10;
    address immutable _owner;

    constructor() ERC721("Aussie Dogs", "ADOGS"){
        _owner = msg.sender;
    }

    function mint(uint _tokenId) external {
        require(totalSupply < MAX_SUPPLY, "supply reached");
        _mint(msg.sender, _tokenId);
        totalSupply++;
    }

    function _baseURI() internal pure override returns (string memory){
        return "ipfs://QmNsZbMqSZv6yLgevUFnytykgy9K8Srn43yeZr5Ms7GoDd/";
    }

    function viewBalance() external view returns (uint) {
        return address(this).balance;
    }

    function withdraw() external {
        require(msg.sender == _owner, "not owner");
        payable(msg.sender).transfer(address(this).balance);
    }

    fallback() external payable {}

    receive() external payable {}
}