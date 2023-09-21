//
//  CalendarResponse.swift
//  Parting
//
//  Created by 박시현 on 2023/09/02.
//

import Foundation

// MARK: - CalendarResponse
struct CalendarResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: [Int]
}

