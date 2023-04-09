// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract VendingMachineV2 is Initializable {
    /// These variables will be preserved forever, regardless of upgrading
    uint public numSodas;
    address public owner;
    mapping (address => uint) public userPurchase;

    function initialize(uint _numSodas) public initializer  {
        numSodas = _numSodas;
        owner = msg.sender;
        
    }

    function purchaseSoda() public payable {
        require(msg.value >= 1000 wei, "Must Pay 1000 wei for a soda!");
        numSodas--;
        userPurchase[msg.sender] += 1;
    }

    function withdrawProfits() public onlyOwner {
        require(address(this).balance > 0, "Profits must be > 0");
        (bool sent, ) = owner.call{value: address(this).balance}("");
        require(sent, "Failed to send ether");
    }

    function setNewOwner(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }

    modifier onlyOwner () {
        require(msg.sender == owner, "Only onwer can call this function");
        _;
    }
}