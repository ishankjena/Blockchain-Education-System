// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract Certificate is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIdCounter;

    struct CertificateData {
        string data;
        uint256 issueTime;
        address student;
    }

    mapping(uint256 => CertificateData) private _certificateData;

    constructor() ERC721("Certificate", "CERT") {}

    function issueCertificate(address _student, string memory _data) public {
        uint256 tokenId = _tokenIdCounter.current();
        _safeMint(_student, tokenId);
        _certificateData[tokenId] = CertificateData(_data, block.timestamp, _student);
        _tokenIdCounter.increment();
    }

    function getCertificateData(uint256 _tokenId) public view returns (string memory, uint256, address) {
        require(_exists(_tokenId), "Certificate does not exist");
        CertificateData memory data = _certificateData[_tokenId];
        return (data.data, data.issueTime, data.student);
    }
}
