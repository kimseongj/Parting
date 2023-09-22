//
//  PartyListResponse.swift
//  Parting
//
//  Created by 김민규 on 2023/07/22.
//

import Foundation

// MARK: - PartyListResponse
struct PartyListResponse: Codable {
	let isSuccess: Bool
	let code: Int
	let message: String
	let result: PartyListResult
}

// MARK: - Result
struct PartyListResult: Codable {
	let partyInfos: [PartyInfo]
	let partySize: Int
}


// MARK: - PartyInfo
struct PartyInfo: Codable {
	let partyId: Int // Match the key with lowercase "d"
	let partyName, address: String
	let distance: Double
	let distanceUnit: String
	let currentPartyMemberCount, maxPartyMemberCount: Int
//	let partyTimeStr: String
    let partyStartTime: String
    let partyEndTime: String
	let hashTagNameList: [String]
	let status: String
	let categoryImg: String

	enum CodingKeys: String, CodingKey {
		case partyId // Use lowercase "d" to match the JSON key
		case partyName, address, distance, distanceUnit, currentPartyMemberCount, maxPartyMemberCount, partyStartTime, partyEndTime, hashTagNameList, status, categoryImg
	}
}