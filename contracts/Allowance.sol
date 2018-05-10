pragma solidity 0.4.18;


contract Allowance {

    address owner;

    // Parents section
    struct Parent {
        address id;
        string name;
    }

    mapping (address => Parent) public parents;

    // Child section
    struct Child {
        address id;
        string name;
    }

    mapping (address => Child) public children;

    // Task section
    struct Task {
        uint id;
        address parent;
        uint reward;
        string name;
        string description;
        bool completed;
        bool approved;
    }

    mapping (uint => Task) public tasks;
    uint public taskCounter;

    uint256 public maxTokens;

    // Constructor
    function Allowance() public {
        owner = msg.sender;
        maxTokens = 128;
    }

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
    // Events
    event LogAddTask(
        uint indexed _id,
        address indexed _parent,
        uint _reward,
        string _name
    );

    // Create a new task
    function addTask(uint _reward, string _name, string _description) public {
        taskCounter++;

        // TODO: Need to require that the msg.sender is a parent
        require(owner == msg.sender);

        tasks[taskCounter] = Task(
            taskCounter,    // ID
            msg.sender,     // Parent
            _reward,        // Reward
            _name,          // Name
            _description,   // Description
            false,          // Completed
            false           // Approved
        );

        LogAddTask(taskCounter, msg.sender, _reward, _name);
    }

    // Get number of tasks
    function getNumberOfTasks() public view returns (uint) {
        return taskCounter;
    }

    // Add a new parent -- second, third etc
    // First parent should come from contract creations / msg.sender in constructor
    // function addParent(address _parent) public {
    //     parent = _parent;
    // }

    // Add a new child
    // function addChild(address _child) public {
    //     child = _child;
    // }

    // function markTaskCompleted() public {
    //     taskCompleted = true;
    // }
}