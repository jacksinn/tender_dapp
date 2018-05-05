pragma solidity 0.4.18;

contract Allowance {
    address parent;
    address child;

    uint256 tokens;

    string task;

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

    // constructor(uint256 _tokens) public {
    //     parent = msg.sender;
    //     tokens = _tokens;
    // }

    // Allow users to set a finite amount of tokens
    // Basically how much the parents are willing to provide each week
    function createAllowanceTokens(uint256 _tokens) private {
        if(parent == msg.sender){
            tokens = _tokens;
        }
    }

    // Create a new task
    function addTask(string _task) public {
        task = _task;
    }

    // Add a new parent -- second, third etc
    // First parent should come from contract creations / msg.sender in constructor
    function addParent(address _parent) public {
        parent = _parent;
    }

    // Add a new child
    function addChild(address _child) public {
        child = _child;
    }

    // TODO: Allow multiple parents
    // TODO: Allow multiple children
    // TODO: Allow sign-off by 1 to n parents
}