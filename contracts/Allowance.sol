pragma solidity 0.4.18;


contract Allowance {

    address owner;

    // Parents section
    struct Parent {
        address id;
        string name;
        // TODO: Add children array here so children are only associated with their parents
        // This may lead to children (addresses) being added to other parents 
        //  but the parents would have to know the child's address.
    }

    mapping (address => Parent) public parents;

    // Child section
    struct Child {
        address id;
        string name;
        uint balance;
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

    event LogAddParent(
        address indexed _parent,
        string _name
    );

    event LogAddChild(
        address indexed _child,
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

    // Getting tasks that are available
    function getAvailableTasks() public view returns (uint[]) {
        // Setup initial vars
        uint[] memory taskIDs = new uint[](taskCounter);
        uint numberOfAvailableTasks = 0;

        // Copy over the Taks IDs if the task is still available 
        //  and increment number of available takss
        for (uint i = 1; i <= taskCounter; i++) {
            if (tasks[i].completed == false) {
                taskIDs[numberOfAvailableTasks] = tasks[i].id;
                numberOfAvailableTasks++;
            }
        }

        // Create an appropriate sized array to return
        uint[] memory available = new uint[](numberOfAvailableTasks);
        for (uint j = 0; j < numberOfAvailableTasks; j++) {
            available[j] = taskIDs[j];
        }

        return available;
    }

    // Adding a parent
    function addParent(address _parent, string _name) public {
        // For now require parent to be added by owner
        require(msg.sender == owner);

        parents[_parent] = Parent(
            _parent,
            _name
        );
        LogAddParent(_parent, _name);
    }

    // Adding a parent
    function addChild(address _child, string _name) public {
        // For now require parent to be added by owner
        require(msg.sender == owner);

        children[_child] = Child(
            _child,
            _name,
            0
        );
        LogAddChild(_child, _name);
    }

    function markTaskCompleted(uint id) public {
        require(msg.sender == owner);
        tasks[id].completed = true;
    }
}