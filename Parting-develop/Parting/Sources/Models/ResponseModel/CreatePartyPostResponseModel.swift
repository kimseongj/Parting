//
//  CreatePartyPostModel.swift
//  Parting
//
//  Created by 박시현 on 2023/08/08.
//

import Foundation

struct CreatePartyPostResponseModel: Codable {
    let code: Int
    let isSuccess: Bool
    let message: String
}
