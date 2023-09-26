//
//  MyPageResponse.swift
//  Parting
//
//  Created by 이병현 on 2023/09/25.
//

import Foundation

// MARK: - MyPageResponse
struct MyPageResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: ResultResponse
}

struct ResultResponse: Codable {
    let birth: String
    let introduce: String
    let nickName: String
    let profileImgUrl: String
    let sex: String
    let sigunguCd: Int
}
