pragma solidity ^0.4.24;

contract Greeter {

	string greetings;
	address owner;
	
	event Greetings(address who, string greetings);
	
	constructor(string _greetings) public {
		greetings = _greetings;
		owner = msg.sender;
	}
	
	modifier onlyOwner {
	    require(isOwner(), "Are you owner or cryptohacker?");
	    _;
	}
	
	function sayHello() public view returns (string) {
		string result = (msg.sender == owner) ? "Hello Daddy" : greetings;
		emit Greetings(msg.sender, result);
		return result;
	}
	
	function changeGreetings(string _newGreetings) public onlyOwner {
		require(msg.sender == owner);
		greetings = _newGreetings;
	}
	
	function isOwner() view private returns (bool) {
	    return msg.sender == owner;
	}
}