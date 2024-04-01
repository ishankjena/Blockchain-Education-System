//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Certificate is ERC721 {
    struct CertificateData {
        uint256 timeOfIssue;
        string data;
        address student;
    }

    mapping(uint256 => CertificateData) public certificateData;
    uint256 private _currentTokenId;

    constructor(string memory name, string memory symbol) ERC721(name, symbol) {
        _currentTokenId = 0;
    }

    function issueCertificate(address _student, string memory _certificateData) public {
        _currentTokenId++;
        uint256 tokenId = _currentTokenId;
        certificateData[tokenId] = CertificateData(block.timestamp, _certificateData, _student);
        _safeMint(_student, tokenId);
    }

    function getCertificate(uint256 tokenId) public view returns (uint256, string memory, address) {
        CertificateData memory data = certificateData[tokenId];
        return (data.timeOfIssue, data.data, data.student);
    }
}
