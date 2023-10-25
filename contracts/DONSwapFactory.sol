// SPDX-License-Identifier: GPL
pragma solidity ^0.8.4;

import {IDONSwapFactory} from './interfaces/IDONSwapFactory.sol';
import {DONSwapPair} from './DONSwapPair.sol';

contract DONSwapFactory is IDONSwapFactory {
    address public override feeTo;
    address public override feeToSetter;

    mapping(address => mapping(address => address)) public override getPair;
    address[] public override allPairs;

    constructor(address _feeToSetter) {
        feeToSetter = _feeToSetter;
    }

    function allPairsLength() external view override returns (uint256) {
        return allPairs.length;
    }

    function pairCodeHash() external pure returns (bytes32) {
        return keccak256(type(DONSwapPair).creationCode);
    }

    function createPair(address tokenA, address tokenB) external override returns (address pair) {
        require(tokenA != tokenB, 'DONSwap: IDENTICAL_ADDRESSES');
        (address token0, address token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(token0 != address(0), 'DONSwap: ZERO_ADDRESS');
        require(getPair[token0][token1] == address(0), 'DONSwap: PAIR_EXISTS');
        bytes memory bytecode = type(DONSwapPair).creationCode;
        bytes32 salt = keccak256(abi.encodePacked(token0, token1));
        assembly {
            pair := create2(0, add(bytecode, 32), mload(bytecode), salt)
        }
        DONSwapPair(pair).initialize(token0, token1);
        getPair[token0][token1] = pair;
        getPair[token1][token0] = pair;
        allPairs.push(pair);
        emit PairCreated(token0, token1, pair, allPairs.length);
    }

    event SetFeeTo(address indexed user, address indexed feeTo);

    function setFeeTo(address _feeTo) external override {
        require(msg.sender == feeToSetter, 'DONSwap: FORBIDDEN');
        feeTo = _feeTo;
        emit SetFeeTo(msg.sender, _feeTo);
    }

    event SetFeeToSetter(address indexed user, address indexed feeToSetter);

    function setFeeToSetter(address _feeToSetter) external override {
        require(msg.sender == feeToSetter, 'DONSwap: FORBIDDEN');
        feeToSetter = _feeToSetter;
        emit SetFeeToSetter(msg.sender, _feeToSetter);
    }
}
