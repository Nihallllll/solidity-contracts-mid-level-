// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

interface IERC721 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);

    function balanceOf(address owner) external view returns (uint256);
    function ownerOf(uint256 tokenId) external view returns (address);

    function approve(address to, uint256 tokenId) external;
    function getApproved(uint256 tokenId) external view returns (address);

    function setApprovalForAll(address operator, bool approved) external;
    function isApprovedForAll(address owner, address operator) external view returns (bool);

    function transferFrom(address from, address to, uint256 tokenId) external;
    function safeTransferFrom(address from, address to, uint256 tokenId) external;
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external;
}

interface IERC721Receiver {
    function onERC721Received(address operator, address from, uint256 tokenId, bytes calldata data) external returns (bytes4);
}

contract SimpleNFT is IERC721{
     string public name ;
     string public symbol;

     constructor(string _name , string _symbol) {
       name= _name;
       symbol = _symbol;
     }

     //mappings
     
    mapping(uint256 => address) private _owners;
    mapping(address => uint256) private _balances;
    mapping(uint256 => address) private _tokenApprovals;
    mapping(address => mapping(address => bool)) private _operatorApprovals;
    mapping(uint256 => string) private _tokenURIs;

     //get the nft balance function
     function balanceOf(address owner) public  view  override returns (uint256){
       require(owner != address(0) , "Not a valid address");
       return _balances[owner] ;
     }
    
     //get the owner
     function ownerOf(uint256 tokenId) public  view  override returns (address){
       require(_owners[tokenId] != address(0),"Not a valid address");
       return _owners[tokenId];
     }
     

     //approve this address to spend this token

     function approve(address to, uint256 tokenId) public  override{
        address owner = ownerOf(tokenId);
        require(to != address(0));
        require(msg.sender == owner);
        _tokenApprovals[tokenId] = to;
     }

     //get the address of the account that has be authorized to transfer this token 

      function getApproved(uint256 tokenId) public view returns (address){
        require(_owners[tokenId] != address(0));
        return _tokenApprovals[tokenId];
      }
    
     function setApprovalForAll(address operator, bool approved) public view override {
        require(msg.sender != operator ,"No fishy ness");
        _operatorApprovals[msg.sender][operator] = approved;
     }
    

    // Checks if operator is approved to manage all NFTs owned by owner
    function isApprovedForAll(address owner, address operator) public view override returns (bool){
        require((owner & operator) != address(0));
        return _operatorApprovals[owner][operator] ;
    }
}