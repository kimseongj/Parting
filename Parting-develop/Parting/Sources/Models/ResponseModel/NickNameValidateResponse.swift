//
//  NickNameValidateResponse.swift
//  Parting
//
//  Created by 박시현 on 2023/06/07.
//

import Foundation

// MARK: - BasicResponse
struct BasicResponse: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
}

