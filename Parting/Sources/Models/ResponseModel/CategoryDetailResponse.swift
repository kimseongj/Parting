//
//  CategoryDetailResponse.swift
//  Parting
//
//  Created by 박시현 on 2023/06/12.
//

import Foundation

// MARK: - CategoryDetailResponse
struct CategoryDetailResponse: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    let result: CategoryWithCategoryDetail
}

struct CategoryWithCategoryDetail: Codable {
    let categoryName: String
    let categoryDetailList: [CategoryDetail]
}

// MARK: - Result
struct CategoryDetail: Codable, Hashable {
    let categoryDetailID: Int
    let categoryDetailName: String

    enum CodingKeys: String, CodingKey {
        case categoryDetailID = "categoryDetailId"
        case categoryDetailName
    }
}

// MARK: - Result
struct CategoryDetailResult: Codable {
    let categoryDetailID: Int
    let categoryDetailName: String
    
    enum CodingKeys: String, CodingKey {
        case categoryDetailID = "categoryDetailId"
        case categoryDetailName
    }
}

class CategoryDetailResultContainisSelected {
    let categoryDetailID: Int
    let categoryDetailName: String
    var isClicked: Bool
    
    init(categoryDetailID: Int, categoryDetailName: String, isClicked: Bool = false) {
        self.categoryDetailID = categoryDetailID
        self.categoryDetailName = categoryDetailName
        self.isClicked = isClicked
    }
}

struct CategoryDetailResultContainisSelectedTest {
    let categoryDetailID: Int
    let categoryDetailName: String
    var isClicked: Bool
    
    init(categoryDetailID: Int, categoryDetailName: String, isClicked: Bool = false) {
        self.categoryDetailID = categoryDetailID
        self.categoryDetailName = categoryDetailName
        self.isClicked = isClicked
    }
}
