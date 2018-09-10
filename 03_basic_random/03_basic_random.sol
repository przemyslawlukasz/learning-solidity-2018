pragma solidity ^0.4.24;

contract BasicRandom {
    function generateNumber() view returns(uint8) {
        return uint8(keccak256(block.number + uint256(msg.sender))) % 100;
    }
}