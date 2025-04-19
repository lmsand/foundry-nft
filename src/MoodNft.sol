// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {

    error MoodNFT__CantFlipMoodIfNotOwner();

    // we'll need a `tokenCounter`, along with this let's declare our `sadSvg` and `happySvg` as storage variables as well
    uint256 private s_tokenCounter;
    string private s_sadSvgImageUri;
    string private s_happySvgImageUri;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) private s_tokenIdToMood;

    // We want to store the `SVG` art on chain, we're actually going to pass these to our `constructor` on deployment
    constructor(
        string memory sadSvgImageUri,
        string memory happySvgImageUri
    ) ERC721("Mood NFT", "MN") {
        s_sadSvgImageUri = sadSvgImageUri;
        s_happySvgImageUri = happySvgImageUri;
        s_tokenCounter = 0;
    }

    // Minting an NFT means creating a unique digital asset and registering it on a blockchain, essentially publishing a one-of-a-kind digital token that represents ownership or proof of authenticity of a digital item.
    // Here's a more detailed explanation:
    // What it is:
    // Minting an NFT is the process of bringing a new, unique digital asset into existence on a blockchain.

    // Now we need a `mint` function, anyone should be able to call it, so it should definitely be `public`
    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY; // default mood
        s_tokenCounter++;
    }

    /** Function explanation:
     * Admittedly, this is a lot at once. Before we add any more functionality, let's consider writing a test to make sure things are working as intended. To summarize what's happening:

      1. We created a string out of our JSON object, concatenated with abi.encodePacked.
      2. typecast this string as a bytes object
      3. encoded the bytes object with Base64
      4. concatenated the encoding with our \_baseURI prefix
      5. typecast the final value as a string to be returned as our tokenURI

     */

    // As we write the `tokenURI` function, we know this is what defines what our NFT looks like and the metadata associated with it. Remember that we'll need to `override` this `virtual` function of the `ERC721` standard.
    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageURI;
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageURI = s_happySvgImageUri;
        } else {
            imageURI = s_sadSvgImageUri;
        }

        //  Currently we have a string, in order to acquire the Base64 hash of this data, we need to first convert this string to bytes, we can do this with some typecasting
        // Now, in our tokenURI function again, we can concatenate the result of this _baseURI function with the Base64 encoding of our JSON object... and finally we can type cast all of this as a string to be returned by our tokenURI function.
        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name: "',
                                name(),
                                '", description: "An NFT that reflects your mood!", "attributes": [{"trait_type": "Mood", "value": 100}], "image": ',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }

    // At this point, our tokenURI data is formatting like our imageUris were. If you recall, we needed to prepend our data type prefix(`data:image/svg+xml;base64,`) to our Base64 hash in order for a browser to understand. A similar methodology applies to our tokenURI JSON but with a different prefix. Let's define a method to return this string for us. Fortunately the ERC721 standard has a \_baseURI function that we can override.

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    // From here, we'll just check if it NFT is happy, and if so, make it sad, otherwise we'll make it happy. This will flip the NFT's mood regardless of it's current mood.
    // A more elegant solution is to check for approval and for the owner of the token separately.
    function flipMood(uint256 tokenId) public view {
      if(getApproved(tokenId) != msg.sender && ownerOf(tokenId) != msg.sender){
          revert MoodNFT__CantFlipMoodIfNotOwner();
      }

      if(s_tokenIdToMood[tokenId] == Mood.HAPPY){
          s_tokenIdToMood[tokenId] == Mood.SAD;
      } else{
          s_tokenIdToMood[tokenId] == Mood.HAPPY;
      }
    }
}

// OpenZeppelin has replaced '_isApprovedOrOwner' with '_isAuthorized', doesn't cover all bases/isn't recommended

/**
 *    function flipMood(uint256 tokenId) public {
    // Fetch the owner of the token
    address owner = ownerOf(tokenId);
    // Only want the owner of NFT to change the mood.
    _checkAuthorized(owner, msg.sender, tokenId);

    if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
        s_tokenIdToMood[tokenId] = Mood.SAD;
    } else {
        s_tokenIdToMood[tokenId] = Mood.HAPPY;
    }
}
 */
