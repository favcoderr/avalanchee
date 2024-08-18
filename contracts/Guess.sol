// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GuessTheNumber {
    uint256 internal secretNumber;
    uint256 public prizePool;
    uint256 public entryFee = 2 ether;
    address public owner;

    event NumberGuessed(address indexed player, uint256 guess, bool won, uint256 prizeWon);

    modifier onlyOwner() {
        assert(msg.sender == owner);
        _;
    }

    constructor() {
        // Initialize the secret number
        secretNumber = (uint256(keccak256(abi.encodePacked(block.timestamp))) % 100);
        owner = msg.sender;
    }

    function guess(uint256 _guessedNumber) external payable {
        require(msg.value >= entryFee, "Insufficient entry fee");
        
        if (_guessedNumber == secretNumber) {
            // Player guessed correctly, win the prize
            uint256 prizeWon = prizePool + msg.value;
            payable(msg.sender).transfer(prizeWon);
            emit NumberGuessed(msg.sender, _guessedNumber, true, prizeWon);
            
            // Reset the game
            resetGame();
        } else {
            // Add the entry fee to the prize pool
            prizePool += msg.value;
            emit NumberGuessed(msg.sender, _guessedNumber, false, 0);
        }
    }

    function resetGame() private {
        // Generate a new secret number
        secretNumber = (uint256(keccak256(abi.encodePacked(block.timestamp))) % 100);
        // Reset the prize pool
        prizePool = 0;
    }

    // Function to demonstrate revert()
    function setNumber(uint256 _value) onlyOwner external {
        // Using revert() to handle invalid inputs
        if (_value < 1) {
            revert("Input must be greater than 1");
        }

        // Reset secret number manually
        secretNumber = _value;
    }

    function viewSecret() onlyOwner external view returns (uint256) {
        return secretNumber;
    }

}
