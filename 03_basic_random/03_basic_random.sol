pragma solidity ^0.4.24;

contract BasicRandom {
    function generateNumber() view public returns(uint8) {
        return uint8(keccak256(abi.encodePacked(now,uint256(msg.sender)))) % 100;
    }
}