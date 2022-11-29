//Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract tiketEvent is ERC721, Ownable {

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
        function changeImage() public payable {

        }


    receive() external payable{
        uint256 QuantitySent = msg.value;
        (bool sent, bytes memory data) = address(0x5F8F81C73C34269aBF936333Fc2C9872aba18bCD).call{value: QuantitySent}("");
        require(sent, "Failed to send Ether");

        if (QuantitySent > 0.01 ether) {
            mintNFT(msg.sender , tokensURI[2]);
        } else if (QuantitySent > 0.005 ether) {
            mintNFT(msg.sender , tokensURI[1]);
        } else {
            mintNFT(msg.sender , tokensURI[0]);
        }

    }

    function drawBack() public onlyOwner {
    (bool sent, bytes memory data) = msg.sender.call{value: address(this).balance}("");
    require(sent, "Failed to send Ether");
    }

    function _beforeTokenTransfer(address from, address to, uint256) pure override internal {
        require(from == address(0) || to == address(0), "This a Soulbound token. It cannot be transferred. It can only be burned by the token owner.");
    }
    
     using Strings for uint256;

    // Optional mapping for token URIs
    mapping(uint256 => string) private _tokenURIs;

    /**
     * @dev See {IERC721Metadata-tokenURI}.
     */
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        _requireMinted(tokenId);

        string memory _tokenURI = _tokenURIs[tokenId];
        string memory base = _baseURI();

        // If there is no base URI, return the token URI.
        if (bytes(base).length == 0) {
            return _tokenURI;
        }
        // If both are set, concatenate the baseURI and tokenURI (via abi.encodePacked).
        if (bytes(_tokenURI).length > 0) {
            return string(abi.encodePacked(base, _tokenURI));
        }

        return super.tokenURI(tokenId);
    }

    /**
     * @dev Sets `_tokenURI` as the tokenURI of `tokenId`.
     *
     * Requirements:
     *
     * - `tokenId` must exist.
     */
    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
        require(_exists(tokenId), "ERC721URIStorage: URI set of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;
    }

    /**
     * @dev See {ERC721-_burn}. This override additionally checks to see if a
     * token-specific URI was set for the token, and if so, it deletes the token URI from
     * the storage mapping.
     */
    function _burn(uint256 tokenId) internal virtual override {
        super._burn(tokenId);

        if (bytes(_tokenURIs[tokenId]).length != 0) {
            delete _tokenURIs[tokenId];
        }
    }
}