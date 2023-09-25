//
//  AroundPartyResponse.swift
//  Parting
//
//  Created by 박시현 on 2023/09/25.
//

import Foundation

// MARK: - AroundPartyResponse
struct AroundPartyResponse: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: AroundPartyResult
}

// MARK: - Result
struct AroundPartyResult: Codable {
    let partyInfoOnMapList: [PartyInfoOnMapList]
}

// MARK: - PartyInfoOnMapList
struct PartyInfoOnMapList: Codable {
    let categoryID, partyID: Int
    let partyLatitude, partyLongitude: Double
    let partyName: String

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case partyID = "partyId"
        case partyLatitude, partyLongitude, partyName
    }
}
