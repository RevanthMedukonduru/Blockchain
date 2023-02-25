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
        uint256 projectCosts; // Amount required to finish this project.
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
            projectCosts : _projectCosts,
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


}

