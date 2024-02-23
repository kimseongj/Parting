//
//  PartyTabResponse.swift
//  Parting
//
//  Created by 박시현 on 2023/10/01.
//

import Foundation

struct PartyListQuery {
    let categoryDetailId: Int?
    let categoryId: Int
    var orderCondition: String
    var pageNumber: Int
    let categoryVersionOfUser: String
    let userLat: Double
    let userLng: Double
}
