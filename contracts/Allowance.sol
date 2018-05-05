pragma solidity 0.4.23;

contract Allowance {
    address parent;
    address child;

    uint256 tokens;

    // Steps:
    //  1) Create a pool of tokens for the parent to dole out
    //  2) Allow parent to create a  list of tasks that child may complete to earn token
    //   a) Create single tasks
    //   b) creating recurring tasks
    //  3) Allow child to mark a task as completed
    //  4) A parent may verify that a task is completed
    //  5) Upon agreed-upon completion, token is transferred to child's account
    //  6) Child may redeem tokens to earn cash, screen time, etc.
    //  7) Upon redemption, tokens are sent back to parent

    constructor(uint256 _tokens) public {
        parent = msg.sender;
        tokens = _tokens;
    }
}