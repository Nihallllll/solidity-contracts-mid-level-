// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;
import "./BaseDepositBox.sol";
contract PremiumDepositeBox is BaseDepositeBox{
    string private metadata;
   function getBoxType()external pure override returns(string){
    return "Premium Box";
   }

   function setMetaData(string calldata _metadata) onlyOwner public{
    metadata = _metadata;
   }

   function getMetaData()external view override onlyOwner returns(string){
     return metadata;
   }
}