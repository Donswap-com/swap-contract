// SPDX-License-Identifier: GPL
pragma solidity ^0.8.4;

interface IDONSwapCallee {
    function donswapCall(address sender, uint256 amount0, uint256 amount1, bytes calldata data) external;
}
