// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract Tune is ERC20 {
    address public owner;
    address payable [] public receievers;
    uint256 months = 1697839280; //timestamp of 1 year from now
    uint start = block.timestamp;
    
    constructor() public ERC20("Tune", "XYZ") {
        _mint(msg.sender, 100000000 * 10 **18);
        owner == msg.sender;
    }

    function calculate(address payable [] memory _address) public {
        for(uint i =0 ; i<= _address.length; i++){
            receievers.push(_address[i]);
        }
    }

    function mint(address to, uint amount) external {
        require(msg.sender == owner, "only owner can mint token");
        _mint(to, amount);
    }

    function burn(uint amount) external {
        _burn(msg.sender, amount);
    }

    
    receive() payable external {
        require(start <= months , "Dispersing period expired");
        require(msg.value > 0, "Not enough ether");
        uint256 disperse = msg.value / 10;

        for(uint i =0; i <= 10; i++){
        receievers[i].transfer(disperse);
    }
    }
}