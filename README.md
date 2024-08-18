# GuessTheNumber Solidity Contract

## Overview
GuessTheNumber is a simple Solidity smart contract where players can guess a secret number within a specified range to win a prize. The contract holds a secret number generated upon deployment, and players can guess the number by paying an entry fee. If the guessed number matches the secret number, the player wins the prize pool.

## Contract Details
- **Owner:** The owner of the contract can set the secret number manually and view the current secret number.
- **Secret Number Generation:** The secret number is generated upon contract deployment using the block timestamp modulo operation to ensure randomness.
- **Entry Fee:** Players must pay an entry fee to participate in the game. The default entry fee is set to 2 ether.
- **Prize Pool:** The prize pool accumulates entry fees from players. When a player guesses the correct number, they win the prize pool along with their entry fee.
- **Reset Game:** If a player guesses the correct number, the game resets with a new secret number and an empty prize pool.

## Functions
1. **guess(uint256 _guessedNumber) external payable:** Allows players to guess the secret number by providing their guessed number as input. Players must also send the entry fee along with their guess. If the guess is correct, the player wins the prize pool; otherwise, their entry fee is added to the prize pool.
2. **resetGame() private:** Resets the game by generating a new secret number and resetting the prize pool. This function is called internally after a player guesses the correct number.
3. **setNumber(uint256 _value) onlyOwner external:** Allows the contract owner to manually set a new secret number. This function demonstrates the use of the `revert()` function to handle invalid inputs.
4. **viewSecret() onlyOwner external view returns (uint256):** Allows the contract owner to view the current secret number without modifying it.

## License
This contract is licensed under the MIT License.
