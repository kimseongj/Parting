//
//  DetailPartyInfoResponse.swift
//  Parting
//
//  Created by 박시현 on 2023/08/30.
//

import Foundation

// MARK: - DetailPartyInfoResponse
struct DetailPartyInfoResponse: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: DetailPartyInfoResult
}

// MARK: - Result
struct DetailPartyInfoResult: Codable {
    let address: String
    let categoryImg: String
    let categoryName: [String]
    let currentPartyMemberCount: Int
    let deadLineDate: String
    let distance: Double
    let distanceUnit: String
    let hashTag: [String]
    let maxAge, maxPartyMemberCount: Int
    let memberStatus: String
    let minAge: Int
    let openChattingRoomURL: String
    let partyDescription, partyEndDateTime: String
    let partyID: Int
    let partyLatitude, partyLongitude: Double
    let partyMemberList: [PartyMemberList]
    let partyName, partyStartDateTime, status: String

    enum CodingKeys: String, CodingKey {
        case address, categoryImg, categoryName, currentPartyMemberCount, deadLineDate, distance, distanceUnit, hashTag, maxAge, maxPartyMemberCount, memberStatus, minAge, openChattingRoomURL, partyDescription, partyEndDateTime
        case partyID = "partyId"
        case partyLatitude, partyLongitude, partyMemberList, partyName, partyStartDateTime, status
    }
}

// MARK: - PartyMemberList
struct PartyMemberList: Codable {
    let profileImgURL: String
    let userID: Int
    let userName: String

    enum CodingKeys: String, CodingKey {
        case profileImgURL = "profileImgUrl"
        case userID = "userId"
        case userName
    }
}
