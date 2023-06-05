//
//  Response.swift
//  Parting
//
//  Created by 박시현 on 2023/03/18.
//

import Foundation

// MARK: - Welcome
struct CategoryData: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: Result
}

// MARK: - Result
struct Result: Codable {
    let orderEnum: [String]
    let categories: [Category]
    let categoryVersion: String
}

// MARK: - Category
struct Category: Codable {
    let categoryID: Int
    let categoryName: String
    let imgURL: String
    let categoryDetail: [CategoryDetail]

    enum CodingKeys: String, CodingKey {
        case categoryID = "categoryId"
        case categoryName = "categoryName"
        case imgURL = "imgUrl"
        case categoryDetail = "categoryDetail"
    }
}

// MARK: - CategoryDetail
struct CategoryDetail: Codable {
    let categoryDetailID: Int
    let categoryDetailName: String

    enum CodingKeys: String, CodingKey {
        case categoryDetailID = "categoryDetailId"
        case categoryDetailName = "categoryDetailName"
    }
}
