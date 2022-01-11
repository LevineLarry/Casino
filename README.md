# Casino-Contract

Casino contract found in ```/contracts/Casino.sol```

#### To compile the contract:

``` truffle compile ```

#### Contract functionality:

- startBet and stopBet admin only functions to start and stop the casino betting for the users.
- User can add bet to specific number and through payable function addBet.
- getAccumulated displays the total amount accumulated in the smart contract through the bets.
- payWinners divides a portion of the accumalated ether in the contract (currently 90%) according to the ratio of the bets made by the winners of the bet, and sends the ether to the winner's addresses.
- generateRandom, which generates the winner bets is not yet implemented.
