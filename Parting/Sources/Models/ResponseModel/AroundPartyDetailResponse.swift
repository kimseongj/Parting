//
//  AroundPartyDetailResponse.swift
//  Parting
//
//  Created by 박시현 on 2023/09/25.
//

import Foundation

// MARK: - AroundPartyDetailResponse
struct AroundPartyDetailResponse: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: AroundPartyDetailResult
}

// MARK: - Result
struct AroundPartyDetailResult: Codable {
    let partyInfos: [MarkerPartyInfo]
}

// MARK: - PartyInfo
struct MarkerPartyInfo: Codable {
    let address, categoryImg: String
    let currentPartyMemberCount: Int
    let description: String
    let distance: Double
    let distanceUnit: String
    let hashTagNameList: [String]
    let maxPartyMemberCount: Int
    let partyEndTime: String
    let partyID: Int
    let partyName, partyStartTime, status: String

    enum CodingKeys: String, CodingKey {
        case address, categoryImg, currentPartyMemberCount, description, distance, distanceUnit, hashTagNameList, maxPartyMemberCount, partyEndTime
        case partyID = "partyId"
        case partyName, partyStartTime, status
    }
}
