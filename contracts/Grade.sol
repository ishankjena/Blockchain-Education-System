// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "./StudentRegistry.sol";

contract Grader {
    struct Grade {
        address student;
        uint256 grade;
    }

    mapping(address => Grade) public grades;

    StudentRegistry public studentRegistry;

    event GradeAssigned(address indexed student, uint256 grade);

    constructor(address _studentRegistry) {
        studentRegistry = StudentRegistry(_studentRegistry);
    }

    function assignGrade(address _student, uint256 _grade) public {
        require(studentRegistry.isStudentRegistered(_student), "Student not registered");
        grades[_student] = Grade(_student, _grade);
        emit GradeAssigned(_student, _grade);
    }
}

