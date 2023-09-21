//
//  PartyIMadeResponse.swift
//  Parting
//
//  Created by 박시현 on 2023/08/15.
//

import Foundation

import Foundation

// MARK: - CheckMyPartyResponse
struct CheckMyPartyResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: partyResponse
}

// MARK: - Result
struct partyResponse: Codable {
    let partyInfos: [PartyInfoResponse]
    let partySize: Int
}

// MARK: - PartyInfo
struct PartyInfoResponse: Codable {
    let partyID: Int
    let partyName: String
    let description: String
    let address: String
    let distance: Double
    let distanceUnit: String
    let currentPartyMemberCount, maxPartyMemberCount: Int
    let partyStartTime: String
    let partyEndTime: String
    let hashTagNameList: [String]
    let status: Status
    let categoryImg: String

    enum CodingKeys: String, CodingKey {
        case partyID = "partyId"
        case partyName, address, description, distance, distanceUnit, currentPartyMemberCount, maxPartyMemberCount, hashTagNameList, status, categoryImg, partyStartTime, partyEndTime
    }
}

enum Status: String, Codable {
    case blocked = "BLOCKED"
    case inactive = "INACTIVE"
    case active = "ACTIVE"
    case deleted = "DELETED"
    case end_recruit = "END_RECRUIT"
    case recruit = "RECRUIT"
}
