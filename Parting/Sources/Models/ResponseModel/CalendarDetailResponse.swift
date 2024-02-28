//
//  CalendarDetailResponse.swift
//  Parting
//
//  Created by kimseongjun on 1/26/24.
//

import Foundation

// MARK: - CalendarDetailResponse
struct CalendarDetailResponse: Decodable {
    let code: Int
    let isSuccess: Bool
    let message: String
    let result: [CalendarDetailResult]
}

// MARK: - Result
struct CalendarDetailResult: Decodable {
    let day: Int
    let parties: [PartyDetailInfo]
}

// MARK: - Party
struct PartyDetailInfo: Decodable {
    let address: String
    let distance: Double
    let distanceUnit, partyName: String
}
