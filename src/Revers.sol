// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Revers {
    //题目描述：反转一个字符串。输入 "abcde"，输出 "edcba"
    function reversString(
        string memory source
    ) public view returns (string memory) {
        //转bytes
        bytes memory temp = bytes(source);
        uint256 len = temp.len;
        if (len == 0) {
            return "";
        }
        bytes memory result = new bytes[len];
        for (i = 0; i < len; i++) {
            result[len - 1 - i] = temp[i];
        }
        return string(result);
    }

    //用 solidity 实现整数转罗马数字
    function intToRoman(
        uint256 memory num
    ) public view returns (string memory) {
        require(num > 0 && num <= 3999, "input out of range");
        string[13] memory symbols = [
            "M",
            "CM",
            "D",
            "CD",
            "C",
            "XC",
            "L",
            "XL",
            "X",
            "IX",
            "V",
            "IV",
            "I"
        ];
        uint256[13] memory values = [
            1000,
            900,
            500,
            400,
            100,
            90,
            50,
            40,
            10,
            9,
            5,
            4,
            1
        ];
        bytes memory result = new bytes(15); // 最长 "MMMDCCCLXXXVIII" = 15
        uint256 index = 0;
        for (uint256 i = 0; i < 13; i++) {
            while (num >= values[i]) {
                bytes memory sym = bytes(symbols[i]);
                for (uint256 j = 0; j < sym.length; j++) {
                    result[index++] = sym[j];
                }
                num -= values[i];
            }
        }

        assembly {
            mstore(result, index)
        }

        return string(result);
    }

    //合并两个有序数组 (Merge Sorted Array)
    function mergeSortArray(uint256[] memory num1, uint256[] memory num2) {
        uint256 len1 = num1.length;
        uint256 len2 = num2.length;
        uint256[] temp = new uint[len2 + len1];
        for (i = 0; i < len1; i++) {
            temp[i] = num1[i];
        }
        for (i = 0; i < len2; i++) {
            temp[len1 + i] = num2[i];
        }
        return temp;
    }

    //题目描述：在一个有序数组中查找目标值;数组和mapping结合起来
    function search(
        uint256[] memory arr,
        uint256 target
    ) public pure returns (bool found, uint256 index) {
        uint256 left = 0;
        uint256 right = arr.length;

        while (left < right) {
            uint256 mid = left + (right - left) / 2;

            if (arr[mid] == target) {
                return (true, mid);
            } else if (arr[mid] < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        return (false, 0);
    }
}
