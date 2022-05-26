// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;
// We first import some OpenZeppelin Contracts.
import "@openzeppelin/contracts/utils/Strings.sol"; // function for strings
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// We inherit the contract we imported. This means we'll have access
// to the inherited contract's methods.
contract MyEpicNFT is ERC721URIStorage {
    // keep track of tokenIds
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // This is our SVG code. All we need to change is the word that's displayed. Everything else stays the same.
    // So, we make a baseSvg variable here that all our NFTs can use.
    string baseSvg = "<svg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'><style>.base { fill: white; font-family: serif; font-size: 24px; }</style><rect width='100%' height='100%' fill='black' /><text x='50%' y='50%' class='base' dominant-baseline='middle' text-anchor='middle'>";

    // arrays for generating three random words
    string[] firstWords = ["DeBruyne", "Grealish", "Foden", "Mahrez", "Gundogan", "Fernandinho", "Sterling", "Cancelo", "Jesus", "Zinchenko", "Rodri", "Silva", "Walker", "Ederson", "Laporte"];
    string[] secondWords = ["Barney", "Ted", "Joey", "Ross", "Chandler", "Sheldon", "Leonard", "Howard", "Raj", "Harvey", "Mike", "Walter", "Stefan", "Otis", "Tommy"];
    string[] thirdWords = ["Kendall", "Ariana", "Alia", "Deepika", "Milley", "Khushi", "Emma", "Margot", "Angelina", "Selena", "Rihanna", "Camila", "Beyonce", "Billie", "Dua"];

    // We need to pass the name of our NFTs token and its symbol.
    constructor() ERC721 ("YashFavourites", "YASHFAV") {
        console.log("This is a constructor");
    }

    // function to randomly pick a word from each array
    function random(string memory input) internal pure returns(uint256) {
        return uint256(keccak256(abi.encodePacked(input)));
    }

    function pickRandomFirstWord(uint256 tokenId) public view returns(string memory) {
        uint256 rand = random(string(abi.encodePacked("FIRST_WORD", Strings.toString(tokenId))));
        // Squash the # between 0 and the length of the array to avoid going out of bounds.
        rand = rand % firstWords.length;
        return firstWords[rand];
    }

    function pickRandomSecondWord(uint256 tokenId) public view returns(string memory) {
        uint256 rand = random(string(abi.encodePacked("SECOND_WORD", Strings.toString(tokenId))));
        rand = rand % secondWords.length;
        return secondWords[rand];
    }

    function pickRandomThirdWord(uint256 tokenId) public view returns(string memory) {
        uint256 rand = random(string(abi.encodePacked("THIRD_WORD", Strings.toString(tokenId))));
        rand = rand % thirdWords.length;
        return thirdWords[rand];
    }

    // a function our user will hit to get their NFT
    function makeAnEpicNFT() public {
        // get the current tokenId, this starts at 0
        uint256 newItemId = _tokenIds.current();

        // We go and randomly grab one word from each of the three arrays
        string memory first = pickRandomFirstWord(newItemId);
        string memory second = pickRandomSecondWord(newItemId);
        string memory third = pickRandomThirdWord(newItemId);

        // I concatenate it all together, and then close the <text> and <svg> tags.
        string memory finalSvg = string(abi.encodePacked(baseSvg, first, second, third, "</text></svg>"));
        console.log("\n--------------------");
        console.log(finalSvg);
        console.log("--------------------\n");

        // actually mint the NFT to the sender using msg.sender
        _safeMint(msg.sender, newItemId);

        // set the NFTs data
        _setTokenURI(newItemId, "blahblah"); // will be setting tokenURI later
        console.log("An NFT with ID %s has been minted to %s", newItemId, msg.sender);


        // increment the counter for when the next NFT is minted
        _tokenIds.increment();
    }
}