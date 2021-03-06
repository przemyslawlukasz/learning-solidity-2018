pragma solidity ^0.4.24;

contract Ownable {
    
    address private owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    modifier onlyOwner {
        require(isOwner(), "Only for Owner usage!");
        _;
    }
    
    function isOwner() public view returns(bool) {
        return msg.sender == owner;
    }
}