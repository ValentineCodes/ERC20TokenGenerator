// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './interfaces/IERC20TokenGenerator.sol';
import './ERC20Token.sol';

contract ERC20TokenGenerator  {
    address public feeTo;
    address public feeToSetter;
    address[] public allTokens;

    mapping(string => bool) public allTokenNames;
    mapping(string => bool) public allTokenSymbols;
    mapping(string => address) public nameToAddress;

    event Created(address token);
    event ChangedFeeToSetter(address feeToSetter);

    constructor() {
        feeToSetter = msg.sender;
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }

    function allTokensLength() external view returns (uint256) {
        return allTokens.length;
    }

    function setFeeToSetter(address _feeToSetter) external {
        require(msg.sender == feeToSetter, "Unauthorized Fee To Setter");
        feeToSetter = _feeToSetter;

        emit ChangedFeeToSetter(_feeToSetter);
    }

    function createToken(string calldata _name, string calldata _symbol, uint256 _totalSupply) external {
        // Validate inputs
        bytes memory tempName = bytes(_name);
        bytes memory tempSymbol = bytes(_symbol);
        require(tempName.length > 0, "Name cannot be empty");
        require(tempSymbol.length > 0, "Symbol cannot be empty");
        require(_totalSupply > 0, "Invalid total supply");

        // Check that name and symbols do not exist
        require(!allTokenNames[_name], "Token name already exists");
        require(!allTokenSymbols[_symbol], "Token symbol already exists");

        // Create token contract
        ERC20Token token = new ERC20Token();
        // bytes memory bytecode = type(ERC20Token).creationCode;
        // bytes32 salt = keccak256(abi.encodePacked(_name, _symbol, _totalSupply));
        // assembly {
        //     token := create2(0, add(bytecode, 32), mload(bytecode), salt) 
        // }

        // Initialize contract with token params
        token.initialize(_name, _symbol, _totalSupply);

        // store token params
        allTokens.push(address(token));
        nameToAddress[_name] = address(token);
        allTokenNames[_name] = true;
        allTokenSymbols[_symbol] = true;
        

        emit Created(address(token));
    }
}