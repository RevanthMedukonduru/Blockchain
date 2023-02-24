// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <=0.9.0;

contract ProjectManager{
    
}

contract Project{
    // Creating Campaign structure
    struct ProjectDefinition {
        address projectOwner; // Person who has made this contract
        string projectName; // Name of the campaign.
        string projectDescription; // Description explaining - moto of this campaign.
        uint256 projectCosts; // Amount required to finish this project.
        bool projectStatus; // Whether this project is active or not/ open or closed.
    }

    // Areas or pincodes involved under this project
    uint256[] public projectAreas;

    // Total population count under these areas
    uint256 private populationCountUnderThisProject;

    // Variable to make sure an individual will vote only once.
    

}


