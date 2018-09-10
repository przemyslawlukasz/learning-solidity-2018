pragma solidity ^0.4.24;

import "../ownLibrary/Ownable.sol";

contract AccountChecker is Ownable {
    
    address public owner;
    
    constructor() public {
        owner = msg.sender;
    }
    
    function contractAddress() external view returns(address) {
        return this;
    }
    
    function callerAddress() external view returns(address) {
        return msg.sender;
    }
    
    function balance() external view returns(uint) {
        return address(this).balance;
    }
    
    function ownerBalance() external view onlyOwner() returns(uint) {
        return owner.balance;
    }
    
    function callerBalance() external view returns(uint) {
        return msg.sender.balance;
    }
}