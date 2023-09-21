//
//  DDayResponse.swift
//  Parting
//
//  Created by 박시현 on 2023/09/02.
//

import Foundation

// MARK: - WidgetResponse
struct WidgetResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: WidgetResult
}

// MARK: - Result
struct WidgetResult: Codable {
    let partyID: Int
    let partyName: String
    let dday: Int

    enum CodingKeys: String, CodingKey {
        case partyID = "partyId"
        case partyName, dday
    }
}
