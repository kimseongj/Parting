//
//  regionResponse.swift
//  Parting
//
//  Created by 박시현 on 2023/06/05.
//

import Foundation

// MARK: - Test
struct RegionData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: regionResult
}

// MARK: - Result
struct regionResult: Codable {
    let sidoInfoList: [SidoInfoList]
    let sigunguInfoList: [SigunguInfoList]
}

// MARK: - SidoInfoList
struct SidoInfoList: Codable {
    let sidoNm: String
    let sidoCD: Int

    enum CodingKeys: String, CodingKey {
        case sidoNm
        case sidoCD = "sidoCd"
    }
}

// MARK: - SigunguInfoList
struct SigunguInfoList: Codable {
    let sigunguCD: Int
    let sigunguNm: String
    let sidoCD: Int

    enum CodingKeys: String, CodingKey {
        case sigunguCD = "sigunguCd"
        case sigunguNm
        case sidoCD = "sidoCd"
    }
}
