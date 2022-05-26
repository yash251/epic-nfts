// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;
// We first import some OpenZeppelin Contracts.
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// We inherit the contract we imported. This means we'll have access
// to the inherited contract's methods.
contract MyEpicNFT is ERC721URIStorage {
    // keep track of tokenIds
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // We need to pass the name of our NFTs token and its symbol.
    constructor() ERC721 ("SquareNFT", "SQUARE") {
        console.log("This is a constructor");
    }

    // a function our user will hit to get their NFT
    function makeAnEpicNFT() public {
        // get the current tokenId, this starts at 0
        uint256 newItemId = _tokenIds.current();

        // actually mint the NFT to the sender using msg.sender
        _safeMint(msg.sender, newItemId);

        // set the NFTs data
        _setTokenURI(newItemId, "data:application/json;base64,ewogICAgIm5hbWUiOiAiWWFzaEJsb2NrY2hhaW5Gb3JldmVyIiwKICAgICJkZXNjcmlwdGlvbiI6ICJBbiBORlQgZnJvbSB0aGUgaGlnaGx5IGFjY2xhaW1lZCBZYXNoIGNvbGxlY3Rpb24iLAogICAgImltYWdlIjogImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjRiV3h1Y3owaWFIUjBjRG92TDNkM2R5NTNNeTV2Y21jdk1qQXdNQzl6ZG1jaUlIQnlaWE5sY25abFFYTndaV04wVW1GMGFXODlJbmhOYVc1WlRXbHVJRzFsWlhRaUlIWnBaWGRDYjNnOUlqQWdNQ0F6TlRBZ016VXdJajRLSUNBZ0lEeHpkSGxzWlQ0dVltRnpaU0I3SUdacGJHdzZJSGRvYVhSbE95Qm1iMjUwTFdaaGJXbHNlVG9nYzJWeWFXWTdJR1p2Ym5RdGMybDZaVG9nTVRSd2VEc2dmVHd2YzNSNWJHVStDaUFnSUNBOGNtVmpkQ0IzYVdSMGFEMGlNVEF3SlNJZ2FHVnBaMmgwUFNJeE1EQWxJaUJtYVd4c1BTSmliR0ZqYXlJZ0x6NEtJQ0FnSUR4MFpYaDBJSGc5SWpVd0pTSWdlVDBpTlRBbElpQmpiR0Z6Y3owaVltRnpaU0lnWkc5dGFXNWhiblF0WW1GelpXeHBibVU5SW0xcFpHUnNaU0lnZEdWNGRDMWhibU5vYjNJOUltMXBaR1JzWlNJK1dXRnphRUpzYjJOclkyaGhhVzVHYjNKbGRtVnlQQzkwWlhoMFBnbzhMM04yWno0PSIKfQ=="); // not using jsonkeeper anymore as it may go down, instead encoded the json file having SVG image
        console.log("An NFT with ID %s has been minted to %s", newItemId, msg.sender);


        // increment the counter for when the next NFT is minted
        _tokenIds.increment();
    }
}