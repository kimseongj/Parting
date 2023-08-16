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
    let description: Description
    let address: String
    let distance: Double
    let distanceUnit: DistanceUnit
    let currentPartyMemberCount, maxPartyMemberCount: Int
    let partyTimeStr: PartyTimeStr
    let hashTagNameList: [String]
    let status: Status
    let categoryImg: String

    enum CodingKeys: String, CodingKey {
        case partyID = "partyId"
        case partyName, description, address, distance, distanceUnit, currentPartyMemberCount, maxPartyMemberCount, partyTimeStr, hashTagNameList, status, categoryImg
    }
}

enum Description: String, Codable {
    case 맛집투어 = "맛집 투어!!"
}

enum DistanceUnit: String, Codable {
    case km = "km"
}

enum PartyTimeStr: String, Codable {
    case the20230805SatAM12시12시 = "2023.08.05.Sat - AM. 12시~12시"
    case the20230829TueAM12시12시 = "2023.08.29.Tue - AM. 12시~12시"
    case the20230831ThuAM12시12시 = "2023.08.31.Thu - AM. 12시~12시"
}

enum Status: String, Codable {
    case blocked = "BLOCKED"
    case inactive = "INACTIVE"
}
