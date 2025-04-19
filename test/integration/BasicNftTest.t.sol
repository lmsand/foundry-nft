// //SPDX-License-Identifier: MIT

// pragma solidity ^0.8.18;

// import {Test} from "forge-std/Test.sol";
// import {BasicNft} from "../../src/BasicNft.sol";
// import {DeployBasicNft} from "../../script/DeployBasicNFT.s.sol";

// contract BasicNFtTest is Test {
//   DeployBasicNft public deployer;
//   BasicNft public basicNft;

//   address public USER = makeAddr("user");
//   string public constant PUG =
//       "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

//   function setUp() public {
//       deployer = new DeployBasicNft();
//       basicNft = deployer.run();
//   }

//   function testNameIsCorrect() public view { // we're encoding and hashing both of our strings before comparing them in our assertion
//     string memory expectedName = "Doggie";
//     string memory actualName = basicNft.name();

//     assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
//   }

//   function testCanMintAndHaveABalance() public { // assure a user can mint the NFT and then change the user's balance. We'll need to create a user to prank in our test. Additionally, we'll need to provide our mint function a tokenUri
//     vm.prank(USER);
//     basicNft.mintNFT(PUG);

//     assert(basicNft.balanceOf(USER) == 1);
//     assert(keccak256(abi.encodePacked(PUG)) == keccak256(abi.encodePacked(basicNft.tokenURI(0))));
//   }
// }
