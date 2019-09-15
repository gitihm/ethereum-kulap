pragma solidity ^0.5.0;

import "./SafeMath.sol";
import "./Ownable.sol";
import "./IERC20.sol";

contract Erc20Bank is Ownable {
    using SafeMath for uint256;
    
    mapping (address => uint256) private balances;
    
    address[] accounts;
    
    uint256 interestRate = 3;
    
    
    event DepositMade(address indexed accountAddress, uint256 amount);
    
    IERC20 public token;
    constructor(IERC20 erc20Address) public{
        token = erc20Address;
    }
    
    function deposite(uint256 amount) public returns (uint256) {
        
        //
        token.transferFrom(msg.sender, address(this), amount);
        
        if(0 == balances[msg.sender]){
            accounts.push(msg.sender);
        }
        
        balances[msg.sender] = balances[msg.sender].add(amount);
        
        emit DepositMade(msg.sender, amount);
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
        token.transfer(msg.sender,  amount);
        //msg.sender.transfer(amount);
        
        //41 or 42
        return balances[msg.sender];
        // remainingBalance = balances[msg.sender];
    }
    
    function systemBalance() public view returns (uint256) {
        
        return token.balanceOf(address(this));
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
