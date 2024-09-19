pragma solidity >=0.4.16 <0.9.0;

contract Voting {
    // current average points
    uint public average;
    
    uint public votes;
    mapping(address => bool) public voted;

    function vote(address sender, uint points) public {
        // validations
        require(voted[sender] == false, "You've already voted");
        require(points >= 0, "You cannot give negative points");
        require(points <= 100, "You can give a maximum of 100 points");

        if(votes == 0) {
            // for the first vote, we don't calculate the average
            average = points;
        } else {
            // for all subsequent votes, we calculate the average
            average = (average + points) / 2;
        }

        // remember who has voted
        voted[sender] = true;

        // update number of votes
        votes++;
    }
}