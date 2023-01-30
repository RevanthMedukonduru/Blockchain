// SPDX-License-Identifier:MIT
pragma solidity >=0.8.17 <=0.9.0;

contract oneChange {

    // This is the address of admin/contract creator likely to be state/central government, Only contract creator will add approved government officials
    address public admin;

    constructor() {
        admin = msg.sender;
    }

    // struct to store details of a citizen
    struct userDetails {
        string userFullName;
        uint8 userAge; // User age, it is useful in tax calculations.
        uint8 userLevel; // 1: Citizen 2: People Representative like minister(MLA, MP, Chief minister, Prime minister) 3: Government Organisation 4: Private Organisation
        uint256 userAadharNumber; // Unique Id given by government - by which till now user is recognised uniquely.
        address userPayId; // blockchain public address from where user wants to pay taxes.
        uint256 userPincode; // suburb or location where user stays.
        bytes32 userOneChangeId; // new Unique id is assigned to every citizen: Which is generated when user registers.
    }

    // struct to store tax details and salary or income details
    struct userTaxDetails {
        bytes32 userOneChangeId;
        uint256 userAnnualIncome; // annual income as per payslip
        uint256 userTotalTaxPaid; // Total tax paid till date  
        uint256 userLastPaymentYear; // Used to calculate tax user has to pay. 
        bool userPaidTax; // whether user has paid tax this year
    }

    // Used to store overall details of all citizens where key is "oneChangeId"
    mapping (bytes32 => userDetails) private populationDetails;
    mapping (bytes32 => userTaxDetails) private populationTaxDetails;

    // Used to restore/recover user oneChnageId with the help of userAadharNumber or previous government unique id.
    mapping (uint256 => bytes32) private aadharMappedToOneChangeId;

    // Used to restore/recover user oneChnageId with the help of user tax PayId.
    mapping ()
    
    

    // List of government officials who can add citizens to this project, government officials can only be appointed by admin.
    mapping (address => bool) private approvedGovernmentOfficials;

    // Modifier - Only admin or Contract creator
    modifier onlyAdmin() {
        require (msg.sender == admin, "Only admin can access this functionality.");
        _;
    }  

    // Modifier - only government officials
    modifier onlyGovtOfficials() {
        require (approvedGovernmentOfficials[msg.sender] == true, "Only government officials can call this method.");
        _;
    }

    // Function to add government officials
    function addGovernmentOfficals (address _newGovtOfficialAddress) public onlyAdmin {
        approvedGovernmentOfficials[_newGovtOfficialAddress] = true;
    }

    // Function to generate new oneChangeId
    function generateOneChangeId(uint256 _userAadharNumber) internal pure returns(bytes32){
        return keccak256(abi.encodePacked(_userAadharNumber));
    }

    // Function to add population details
    function addPopulationDetails (string calldata _userFullName, uint8 _userAge, uint8 _userLevel, uint256 _userAadharNumber, address _userPayId, uint256 _userPincode, uint256 _userAnnualIncome) public onlyGovtOfficials{
        // Generate UserOneChangeId for new user.
        bytes32 _newUserOneChangeId = generateOneChangeId(_userAadharNumber);

        // Create record of userDetails
        userDetails memory newUserDetails = userDetails({
            userFullName : _userFullName,
            userAge : _userAge,
            userLevel : _userLevel,
            userAadharNumber : _userAadharNumber,
            userPayId : _userPayId,
            userPincode : _userPincode,
            userOneChangeId : _newUserOneChangeId
        });

        // Create record of tax details
        userTaxDetails memory newUserTaxDetails = userTaxDetails({
            userOneChangeId : _newUserOneChangeId,
            userAnnualIncome : _userAnnualIncome,
            userTotalTaxPaid : 0,
            userLastPaymentYear : 0,
            userPaidTax : false
        });

        // add newUserDetails record to population data
        populationDetails[_newUserOneChangeId] = newUserDetails;

        // add newUserTaxDetails record to population Tax Details
        populationTaxDetails[_newUserOneChangeId] = newUserTaxDetails;

        // Map the user aadhar address - Previous Unique Govt Id with newly generated One Change Id.
        aadharMappedToOneChangeId[_userAadharNumber] = _newUserOneChangeId;
    }
    
    // function to retrive user OneChangeId
    function getOneChangeId(uint256 _userAadharNumber) public view returns (bytes32) {
        return (aadharMappedToOneChangeId[_userAadharNumber]);
    }

    // function to pay taxes 

}