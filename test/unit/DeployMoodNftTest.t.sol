// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";
import {Test} from "forge-std/Test.sol";

contract DeployMoodNftTest is Test {
    DeployMoodNft public deployer;

    function setUp() public {
        deployer = new DeployMoodNft();
    }

    // a test function to verify that our SVG is being converted to a URI appropriately. We should have an example to compare the results of our test to.
    // assign an expectedUri variable to this string. We'll need to also define the svg which we'll pass to the function
    function testConvertSvgToUri() public view {
      string memory expectedUri = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MDAiIGhlaWdodD0iNTAwIj4KPHRleHQgeD0iMjAwIiB5PSIyNTAiIGZpbGw9ImJsYWNrIj5IaSEgWW91IGRlY29kZWQgdGhpcyEgPC90ZXh0Pgo8L3N2Zz4=";
      string memory svg = '<svg xmlns="http://www.w3.org/2000/svg" width="500" height="500"><text x="200" y="250" fill="black">Hi! You decoded this! </text></svg>';

      string memory actualUri = deployer.svgToImageURI(svg);

      // Now we'll need to assert that our expectedUri is equal to our actualUri. Remember, we can't compare strings directly since they're effectively bytes arrays. We need to hash these for easy comparison.
      assert(
        keccak256(abi.encodePacked(expectedUri)) ==
        keccak256(abi.encodePacked(actualUri))
      );
  }
}
