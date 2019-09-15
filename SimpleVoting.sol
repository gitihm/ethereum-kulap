pragma solidity ^0.5.0;
pragma experimental ABIEncoderV2;

contract Voting {
  mapping (string => uint256) votesReceived;

 

  string[] public candidateList;
  
  event VotesReceived(address user , string candidate);

  constructor(string[] memory candidateNames) public {
    candidateList = candidateNames;
  }

 
  function totalVotesFor(string memory candidate) public view returns (uint256) {
    return votesReceived[candidate];
  }

  function voteForCandidate(string memory candidate) public {
    votesReceived[candidate] += 1;
    
    emit VotesReceived(msg.sender,candidate);
  }
  
  function candidateCount() public view returns (uint256) {
      return candidateList.length;
  }
}
