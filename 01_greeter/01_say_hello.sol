pragma solidity ^0.4.24;

contract Greeter {

	string greetings;
	address owner;
	
	constructor(string _greetings) public {
		greetings = _greetings;
		owner = msg.sender;
	}
	
	modifier onlyOwner {
	    require(isOwner(), "Are you owner or cryptohacker?");
	    _;
	}
	
	function sayHello() public view returns (string) {
		if (msg.sender == owner)
			return "Hello Daddy";
		else 
			return greetings;
	}
	
	function changeGreetings(string _newGreetings) public onlyOwner {
		require(msg.sender == owner);
		greetings = _newGreetings;
	}
	
	function isOwner() view private returns (bool) {
	    return msg.sender == owner;
	}
}