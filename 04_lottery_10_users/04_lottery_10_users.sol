pragma solidity ^0.4.24;
import "../03_basic_random/03_basic_random.sol";

contract Lottery4NUsers {
    
    event LotteryNewParticipantJoin(address indexed);
    event LotteryWinner(address indexed);
    
    modifier onlyBetweenLotteries {
        require(participants.length == 0, "You cannot change parameters during lottery");
        _;
    }
    
    RandomGenerator randomGenerator;
    
    uint participantsLimit;
    uint bid;
    mapping (address => bool) participantFlag;
    address[] participants;
    
    constructor(address _randomGenerator, uint _participantsLimit, uint _bid) public {
        randomGenerator = RandomGenerator(_randomGenerator);
        participantsLimit = _participantsLimit;
        bid = _bid;
    }
    
    function join() external payable {
        require(participantFlag[msg.sender] == false, "You've joined already");
        require(msg.value == bid, "You need to pay proper BID value");
        participantFlag[msg.sender] = true;
        participants.push(msg.sender);
        emit LotteryNewParticipantJoin(msg.sender);
        if(participants.length == participantsLimit) {
            address winner = participants[randomGenerator.generateNumber(participantsLimit)];
            winner.transfer(participantsLimit * bid);
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
    
    function setRandomGeneratorContractAddress(address _randomGenerator) external onlyBetweenLotteries {
        randomGenerator = RandomGenerator(_randomGenerator);
    }
    
    function setBid(uint _bid) external onlyBetweenLotteries {
        bid = _bid;
    }
    
    function setNumberOfParticipants(uint _participantsLimit) external onlyBetweenLotteries {
        participantsLimit = _participantsLimit;
    }
    
}