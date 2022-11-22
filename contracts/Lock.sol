//Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

interface IERC20 {
    function transfer(address _to, uint256 _amount) external returns (bool);
}

contract tiketEvent is ERC721URIStorage, Ownable {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("ticket event", "TE") {}

    function mintNFT(address recipient, string memory tokenURI)
        internal 
        returns (uint256)
    {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
//table with the token URI
string[] tokensURI=["https://gateway.pinata.cloud/ipfs/Qmay4RVyzA6jpErEWGNn8uwWyGq1PxXNC9HstyvBmPvVrs","https://gateway.pinata.cloud/ipfs/QmZDSpx6h345U7kqPZt8qbXS5VBNzrc4aLsTunBMN5WiFf","https://gateway.pinata.cloud/ipfs/QmasWxpjKd18rLdPTZdbTC4Np8oQVb5Fu9CzoTk4AALHCg"];

// fuction for the payment
    receive() external payable{
        uint256 QuantitySent = msg.value;

        if (QuantitySent > 0.01 ether) {
            mintNFT(msg.sender , tokensURI[2]);
        } else if (QuantitySent > 0.005 ether) {
            mintNFT(msg.sender , tokensURI[1]);
        } else {
            mintNFT(msg.sender , tokensURI[0]);
        }

    }

    function drawBack() public onlyOwner {
        (bool sent) = msg.sender.call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }

    


}