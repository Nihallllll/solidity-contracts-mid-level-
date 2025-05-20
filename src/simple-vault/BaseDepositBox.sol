// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;
import "./IDepositeBox.sol";
abstract contract BaseDepositeBox is IDepositBox {
    //state variabels 
     address public owner;
     string private secret;
     uint private DepositeTime;
    //events 
     event ownerShipTransfered(address _newOwner,string message); 
     event secretAdded(string message , address indexed _address);


    constructor (){
        owner =msg.sender;
        DepositeTime = block.timestamp;
    }
    //owner modifier 
    modifier onlyOwner(){
        require(msg.sender == owner,"Not the owner");
        _;
    }
    //getting the owner of the box 
    function getOwner() public view override  returns(address){
       return owner;
    }
    

    //trasfering ownership
    function transferOwnership(address newOwner) public onlyOwner override {
        require(newOwner != address(0),"Not a Valid address");
        owner = newOwner;
        emit ownerShipTransfered( newOwner, "New owner is set ");
    } 

    //String something in the vault
    function storeSecret(string calldata _secret)virtual override onlyOwner {
        secret=_secret;
        emit secretAdded("Secret Added", msg.sender);
    }

    
    function getSecret() public view virtual override onlyOwner returns (string memory) {
        return secret;
    }

    function getDepositTime() external view virtual  override returns (uint256) {
        return depositTime;
    }

}