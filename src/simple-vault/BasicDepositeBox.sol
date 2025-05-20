// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;
import "./BaseDepositBox.sol";
contract BasicDepositeBox is BaseDepositeBox{
   function getBoxType()external pure override returns(string){
    return "Basic Box";
   }
}