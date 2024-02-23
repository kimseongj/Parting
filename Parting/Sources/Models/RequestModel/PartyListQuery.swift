//
//  PartyTabResponse.swift
//  Parting
//
//  Created by kimseongjun on 2024/02/23.
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
