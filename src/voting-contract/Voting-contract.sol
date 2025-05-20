// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

contract Contract { 
    uint8 public proposalCnt;
    struct Proposals {
        bytes32 name ;
        uint32  voteCount;
        uint32  startTime;
        uint32  endTime;
        bool executed;
    }

    mapping(uint8 => Proposals)public proposals;
    mapping(uint32 => uint8)public proposalVoteCnt;
    mapping(address => uint256) private voterRegistry;
    function createProposal(bytes32 name , uint32 duration) external {
        require(duration > 0, "Increase the duration");
        uint8 proposalId = proposalCnt;
        proposalCnt++;

        Proposals memory newProposal = Proposals({
            name : name,
            voteCount : 0,
            startTime : uint8(block.timestamp),
            endTime : uint8(block.timestamp) + duration,
            executed : false
        });

        proposals[proposalId] =newProposal;
    }

    function vote(uint8 proposalId) external{
        require(proposalCnt >= proposalId);
        uint32 currentTime = uint32(block.timestamp);
        require(proposals[proposalId].startTime < currentTime);
        require(proposals[proposalId].endTime > currentTime);
        
        uint256 voterData = voterRegistry[msg.sender];
        uint256 mask = 1 << proposalId;
        require((voterData & mask) == 0);

        voterRegistry[msg.sender] = voterData | mask;

        proposals[proposalId].voteCount++;
        proposalVoteCnt[proposalId]++;
    }


    function hasVoted(address _user, uint32 id) external view returns(bool){
        return (voterRegistry[_user] & (1 << id))!= 0 ;
    }


    function getProposal(uint8 id) external view returns(
        bytes32 name,
        uint32 voteCount,
        uint32 startTime,
        uint32 endTime,
        bool executed
    ){
      require(id <= proposalCnt);
      Proposals storage proposal =proposals[id];
      return (
        proposal.name,
        proposal.voteCount,
        proposal.startTime,
        proposal.endTime,
        proposal.executed
      ) ;
    }
}
