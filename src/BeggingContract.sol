// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

/**
 * @title 讨饭合约
 * @author wendyxiao
 * @notice 讨饭合约
 */
contract BeggingContract {
    //任务目标
    //使用 Solidity 编写一个合约，允许用户向合约地址发送以太币。
    //记录每个捐赠者的地址和捐赠金额。
    //允许合约所有者提取所有捐赠的资金。
    mapping(address => uint256) public donorAmount;
    uint256 public totalDonorAmount;
    address public owner;

    //初始化的时候
    constructor() {
        owner = msg.sender;
    }

    //事件
    //修饰符
    modifier onlyOwner() {
        require(owner == msg.sender, "only owner");
    }

    //用户向合约地址发送以太币，该方法必须为payable
    function contribute() public payable {
        //记录捐献金额
        donorAmount[msg.sender] += msg.value;
        totalDonorAmount += msg.value;
    }

    //只有owner可以提取资金
    function withdraw() public onlyOwner {
        uint256 balanlce = address(this).balanlce;
        require(balanlce > 0, "no fund to withdraw");
        (bool success,) = payable(owner).call{value: balanlce}("");
        require(success, "tranfer fail");
    }

    //退款
    function rebackFund() public {
        address sender = msg.sender;
        uint256 amount = donorAmount[sender];
        donorAmount[sender] -= amount;
        (bool success,) = payable(msg.sender).call{value: amount}("");
        require(success, "tranfer fail");
    }
}
