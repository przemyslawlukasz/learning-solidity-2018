pragma solidity ^0.4.24;
import "../03_basic_random/03_basic_random.sol";

contract Lottery4TenUsers {
    
    event LotteryNewParticipantJoin(address indexed);
    event LotteryWinner(address indexed);
    
    RandomGenerator randomGenerator;
    
    uint constant participantsLimit = 5;
    uint constant BID = 100 finney;
    mapping (address => bool) participantFlag;
    address[] participants;
    
    constructor(address _randomGenerator) public {
        randomGenerator = RandomGenerator(_randomGenerator);
    }
    
    function join() external payable {
        require(participantFlag[msg.sender] == false, "You've joined already");
        require(msg.value == BID, "You need to pay 0.1 ether");
        participantFlag[msg.sender] = true;
        participants.push(msg.sender);
        emit LotteryNewParticipantJoin(msg.sender);
        if(participants.length == participantsLimit) {
            address winner = participants[randomGenerator.generateNumber() % participantsLimit];
            winner.transfer(participantsLimit * BID);
            emit LotteryWinner(winner);
            clearParticipants();
        }
    }
    
    function clearParticipants() internal {
        for(uint i = 0; i < participantsLimit; i++) {
            participantFlag[participants[i]] = false;
        }
        participants.length = 0;
    }
    
    function setRandomGeneratorContractAddress(address _randomGenerator) external {
        require(participants.length == 0, "You cannot change randomGenerator during lottery");
        randomGenerator = RandomGenerator(_randomGenerator);
    }
}