//
//  NetworkError.swift
//  Parting
//
//  Created by 박시현 on 2023/08/16.
//

import Foundation

enum PartingError: Int, Error {
    case enterYourJWT = 2001
    case notValidateJWT = 2002
    case alreadyLogoutToken = 2004
    case tokenTypeDoNotMatch = 2005
    case dataBaseError = 4000
    case userDoesNotBelongParty = 5002
    case partyHostCanDelete = 5003
    case alreadyDelete = 5007
    case success = 1000
}
