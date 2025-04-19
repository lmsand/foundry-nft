//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {console, Test} from "forge-std/Test.sol";
import {MoodNft} from "../../src/MoodNft.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";

contract MoodNFTTest is Test {
    MoodNft moodNFT;
    address USER = makeAddr("USER");
    DeployMoodNft deployer;

    string public constant HAPPY_SVG_IMAGE_URI =
        "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMjAwIDIwMCIgd2lkdGg9IjQwMCIgIGhlaWdodD0iNDAwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgogIDxjaXJjbGUgY3g9IjEwMCIgY3k9IjEwMCIgZmlsbD0icHVycGxlIiByPSI3OCIgc3Ryb2tlPSJibGFjayIgc3Ryb2tlLXdpZHRoPSIzIi8+CiAgPGcgY2xhc3M9ImV5ZXMiPgogICAgPGNpcmNsZSBjeD0iNjEiIGN5PSI4MiIgcj0iMjAiLz4KICAgIDxjaXJjbGUgY3g9IjEyNyIgY3k9IjgyIiByPSIxMiIvPgogIDwvZz4KICA8cGF0aCBkPSJtMTM2LjgxIDExNi41M2MuNjkgMjYuMTctLjExIDQyLTgxLjUyLS43MyIgc3R5bGU9ImZpbGw6bm9uZTsgc3Ryb2tlOiBibGFjazsgc3Ryb2tlLXdpZHRoOiA3OyIvPgo8L3N2Zz4=";

    string public constant SAD_SVG_IMAGE_URI =
        "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMjAwIDIwMCIgd2lkdGg9IjQwMCIgIGhlaWdodD0iNDAwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgogIDxjaXJjbGUgY3g9IjEwMCIgY3k9IjEwMCIgZmlsbD0iZ3JlZW4iIHI9Ijc4IiBzdHJva2U9ImJsYWNrIiBzdHJva2Utd2lkdGg9IjMiLz4KICA8ZyBjbGFzcz0iZXllcyI+CiAgICA8Y2lyY2xlIGN4PSI2MSIgY3k9IjgyIiByPSIxMiIvPgogICAgPGNpcmNsZSBjeD0iMTI3IiBjeT0iODIiIHI9IjIwIi8+CiAgPC9nPgogIDxwYXRoIGQ9Im0xMzYuODEgMTM1LjUzYy42OSAyNi4xNy03NSAtNTAtODEuNTItLjczIiBzdHlsZT0iZmlsbDpub25lOyBzdHJva2U6IGJsYWNrOyBzdHJva2Utd2lkdGg6IDc7Ii8+Cjwvc3ZnPg==";

    string public constant SAD_SVG_URI = "data:application/json;base64,eyJuYW1lOiAiTW9vZCBORlQiLCBkZXNjcmlwdGlvbjogIkFuIE5GVCB0aGF0IHJlZmxlY3RzIHlvdXIgbW9vZCEiLCAiYXR0cmlidXRlcyI6IFt7InRyYWl0X3R5cGUiOiAiTW9vZCIsICJ2YWx1ZSI6IDEwMH1dLCAiaW1hZ2UiOiBkYXRhOmltYWdlL3N2Zyt4bWw7YmFzZTY0LFBITjJaeUIyYVdWM1FtOTRQU0l3SURBZ01qQXdJREl3TUNJZ2QybGtkR2c5SWpRd01DSWdJR2hsYVdkb2REMGlOREF3SWlCNGJXeHVjejBpYUhSMGNEb3ZMM2QzZHk1M015NXZjbWN2TWpBd01DOXpkbWNpUGdvZ0lEeGphWEpqYkdVZ1kzZzlJakV3TUNJZ1kzazlJakV3TUNJZ1ptbHNiRDBpZVdWc2JHOTNJaUJ5UFNJM09DSWdjM1J5YjJ0bFBTSmliR0ZqYXlJZ2MzUnliMnRsTFhkcFpIUm9QU0l6SWk4K0NpQWdQR2NnWTJ4aGMzTTlJbVY1WlhNaVBnb2dJQ0FnUEdOcGNtTnNaU0JqZUQwaU56QWlJR041UFNJNE1pSWdjajBpTVRJaUx6NEtJQ0FnSUR4amFYSmpiR1VnWTNnOUlqRXlOeUlnWTNrOUlqZ3lJaUJ5UFNJeE1pSXZQZ29nSUR3dlp6NEtJQ0E4Y0dGMGFDQmtQU0p0TVRNMkxqZ3hJREV4Tmk0MU0yTXVOamtnTWpZdU1UY3ROalF1TVRFZ05ESXRPREV1TlRJdExqY3pJaUJ6ZEhsc1pUMGlabWxzYkRwdWIyNWxPeUJ6ZEhKdmEyVTZJR0pzWVdOck95QnpkSEp2YTJVdGQybGtkR2c2SURNN0lpOCtDand2YzNablBnbz0ifQ==";

    function setUp() public {
        deployer = new DeployMoodNft();
        moodNFT = deployer.run();
    }

    function testViewTokenURIIntegration() public {
        vm.prank(USER);
        moodNFT.mintNft();
        console.log(moodNFT.tokenURI(0));
    }

    // This test has our USER mint an NFT (which defaults as happy), and then flips the mood to sad with the flipMood function. We then assert that the token's URI matches what's expected.
    // function testFlipMoodIntegration() public {
    //     vm.prank(USER);
    //     moodNFT.mintNft();
    //     vm.prank(USER);
    //     moodNFT.flipMood(0);
        // assert(
        //     keccak256(abi.encodePacked(moodNFT.tokenURI(0))) ==
        //         keccak256(abi.encodePacked(SAD_SVG_URI))
        // );
        //This is where I like to employ `assertEq` instead of `assert` as this will print both the left and right sides of the assertion to our console.
        // assertEq(
        //     keccak256(abi.encodePacked(moodNFT.tokenURI(0))),
        //     keccak256(abi.encodePacked(SAD_SVG_URI))
        // );
    //}

// Well, our hashes are definitely different. We can import console and log out some variables to see what's going wrong.
    // it's important to be explicit in our naming conventions!!
    function testFlipMoodIntegration() public {
        vm.prank(USER);
        moodNFT.mintNft();
        vm.prank(USER);
        moodNFT.flipMood(0);
        console.log(moodNFT.tokenURI(0));
        assertEq(keccak256(abi.encodePacked(moodNFT.tokenURI(0))), keccak256(abi.encodePacked(SAD_SVG_URI)));
    }
}
