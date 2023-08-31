// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

abstract contract Lock {
    uint256 private constant _NOT_ENTERED = 1;
    uint256 private constant _ENTERED = 2;

    uint256 private _status;

    constructor() {
        _status = _NOT_ENTERED;
    }

    modifier lock() {
        require(_status != _ENTERED, 'DONSwap: LOCKED');
        _status = _ENTERED;
        _;
        _status = _NOT_ENTERED;
    }
}
