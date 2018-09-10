pragma solidity ^0.4.24;

import "./Ownable.sol";

contract Greeter is Ownable {

	string greetings;
	
	event Greetings(address indexed who, string indexed greetings);
	event Earned(address indexed who, uint indexed howMuch);
	
	constructor(string _greetings) public {
		greetings = _greetings;
	}
	
	function sayHello() public returns (string _hello) {
		_hello = isOwner() ? "Hello Daddy" : greetings;
		emit Greetings(msg.sender, _hello);
		return _hello;
	}
	
	function changeGreetings(string _newGreetings) public onlyOwner() {
		greetings = _newGreetings;
	}
}