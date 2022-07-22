// SPDX-License-Identifier: MIT
// pragma statement specifies valid compiler version:
// from <=0.8.4 to < 0.8.9
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.7.0/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.7.0/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts@4.7.0/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts@4.7.0/access/Ownable.sol";
import "@openzeppelin/contracts@4.7.0/utils/Counters.sol";



contract WSEVENFT is ERC721, ERC721Enumerable, ERC721URIStorage/*, Ownable*/ {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    // MAX_SUPPLY variable declared in uppercase because it is a convention for constant
    // solidity variables: this number limits the total number
    // of NFTs that can be minted
    uint256 MAX_SUPPLY = 10000;

    // MAPPING TO TRACK NFT Balances
    // uint type must correspond with related data types
    mapping(address => uint256) public nftBalances;

    constructor() ERC721("WSEVENFT", "SEVENFT") {}


    // onlyOwNer function modifier provides restricted access for minting. With onlyOwner
    // only the address which deploys the smart contract is alowed to mint.
    // however, we want anybody to mint therefore we can remove or comment out the 
    // modifier and also the Ownable contract initialisation declaration.
    // this contract will not be making use of the Ownable Openzepplin library
    function safeMint(address to, string memory uri) public /*onlyOwner*/ {
        uint256 tokenId = _tokenIdCounter.current();
        nftBalances[msg.sender] = tokenId;
        // require staatement that checks if max suppply has been reached
        // before minting. If true then the rest of the safeMint fucntion will be executed
        require(_tokenIdCounter.current() <= MAX_SUPPLY, "I'm sorry - all WSEVENFTs have been minted");
        require(nftBalances[msg.sender] <= 7, "Your account has reached the WSEVENFT minting limit");
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
