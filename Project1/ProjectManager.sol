// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <=0.9.0;
import "./oneChange.sol";

contract ProjectManager{
    
}

contract Project{
    // Creating Campaign structure
    struct ProposalDetails {
        address projectOwner; // Person who has made this contract
        string projectName; // Name of the campaign.
        string projectDescription; // Description explaining - moto of this campaign.
        uint256 estimatedProjectPrice; // Amount required to finish this project as per govt budget - So this stays as base price what govt wants to offer.
        string companyName; // Company which is doing this project. 
        address companyPayId; // Company's Public address to which payment is sent.
        uint256 finalProjectPrice; // Finalised price for this tender.
        uint8 projectStatus; // 0 - Project initiated; 1 - got approval from majority of voters; 2 - organisations finalised the tender and contract closed.
    }

    // Defined a variavle of type ProjectDefinition
    ProposalDetails private proposalDetails;

    // Areas or pincodes involved under this project
    uint256[] public projectAreas;

    // Total population count under these areas
    uint256 private populationCountUnderThisProject;

    // Variable to make sure an individual will vote only once.
    mapping(address => bool) private hasVoted;
    uint256 public voterCount;

    // project address - oneChange
    address private oneChangeContractAddress;

    // constructor defining the initial variables required for this contract
    constructor(address _oneChangeContractAddress, address _projectOwner, string memory _projectName, string memory _projectDescription, uint256 _projectCosts, uint256[] memory _projectAreas) {
        proposalDetails = ProposalDetails ({
            projectOwner : _projectOwner,
            projectName : _projectName,
            projectDescription : _projectDescription,
            estimatedProjectPrice : _projectCosts,
            companyName: "",
            companyPayId: address(0),
            finalProjectPrice: 0,
            projectStatus : 0
        });
        projectAreas = _projectAreas;
        oneChangeContractAddress = _oneChangeContractAddress;
    }

    // getting population census from given pincodes
    function getPopulationCountUnderThisProject() internal {
        oneChange oneChangeTemp = oneChange(oneChangeContractAddress); 
        for (uint i = 0; i<projectAreas.length; i++){
            populationCountUnderThisProject += oneChangeTemp.getPopulationCensusByPincode(projectAreas[i]);
        }
    }

    // getting approval from voters 
    function grantProjectApproval() public {
        // Verifiying whether they have paid tax or not
        oneChange oneChangeTemp = oneChange(oneChangeContractAddress);
        require (oneChangeTemp.getUserTaxPayStatus(msg.sender) == true, "Tax payment is outstanding and must be paid before proceeding");

        // verifying whether user has already given approval or not
        require (hasVoted[msg.sender] == false, "Approver has already casted their vote.");

        // If approver passes above 2 criterias, then approver can cast their vote
        hasVoted[msg.sender] = true;
        voterCount++;

        // Checking whether current project got majority of votes or not
        if (voterCount >= (populationCountUnderThisProject/2)) {
            proposalDetails.projectStatus = 1; // Means got majority of votes 
        }
    }

    // function for Organisations to submit their tender price
    function submitTenderPrice(uint256 _proposedPrice) public {
        // Tender should be only visible if it got approved by majority of the people
        require (proposalDetails.projectStatus == 1, "This tender is not yet opened for bidding.");

        // Organisation that wants to submits tender price
        oneChange oneChangeTemp = oneChange (oneChangeContractAddress);
        uint8 temp = oneChangeTemp.getUserLevel(msg.sender);
        require(((temp == 3) || (temp == 4)), "To quote or enter tender price, you must first register as an organization");

        // Checking whether they proposed a price less than or equal to estimated costs for this project
        require( _proposedPrice <= proposalDetails.estimatedProjectPrice, "The quoted price is more than the estimated price for this project. Please revise your quote.");

        // Updating tender price - First Come First Win Tender (If its best quote)
        if (_proposedPrice < proposalDetails.finalProjectPrice || proposalDetails.finalProjectPrice == 0){
            proposalDetails.finalProjectPrice = _proposedPrice;
            proposalDetails.companyName = oneChangeTemp.getUserFullName(msg.sender);
            proposalDetails.companyPayId = msg.sender;
        }
    }

    // function to revise the estimated costs - In Case none of the organisation is happy to work for previous estimated price
    function reviseEstimatedCosts(uint256 _revisedPrice) public {
        // Caller of this function should be same as the person who deployed this contract
        require (msg.sender == proposalDetails.projectOwner, "Only the caller who deployed this contract can call this function.");

        // Update the estimated costs for this project.
        proposalDetails.estimatedProjectPrice = _revisedPrice;
    }

    // Finalise the project 
}
