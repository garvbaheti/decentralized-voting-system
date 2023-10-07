# Decentralized Voting System

## Assignment Task

You are tasked with creating a Decentralized Voting System using Blockchain. The system should meet the following assumptions:

1. Each candidate may belong to a political party and uses a slogan for their candidature.
2. Different elections can have different Election Commissioners, and an Administrator assigns an Election Commissioner for each type of election.
3. Voters must register themselves with their addresses to ensure authentication during the casting of votes. Each voter can only vote once and cannot delegate their vote to someone else.
4. The Election Commissioner has the authority to start or stop the voting process.

## Summary

The Solidity code for the decentralized voting system creates a robust and transparent voting platform on the Ethereum blockchain. It introduces several critical features for conducting secure and decentralized elections. The contract defines two essential data structures: Voter and Candidate. Each voter must register with their address, and the contract maintains a mapping of voters to track their registration status and whether they have voted. The contract allows for the appointment of an administrator and an election commissioner, where the latter is responsible for controlling the voting process. The administrator can register voters, while the election commissioner can initiate and terminate the voting period. Candidates are added with their names, parties, and slogans, and voters can cast their ballots, ensuring that each voter can vote only once. The declareWinner function calculates and emits an event announcing the election's victor based on the highest vote count. The code also employs modifiers to restrict access to authorized personnel and ensures that actions like registration and voting only occur when the election is open. Overall, this Solidity contract establishes a decentralized voting system with transparency, immutability, and security as its core principles.

## Solidity Code

### Contract Structure

The contract is named `DecentralizedVoting` and includes several state variables, including `administrator`, `electionCommissioner`, `electionType`, and `votingOpen`, which store information about the administrator, election commissioner, election type, and whether voting is open or not.

### Data Structures

Two main data structures are defined as `Voter` and `Candidate`. `Voter` stores information about registered voters, including whether they are registered and whether they have voted. `Candidate` stores information about candidates, including their name, party, slogan, and vote count.

### Mappings and Arrays

The contract uses a mapping to associate each voter's address with their `Voter` struct to keep track of their registration and voting status. An array of `Candidate` structs stores information about all the candidates running in the election.

### Events

Events are used to log important contract actions. Events include `VoterRegistered`, `VoteCast`, and `ElectionWinner`, which are emitted when a voter registers, casts a vote, and when the election winner is declared, respectively.

### Constructor

The constructor initializes the contract, setting the `administrator`, `electionCommissioner`, and `electionType`.

### Modifiers

Modifiers like `onlyAdministrator`, `onlyElectionCommissioner`, `onlyRegisteredVoter`, and `votingIsOpen` are used to restrict access to certain functions based on the caller's role or the state of the contract.

### Functions

Various functions are defined for actions such as registering voters, starting and stopping the voting process, adding candidates, casting votes, and declaring the winner. The key functions include:

- `registerVoter`: Allows the administrator to register voters.
- `startVoting` and `stopVoting`: Enable the election commissioner to control the voting process.
- `addCandidate`: Allows the election commissioner to add candidates.
- `castVote`: Lets registered voters cast their votes for a specific candidate.
- `declareWinner`: Calculates and emits an event with the election winner's information.

### Usage of Modifiers

The functions use modifiers to ensure that only authorized users can perform certain actions. For example, only the administrator can register voters, only the election commissioner can start and stop voting, and only registered voters can cast votes.

### Winner Calculation

The winner of the election is determined by finding the candidate with the highest vote count in the `declareWinner` function.

