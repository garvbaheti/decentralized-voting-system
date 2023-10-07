// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecentralizedVoting {
    address public administrator;
    address public electionCommissioner;
    string public electionType;
    bool public votingOpen;

    struct Voter {
        bool registered;
        bool hasVoted;
    }

    struct Candidate {
        string name;
        string party;
        string slogan;
        uint256 voteCount;
    }

    mapping(address => Voter) public voters;
    Candidate[] public candidates;

    event VoterRegistered(address indexed voterAddress);
    event VoteCast(address indexed voterAddress, uint256 candidateIndex);
    event ElectionWinner(string winnerName, string party, string slogan, uint256 voteCount);

    constructor(address _electionCommissioner, string memory _electionType) {
        administrator = msg.sender;
        electionCommissioner = _electionCommissioner;
        electionType = _electionType;
    }

    modifier onlyAdministrator() {
        require(msg.sender == administrator, "Only administrator can call this function");
        _;
    }

    modifier onlyElectionCommissioner() {
        require(msg.sender == electionCommissioner, "Only election commissioner can call this function");
        _;
    }

    modifier onlyRegisteredVoter() {
        require(voters[msg.sender].registered, "You are not a registered voter");
        _;
    }

    modifier votingIsOpen() {
        require(votingOpen, "Voting is not open");
        _;
    }

    function registerVoter(address _voterAddress) external onlyAdministrator {
        require(!voters[_voterAddress].registered, "Voter is already registered");
        voters[_voterAddress].registered = true;
        emit VoterRegistered(_voterAddress);
    }

    function startVoting() external onlyElectionCommissioner {
        votingOpen = true;
    }

    function stopVoting() external onlyElectionCommissioner {
        votingOpen = false;
    }

    function addCandidate(string memory _name, string memory _party, string memory _slogan) external onlyElectionCommissioner votingIsOpen {
        candidates.push(Candidate({
            name: _name,
            party: _party,
            slogan: _slogan,
            voteCount: 0
        }));
    }

    function castVote(uint256 _candidateIndex) external onlyRegisteredVoter votingIsOpen {
        require(!voters[msg.sender].hasVoted, "You have already voted");
        require(_candidateIndex < candidates.length, "Invalid candidate index");
        voters[msg.sender].hasVoted = true;
        candidates[_candidateIndex].voteCount++;
        emit VoteCast(msg.sender, _candidateIndex);
    }

    function declareWinner() external onlyElectionCommissioner {
        require(!votingOpen, "Voting is still open");
        uint256 maxVotes = 0;
        uint256 winningCandidateIndex;
        for (uint256 i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > maxVotes) {
                maxVotes = candidates[i].voteCount;
                winningCandidateIndex = i;
            }
        }
        Candidate memory winner = candidates[winningCandidateIndex];
        emit ElectionWinner(winner.name, winner.party, winner.slogan, winner.voteCount);
    }
}
