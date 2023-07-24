//
//  Response.swift
//  Parting
//
//  Created by 박시현 on 2023/03/18.
//

import Foundation

// MARK: - CategoryResponse
struct CategoryResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: CategoryResult
}

// MARK: - Result
struct CategoryResult: Codable {
    let orderEnum: [String]
    let categories: [Category]
    let categoryVersion: String
}

// MARK: - Category
struct Category: Codable {
    let categoryName: String
    let imgURL: String
    let categoryDetailList: [CategoryDetailList]
    let categoryID: String

    enum CodingKeys: String, CodingKey {
        case categoryName
        case imgURL = "imgUrl"
        case categoryDetailList
        case categoryID = "categoryId"
    }
}

// MARK: - CategoryDetailList
struct CategoryDetailList: Codable {
    let categoryDetailID: Int
    let categoryDetailName: String

    enum CodingKeys: String, CodingKey {
        case categoryDetailID = "categoryDetailId"
        case categoryDetailName
    }
}
