pragma solidity ^0.5.0;


contract HelloWorld {
    uint256 public age = 22;
    uint256 public a;
    
    constructor(uint256 _a) public { //blue is read only  _a have is u need u and u complete it hide and remove 
        a = _a;
    }
    
    
    
    function plus(uint256 b) //yellow write
        public 
        view //not edit in value or this is read only if u not use it , it is yellow
        returns(uint256){
        return a+b;
    }
    
    function modify(uint256 newA) public { //function write
        a = newA;
    }
}
//0x692a70D2e424a56D2C6C27aA97D1a86395877b3A
//0xbBF289D846208c16EDc8474705C748aff07732dB