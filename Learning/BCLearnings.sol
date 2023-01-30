// SPDX-License-Identifier:MIT

pragma solidity ^0.8.13; 

contract MyFirstContract {
    /*
    string public hey ;
    uint256 public no;
    
    // datatypes
    bool public v1; // def false
    bool public v2 = true;

    //uint means for unisgned integer means non negative
    uint8 public u8 = 1; //lowest range: 0 - (pow(2,8) -1)
    uint16 public u16 = 2; // 0 - pow(2, 16)-1)
    uint256 public u256 = 456; // 0 - pow(2, 256)-1
    uint public u =123; // def takes uint 256

    // negative numbers allow from int type
    // int128 range lies from pow(-2, 127) to pow (2, 127)
    // int256 range lies from pow(-2, 255) to pow (2, 255)
    int8 public i8 = -1;
    int public i123 = 456;
    int public i = -1234;

    // finding min and max operator;
    int public minInt = type(int).min;
    int public maxInt = type(int).max;

    
    constructor (string memory _hey, uint256 _no){
        hey = _hey;
        no = _no;
    }
    

    // Arrays
    // byte is more efficient than string : saves gas fee
    // -- fixed sized byte arr
    // -- dynamic sized bytes arrays
    // so when we define byte in smart contract it represents dynamic bytes

    bytes1 public a;
    bytes1 public b;

    bytes1 public a1 = 0xb5;
    bytes1 public b1 = 0x56;

    address public x1;
    address public x2 = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    // no concept of null and undefined in solidity
    // default values
    bool public def1; // def val false
    uint256 public def2; // 0
    int public def3; // 0
    address public def4; // 0x000000

    

    // Function types
    // Declaring function
    // non declaring function
    
    /*
    function function_name(param list) scope returns (return_type){
        ....
    }
    

    uint256 public fun1 ;

    // get data with the help of function
    // view: A function which doesnt modifiy any data on blockchain - just to look at the state variable
    /*function getInfo() public view returns (uint256){
        return fun1;
    }
    
    function upddata(uint256 _fun1) public {
        fun1 = _fun1;
    } 

    function getUint(uint256 _a, uint256 _b) public returns (uint256){
        fun1 = _a+_b;
        return fun1;
    }

    string public val = "hey Rev";
    bytes public val2 = "hey Rev"; // saves gas fees

    uint256[] public mynumber;

    function addNumber(uint256 _a) public{
        mynumber.push(_a);
    }

    function returnNum () public view returns (uint256[] memory){return mynumber;}
    

    uint256 public mynumber;

    // pure: Pure functions ensure that they not read or modify the state
    function local() public pure returns (uint256) {
        // Variables defined in local are not stored on blockchain. So we can inf number of local variables
        // stored in memory

        uint256 i = 345;
        return i;
    }
    

    // Global Variables
    address public owner;
    address public Myblockhash;
    uint256 public difficulty;
    uint256 public gasLimit;
    uint256 public number;
    uint256 public timestamp;
    uint256 public value;
    uint256 public nowOn;
    address public origin;
    uint256 public gasPrice;
    bytes public callData;
    bytes4 public Firstfour;

    constructor(){
        owner = msg.sender;
        Myblockhash = block.coinbase; 
        difficulty = block.difficulty;
        gasLimit = block.gaslimit;
        number = block.number;
        timestamp = block.timestamp;
        gasPrice = tx.gasprice;
        origin = tx.origin;
        callData = msg.data;
        Firstfour = msg.sig;
    }

    

    // VIEW Keyword
    uint256 n1 = 1;
    uint256 n2 = 2;


    // Using view to check state var
    // Used to see what value is there in state variables

    function getResults() public view returns(uint256, uint256){
        return (n1, n2);
    }

    function getResults1() public returns(uint256 product, uint256 sum){
        n1+=5;
        n2+=5;

        product = n1*n2;
        sum = n1+n2;
        return (product, sum);
    }
    
    

    // PURE Keyword

    uint256 n1 = 4;
    uint256 n2 = 5;

    // we cannot use pure keyword for this function to view state variables data

    function getData() public view returns(uint256, uint256){
        return (n1, n2);
    }

    // but we can use for performing some operations like below without touching state var
    // we cannot use pure keyword when we want to use state variables
    function getData1() public pure returns(uint256, uint256){
        uint256 x = 1;
        uint256 y = 10;

        x+=5;
        y+=6;
        return (x, y);
    }



    // EVENT TICKET
    uint256 numberOfTicket;
    uint256 ticketPrice;
    uint256 totalAmount;
    uint256 startAt;
    uint256 endAt;
    uint256 timeRange;
    string message = "Buy your first ticket";

    constructor (uint256 _ticketPrice){
        ticketPrice = _ticketPrice;
        startAt = block.timestamp;
        endAt = block.timestamp + 7 days;
        timeRange = (endAt - startAt)/60/60/24;
    }

    function buyTicket(uint256 _value) public returns (uint256 ticketId){
        numberOfTicket++;
        totalAmount += _value;
        ticketId = numberOfTicket;
    }

    function getAmount() public view returns(uint256){
        return (totalAmount);
    }


    // WHY CONSTANTS? Constants are variables whose value doesnt change through out the program

    // 130242 transaction/execution gas cost
    // address public addresVar = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    // 104187 gas
    address public constant ADDRESS_VAR = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    // 118027 costs for Constants + View;
    // 118027 Costs for Constants + pure;
    function getConstant() public pure returns(address){
        return ADDRESS_VAR;
    } 



    // IFELSE 

    uint256 public x = 5;
    uint256 public y = 6;
    
    function get(uint256 _num) public pure returns (string memory){
        if (_num == 5){return "Hey its 5";}
        else{ return "not 5";}
    }

    // using terinary operator

    function shortHand(uint256 x) public pure returns (string memory) {
        return ()
    }


    // WHILE LOOP
    uint256[] data;
    uint8 x = 0;

    function loop () public returns (uint256[] memory){
        
        while(x<5){
            data.push(x);
            x++;
        }
        
        return data;
    }
    

    // DO WHILE loop
     
    // do (){
        // block of statement to be executed
    // } while(condition)

    uint256[] data;
    uint8 x = 0;

    function loop () public returns (uint256[] memory){
        do {
            x++;
            data.push(x);
        }while(x<5);

        return data;
    }
    

    // For loop 

    uint256[] data;
    uint8 x = 0;

    function forLoop() public returns (uint256[] memory){
        // syntax
        // for(intitialisation; test condition; iteration increment)
        for(uint256 i =0; i< 5; i++){
            data.push(i);
        }
        return data;
    }

    

    // Error Handling
    // -- Require statement

    function checkInput(uint256 _input) public pure returns(string memory){
        require(_input>=0, "invalid uint8");
        require(_input<=255, "invalid uint8");

        return "valid uint8";
    }

    

    // -- Assert Error
    // Note: In assert we will only have condition, no message statement can be added.

    bool public result;

    function checkOverFlow (uint256 _num1, uint256 _num2) public {
        uint256 s = _num1+_num2;

        assert(s <= 255);
        result = true;
    }

    // Revert handler
    // In revert we dont do any checking conditions/ anything we will just pass error messages.

    function checkOverFlow1(uint x, uint y) public pure returns(string memory, uint){
        uint sum = x+y;

        if(sum < 0 || sum>255){ revert ("ovf exists");}
        else{return ("No ovf", sum);}
    }

    

    // FUNCTION MODIFIERS: The code that can be run before and after function calls
    // Uses: For restrictions, Valdiations, Gaurd against reentrancy attack

    address public owner;
    uint256 x = 10;
    bool public locked;

    constructor (){
        owner = msg.sender;
    }

    modifier onlyOwner(){
        require(msg.sender == owner, "Only owner can call this");
        _;
    }

    function getValue() public onlyOwner returns (uint256){
        return x;
    }

    modifier noReentrancy(){

    }
    

    // In a nutshell, public and external differs in terms of gas usage. The former use more than the latter 
    // when used with large arrays of data. This is due to the fact that Solidity copies arguments to memory on a 
    // public function while external read from calldata which is cheaper than memory allocation.

    struct todo{
        string t;
        bool c;
    }

    todo[] public arr;

    //https://ethereum.stackexchange.com/questions/74442/when-should-i-use-calldata-and-when-should-i-use-memory
    function create(string calldata _txt) public{
        // Type 1
        arr.push(todo(_txt, false));

        //t 2
        arr.push(todo({t: _txt, c: false}));

        //t3
        todo memory temp;
        temp.t = _txt;
        arr.push(temp);
    }
    

    // Data Location;
    // 1: Storage: Stored on blockchain 
    // 2: Call Data: that datatype is an argument
    // 3: Memory: exists in functions 

    uint[] public arr;
    mapping (uint => address) mp;
    struct mystruct{
        uint foo;
    }
    mapping (uint => mystruct) ss;

    function f() public{

    }

    

    //payable
    address payable public owner;
    address public contractAddress;

    // payable. constructor can recieve ether
    constructor() payable{
        owner = payable(msg.sender);
    }

    //function to deposit the ether into this contract, call this function along with some ether 
    // the balance of this contract will be automatically updated.

    function deposit() public payable{}

    function notpayable() public{}

    // function to withdraw all ether from this contract
    function withdraw() public {
        // get the amount of ether stored in this contract
        uint amount = address(this).balance;
        contractAddress = address(this);

        // send all ether to owner
        // owner can recieve ether since the address of owner is payable
        (bool success, ) = owner.call{value: amount}("");
        require(success, "Failed");
    }

    // function to transfer ether from this contract to address from input
    function transfer(address payable _to, uint _amount) public{
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Failed to send ether");
    }

    

    // Payable methods:
    // Transfer
    // send
    // call
    // which func will cget called, fallback() or recieve() ?
    // send Ether-> msg.data is empty? -> yes -> recieve exists?
    //.                                -> no  -> fallback()

    // function to recieve ether. msg.data must be empty
    receive() external payable {}

    // Fallack function is called wjhne msg.data is not empty
    fallback() external payable {}

    // function to get balacne
    function getBalance() public view returns (uint){
        return address(this).balance;
    }
}

contract sendEther{
    function sendViaTransfer(address payable _to) public payable{
        // this func is no longer recommended for sending ether
        _to.transfer(msg.value);
    }

    function sendViaSend(address payable _to) public payable{
        // sendn returns a bool value indidcatiing sucess or failure.
        // this function is no recommended for sending ether

        bool sent = _to.send(msg.value);
        require(sent, "failed to send ether");
    }

    function sendViaCall(address payable _to) public payable{
        // call returns a bool value indicating sucess or failure
        // this is the current recommended method to use

        (bool sent, bytes memory data) = _to.call{value: msg.value}("");
        require(sent, "failed");
    }
}

    // fallback via transfer or send method the min gas needs to pay is 2300
    event Log(string func, uint gas);

    // fallback function must be declared as external 
    fallback() external payable{
        // send/transfer (forwards 2300 gas to this fallback function)
        // call (forwards all of the gas)
        emit Log("fallback", gasleft());
    }

    //recieve is a variant of fallback that is triggered when msg.data is empty
    receive() external payable {
        emit Log("recieve", gasleft());
    }

    // Helper function to cbheck the balance of this contract
    function getBalance() public view returns (uint){
        return address(this).balance;
    }

}

contract sendToFallback{
    function transferToFalllback(address payable _to) public payable{
        _to.transfer(msg.value);
    }

    function callFallback(address payable _to) public payable {
        (bool sent, ) = _to.call{value: msg.value}("");
        require(sent, "Failed to send ether");
    }
}

    // Delegate call: Its a low level function and that function is similar to a call, which we use to transfer fund from a to account b
    // Note: Storage layout must be the same aS contract A
    uint public num;
    address public sender;
    uint public value;

    function setVars(uint _num) public payable {
        num = _num;
        sender = msg.sender;
        value = msg.value;
    }
}

contract A {
    uint public num;
    address public sender;
    uint public value;

    function setVars (address _contract, uint _num) public payable{
        // A's storage is set B is not modified
        (bool sucess, bytes memory data) = _contract.delegatecall(abi.encodeWithSignature("setVars(uint256)", _num));
    }
}

*/

    // Keccak256 
    function hash(string memory _txt, uint _num, address _add) public pure returns (bytes32){
        return keccak256(abi.encodePacked(_txt, _num, _add));
    }

    // Example of Hash collsion
    // Hash collision can occur when you pass more than one dynamic data type 
    // to abi.encodePacked. In such case, you should use abi.encode instead

    function collision (string memory _t, string memory _at) public pure returns(bytes32){
        // encodePacked(AAA, BBB) -> AAABBB
        // encodePacked(AA, ABBB) -> AAABBB
        return keccak256 (abi.encodePacked(_t,_at));
    }
}

// Event creared: when property is sold
// event PropertySold(uint256 propertyId);

// When event occured call event: emit the property sold event
// emit PropertySold(_propertyId);
