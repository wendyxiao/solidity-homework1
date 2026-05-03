// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Voting {
    mapping(address => uint256) public voteCount;
    address[] public allCandidata;
    address public owner;
    event voteEvent(address indexed to, address indexed from);

    //构造函数
    constructor(address _owner) {
        require(_owner != address(0), "Invalid owner");
        owner = _owner;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner");
        _;
    }

    //一个vote函数，允许用户投票给某个候选人
    function vote(address candidateAddress) public {
        require(candidateAddress != address(0), "invali address");
        voteCount[candidateAddress] += 1;
        allCandidata.push(candidateAddress);
        emit voteEvent(candidateAddress, msg.sender);
    }

    //一个getVotes函数，返回某个候选人的得票数
    function getVotes(address candidateAddress) public view returns (uint256) {
        return voteCount[candidateAddress];
    }

    //一个resetVotes函数，重置所有候选人的得票数;
    function resetVotes() public onlyOwner {
        //删除整个mapper
        uint256 len = allCandidata.length;
        for (i = 0; i < len; i++) {
            delete voteCount[allCandidata[i]];
        }
    }
}
