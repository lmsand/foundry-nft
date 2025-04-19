// SPDX-License-Identifier:MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployMoodNft is Script {
    function run() external returns (MoodNft) {
        string memory sadSvg = vm.readFile("./img/sadSvg.svg");
        string memory happySvg = vm.readFile("./img/happySvg.svg");

        vm.startBroadcast();
        MoodNft moodNft = new MoodNft(
            svgToImageURI(sadSvg),
            svgToImageURI(happySvg)
        );
        vm.stopBroadcast();

        return moodNft;
    }

    // Now we should consider how we're mention to deploy MoodNft.sol. We know that the constructor arguments for this contract take a sadSvgImageUri and a happySvgImageUri, so much like we did in `MoodNftTest.t.sol`, we _could_ hardcode these values. A better approach however may be to write our deploy script to read this data itself from our workspace. Our script can even do all the encoding for us.
    function svgToImageURI(
        string memory svg
    ) public pure returns (string memory) {
        // The above function is taking the svg string parameter, encoding it with the OpenZeppelin Base64.encode function, and then prepends the encoded value with our baseURL.
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(bytes(svg));

        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}
