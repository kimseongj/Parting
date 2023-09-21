//
//  UserInPartyInfoResponse.swift
//  Parting
//
//  Created by 박시현 on 2023/09/01.
//

import Foundation

// MARK: - UserInfoResponse
struct UserInfoResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: UserInfoResult
}

// MARK: - Result
struct UserInfoResult: Codable {
    let nickName: String
    let profileImgURL: String
    let sex, introduce: String

    enum CodingKeys: String, CodingKey {
        case nickName
        case profileImgURL = "profileImgUrl"
        case sex, introduce
    }
}
