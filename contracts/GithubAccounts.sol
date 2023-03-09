// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

error InsufficientFunds(uint256 fee, uint256 bond);
error OnlyOwner(address owner);
error ConnectionNotChanged(address ethAddress, string githubUserId);

contract GithubAccounts {
  event ConnectionUpdateRequested(address ethAddress, string githubUserId);
  event ConnectionUpdateConfirmed(address ethAddress, string githubUserId);

  mapping(address => string) githubUserIdsByAddress;
  mapping(string => address) addressesByGithubUserId;

  uint256 public fee = 0.001 ether;
  uint256 public bond = 0.1 ether;
  address payable beneficiary;
  address owner;

  constructor() {
    owner = msg.sender;
  }

  function requestUpdate(string calldata githubUserId) public payable {
    if (msg.value < fee + bond) revert InsufficientFunds(fee, bond);
    if (keccak256(bytes(githubUserIdsByAddress[msg.sender])) == keccak256(bytes(githubUserId))) revert ConnectionNotChanged(msg.sender, githubUserId);
    
    beneficiary.transfer(fee);

    emit ConnectionUpdateRequested(msg.sender, githubUserId);
  }

  function confirmUpdate(address payable ethAddress, string calldata githubUserId) public {
    if (msg.sender != owner) revert OnlyOwner(owner);
    if (keccak256(bytes(githubUserIdsByAddress[ethAddress])) == keccak256(bytes(githubUserId))) revert ConnectionNotChanged(ethAddress, githubUserId);

    githubUserIdsByAddress[ethAddress] = githubUserId;
    addressesByGithubUserId[githubUserId] = ethAddress;

    ethAddress.transfer(bond);

    emit ConnectionUpdateConfirmed(ethAddress, githubUserId);
  }

  function setFee(uint256 newFee) public {
    if (msg.sender != owner) revert OnlyOwner(owner);
    
    fee = newFee;
  }

  function setBond(uint256 newBond) public {
    if (msg.sender != owner) revert OnlyOwner(owner);
    
    bond = newBond;
  }

  function setBeneficiary(address payable newBeneficiary) public {
    if (msg.sender != owner) revert OnlyOwner(owner);
    
    beneficiary = newBeneficiary;
  }
}
