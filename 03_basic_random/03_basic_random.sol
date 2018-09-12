pragma solidity ^0.4.24;

contract RandomGenerator {
    function generateNumber(uint) view public returns(uint);
}

contract BasicRandom is RandomGenerator {
    function generateNumber(uint _range) view public returns(uint) {
        return uint8(keccak256(abi.encodePacked(now,uint256(msg.sender)))) % _range;
    }
}