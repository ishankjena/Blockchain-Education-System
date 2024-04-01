//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract StudentRegistry {
    struct Student {
        string name;
        uint256 identity;
        uint256 age;
        string[] coursesEnrolled;
        uint256[] issuedCertificates; // IDs of certificates issued to the student
    }
    
    mapping(address => Student) public students;

    event StudentRegistered(address indexed studentAddress, string name, uint256 identity, uint256 age);
    event CertificateIssued(address indexed studentAddress, uint256 certificateId);

    ERC721 public certificateContract;

    constructor(address _certificateContract) {
        certificateContract = ERC721(_certificateContract);
    }

    function registerStudent(string memory _name, uint256 _identity, uint256 _age, string[] memory _coursesEnrolled) public {
        require(students[msg.sender].identity == 0, "Student already registered");
        
        students[msg.sender] = Student(_name, _identity, _age, _coursesEnrolled, new uint256[](0));
        emit StudentRegistered(msg.sender, _name, _identity, _age);
    }

    function issueCertificate(address _studentAddress, uint256 _certificateId) public {
        require(msg.sender == address(certificateContract), "Only certificate contract can issue certificates");
        students[_studentAddress].issuedCertificates.push(_certificateId);
        emit CertificateIssued(_studentAddress, _certificateId);
    }

    function getStudent(address _studentAddress) public view returns (string memory, uint256, uint256, string[] memory, uint256[] memory) {
        Student memory student = students[_studentAddress];
        return (student.name, student.identity, student.age, student.coursesEnrolled, student.issuedCertificates);
    }
}
