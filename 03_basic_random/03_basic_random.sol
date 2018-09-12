pragma solidity ^0.4.24;

contract RandomGenerator {
    function generateNumber() view public returns(uint);
}

contract BasicRandom is RandomGenerator {
    function generateNumber() view public returns(uint) {
        return uint8(keccak256(abi.encodePacked(now,uint256(msg.sender)))) % 100;
    }
}