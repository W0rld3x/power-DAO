// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;


interface IdaoContract {
    function balanceOf(address, uint256) external view returns (uint256);
}


contract Dao {

    address public owner;
    uint256 nextProposal;
    uint256[] public validTokens;
    IdaoContract daoContract;


    constructor() {
        owner = msg.sender;
        nextProposal = 1;
        daoContract = IdaoContract(0x2953399124F0cBB46d2CbACD8A89cF0599974963);
        validTokens = [77915346451473499503497640833511903142535010426673375113355467012823809261569];
    }


    struct proposal {
        uint256 id;
        bool exists;
        string description;
        uint256 deadline;
        uint256 votesUp;
        uint256 votesDown;
        address[] canVote;
        uint256 maxVotes;
        mapping(address => bool) voteStatus; 
        bool countConducted;
        bool passed;
    }


    mapping(uint256 => proposal) public Proposals;


    event proposalCreated(
        uint256 id, 
        string description,
        uint256 maxVotes,
        address proposer
    );

    event newVote(
        uint256 votesUp,
        uint256 votesDown,
        uint256 proposal,
        address voter,
        bool votedFor
    );

    event proposalCount(
        uint256 id, 
        bool passed
    );

    function checkProposalEligibility(address _proposalList) private view returns (bool){

        for(uint256 i = 0; i < validTokens.length; i++) {
            if(daoContract.balanceOf(_proposalList, validTokens[i]) >= 1){
                return true;
            }
        }
            return false;
    }
    

    function checkVoteEligibility(uint256 _id, address _voter) private view returns (bool) {
        
        for(uint256 i = 0; i < Proposals[_id].canVote.length; i++){
            if(Proposals[_id].canVote[i] == _voter) {
                return true;
            }
        }
            return false;
    }


    function createProposal(string memory _description, address[] memory _canVote, uint256 _deadlineInMinuts) public {
        require(checkProposalEligibility(msg.sender), "Only NFT holders can put forth proposals");

        proposal storage newProposal = Proposals[nextProposal];

        newProposal.id = nextProposal;
        newProposal.exists = true;
        newProposal.description = _description;
        newProposal.deadline = block.timestamp + _deadlineInMinuts;  // Modify deadLineInMinuts with what you want 
        newProposal.canVote = _canVote;
        newProposal.maxVotes = _canVote.length;

    emit proposalCreated(nextProposal, _description, _canVote.length, msg.sender);
    }



    function voteOnProposal(uint256 _id, bool _vote) public {
        require(Proposals[_id].exists, "The proposal doesn't exist");
        require(checkVoteEligibility(_id, msg.sender), "You are not eligible to vote for this proposal");
        require(!Proposals[_id].voteStatus[msg.sender], "You have already voted for this Proposal !");
        require(block.timestamp < Proposals[_id].deadline, "The deadline has passed for this Proposal...");


        proposal storage p = Proposals[_id];

        if(_vote) {
            p.votesUp++;
        } else {
            p.votesDown++;
        }

        p.voteStatus[msg.sender] = true;


        emit newVote(p.votesUp, p.votesDown, _id, msg.sender, _vote);
    }


    function countVotes(uint256 _id) public {
        require(msg.sender == owner, "Only the owner can count votes");
        require(Proposals[_id].exists, "The proposal doesn't exist");
        require (block.timestamp < Proposals[_id].deadline, "Voting has not concluded");  // This line must be " > " but something doesnt work.
        require(!Proposals[_id].countConducted, "count already conducted");


    proposal storage p = Proposals[_id];

    if(Proposals[_id].votesDown < Proposals[_id].votesUp) {
        p.passed = true;
    }

    p.countConducted = true;


    emit proposalCount(_id, p.passed);
    }


    function addTokens(uint256 _tokenId) public {
        require(msg.sender == owner, "You are not the Owner");

        validTokens.push(_tokenId);
    }



}