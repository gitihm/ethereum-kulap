pragma solidity ^0.5.0;

import "./SafeMath.sol";
import "./Ownable.sol";

contract SimpleBank is Ownable {
    using SafeMath for uint256;
    
    // Mapping between address and balances
    mapping (address => uint256) private balances;
    
    // User accounts in system
    // Purpose of use: calcuate interest rate and account to users
    address[] accounts;
    
    // Interest rate
    uint256 interestRate = 3;
    
    
    event DepositMade(address indexed accountAddress, uint256 amount);
    
    function deposite() public payable returns (uint256) {
        // Record account in array for looping
        if(0 == balances[msg.sender]){
            accounts.push(msg.sender);
        }
        
        balances[msg.sender] = balances[msg.sender].add(msg.value);
        
        emit DepositMade(msg.sender, msg.value);
        return balances[msg.sender];
    }
    
    function balance() public view returns(uint256) {
        return balances[msg.sender];
    }
    
    function balanceOf(address user) public view returns (uint256){
        return balances[user];
    }
    
    function withdraw(uint amount) public returns (uint256 remainingBalance) {
        require(balances[msg.sender] >= amount, "balance is not enought");
        balances[msg.sender] = balances[msg.sender].sub(amount);
        
        //Send ether back to user
        msg.sender.transfer(amount);
        
        //41 or 42
        return balances[msg.sender];
        // remainingBalance = balances[msg.sender];
    }
    
    function systemBalance() public view returns (uint256) {
        return address(this).balance;
    }
    
    function calculateInterest(address user, uint256 rate) private view returns (uint256){
        uint256 interest = balances[user].mul(rate).div(100);
        return interest;
    }
    
    function increaseYear() onlyOwner public {
        for(uint256 i = 0; i < accounts.length; i++) {
            address account = accounts[i];
            uint256 interest = calculateInterest(account, interestRate);
            balances[account] = balances[account].add(interest);
        }
    }
}
