// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

pragma solidity ^0.8.18;

contract BasicNft is ERC721 {
  // constructor(string memory name_, string memory symbol_) { // the necessary arguments to the ERC721 constructor
  //   _name = name_;
  //   _symbol = symbol_;
  // }
  uint256 private s_tokenCounter;
  mapping(uint256 => string) private s_tokenIdToUri;

  constructor() ERC721("Doggie", "DOG"){ // Because each token is unique and possesses a unique tokenId, we absolutely need a token counter to track this in storage. We'll increment this each time a token is minted.
    s_tokenCounter = 0;
  }
  // constructor() ERC721("BasicNFT", "BFT") {
  //   s_tokenCounter = 0;
  // }

  function mintNFT(string memory tokenUri) public returns (uint256) {
    s_tokenIdToUri[s_tokenCounter] = tokenUri; // allow the user to choose what their NFT looks like. We'll do this by allowing the user to pass a tokenUri to the mint function and mapping this URI to their minted tokenId
    _safeMint(msg.sender, s_tokenCounter); // We can mint the token by calling the inherited _safeMint function.
    s_tokenCounter++;
  }

  // So what's this tokenURI function going to look like for us? Well, our BasicNFT is going to also use IPFS, so similarly to our example above, we'll need to set up our function to return this string, pointing to the correct location in IPFS
  function tokenURI(uint256 tokenId) public view override returns (string memory) {
    return s_tokenIdToUri[tokenId];
  }
}
