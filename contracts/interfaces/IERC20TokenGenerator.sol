// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '../ERC20Token.sol';

interface IERC20TokenGenerator {
    event Created(address token);
    event ChangedFeeToSetter(address feeToSetter);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);
    function allTokens(uint256) external view returns (address token);
    function allTokensLength() external view returns (uint256);
    function setFeeToSetter(address _feeToSetter) external;
    function createToken(string calldata _name, string calldata _symbol, uint256 _totalSupply) external;
}
