// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank {    
    // Declare bank owner address
    address public bankOwner;
    // Declare bank name
    string public bankName;
    // Map customer address with their balance
    mapping(address => uint256) public customerBalance;

    //constructor will only run once, when the contract is deployed
    constructor() {                
        //we're setting the bank owner to the Ethereum address that deploys the contract
        //msg.sender is a global variable that stores the address of the account that initiates a transaction
        bankOwner = msg.sender;
    }

    // Function for Owner to set the name of bank
    function setBankName(string memory _name) external {
        require(
            msg.sender == bankOwner,
            "You must be the owner to set the name of the bank"
        );
        bankName = _name;
    }

    // Function for Owner to get the bank balances
    function getBankBalance() public view returns (uint256) {
        require(
            msg.sender == bankOwner,
            "You must be the owner of the bank to see all balances."
        );
        return address(this).balance;
    }

    // Function for Customer to deposit money into bank
    function depositMoney() public payable {
        require(msg.value != 0, "You need to deposit some amount of money!");
        customerBalance[msg.sender] += msg.value;
    }

    // Function for Customer to withdraw money from bank
    function withdrawMoney(address payable _to, uint256 _total) public {
        require(
            _total <= customerBalance[msg.sender],
            "You have insuffient funds to withdraw"
        );

        customerBalance[msg.sender] -= _total;
        _to.transfer(_total);
    }

    // Function for Customer to get their balance in bank
    function getCustomerBalance() external view returns (uint256) {
        return customerBalance[msg.sender];
    }
}
