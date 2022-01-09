// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Casino {
    address payable public owner;
    uint256 _winNo;
    uint256 _userCount;
    uint256 _minPrice;
    uint256 _accumulatedAmount;
    bool _betting;

    constructor() payable {
        owner = payable(msg.sender);
        _userCount = 0;
        _betting = false;
        _minPrice = 1 gwei;
        _accumulatedAmount = 0 gwei;
    }

    // Only Admin can access, generating the bet number
    modifier onlyAdmin() {
        require(msg.sender == owner);
        _;
    }

    struct User {
        address userAddress;
        string name;
        uint256 betNo;
        uint256 betAmount;
        bool exists;
        bool won;
    }

    address[] public betters;
    mapping(address => User) public betDetails;

    function startBet() public onlyAdmin {
        _betting = false;
    }

    function stopBet() public onlyAdmin {
        _betting = true;
    }

    function addBet(string memory name, uint256 betNo) public payable {
        // avoid multiple bets from same user
        require(!betDetails[msg.sender].exists);
        require(betNo >= 1 && betNo <= 10);
        require(msg.value >= _minPrice);

        User memory newUser = User({
            userAddress: msg.sender,
            name: name,
            betNo: betNo,
            betAmount: msg.value,
            exists: true,
            won: false
        });
        betDetails[msg.sender] = newUser;
        betters[_userCount] = msg.sender;
        _accumulatedAmount += msg.value;
        _userCount += 1;
    }

    function generateWinner() public onlyAdmin {
        //should call random no and the next step to use Chainlink VRF for that

        uint256 randomNo = 2;
        _winNo = randomNo;
    }

    function revealWinNo() public view returns (uint256) {
        require(_betting == false);
        return _winNo;
    }

    function getAccumulated() public view returns (uint256) {
        return address(this).balance;
    }
}
