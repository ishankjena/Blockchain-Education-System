// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract Course {
    struct Assignment {
        string name;
        string ipfsLink;
    }

    struct CourseData {
        string name;
        string ipfsLink;
        address creator;
        Assignment[] assignments;
    }

    mapping(uint256 => CourseData) public courses;
    uint256 private _currentCourseId;

    event CourseCreated(uint256 indexed courseId, string name, address indexed creator);
    event AssignmentCreated(uint256 indexed courseId, uint256 indexed assignmentId, string name, string ipfsLink);

    function createCourse(string memory _name, string memory _ipfsLink, address _creator) public returns (uint256) {
        _currentCourseId++;
        uint256 courseId = _currentCourseId;
        courses[courseId] = CourseData(_name, _ipfsLink, _creator, new Assignment[](0));
        emit CourseCreated(courseId, _name, _creator);
        return courseId;
    }

    function mintAssignment(uint256 _courseId, string memory _name, string memory _ipfsLink) public {
        require(msg.sender == courses[_courseId].creator, "Only course creator can mint assignments");

        Assignment memory newAssignment = Assignment(_name, _ipfsLink);
        courses[_courseId].assignments.push(newAssignment);
        emit AssignmentCreated(_courseId, courses[_courseId].assignments.length - 1, _name, _ipfsLink);
    }
}

