//
//  Endpoints.swift
//  Parting
//
//  Created by 박시현 on 2023/03/18.
//

import Foundation
import Alamofire

enum PartingAPI {
    case detailCategory
    case oauthKaKao
    case oauthLogout
    case isMemeber
    case tokenReissue
    case parties(categoryDetailId: Int, orderCondition1: String, orderCondition2: String, pageNumber: Int, categoryVersion: String)
    case createParty
    case getPartyDetail(partyId: Int)
    case modifyParty(partyId: Int)
    case deleteParty(partyId: Int)
    case calender(month: Int, year: Int)
    case recentView(partyIdStr: String)
    case region
    case reportParty
    case checkMyParty(pageNumber: Int)
    case partyMember(partyId: Int, userId: Int)
    case checkEnteredParty
    case partyDday
    case checkMypage
    case checkNickname(nickName: String)
    case essentialInfo
    case interest
    case modifyInfo
}

extension PartingAPI {
    var url: URL? {
        switch self {
        case .detailCategory:
            return URL(string: "\(BaseURL.baseURL)/category-sortby")
        case .oauthKaKao, .oauthLogout, .isMemeber, .tokenReissue:
            return URL(string: "\(BaseURL.oauthURL)/")
        case .parties:
            return URL(string: "\(BaseURL.baseURL)/parties")
        case .createParty:
            return URL(string: "\(BaseURL.partyURL)")
        case .getPartyDetail, .modifyParty, .deleteParty, .calender, .recentView, .partyMember, .partyDday:
            return URL(string: "\(BaseURL.partyURL)/calendar")
        case .region:
            return URL(string: "\(BaseURL.baseURL)/region")
        case .reportParty:
            return URL(string: "\(BaseURL.baseURL)/report/party")
        case .checkMyParty:
            return URL(string: "\(BaseURL.baseURL)/my-party")
        case .checkEnteredParty:
            return URL(string: "\(BaseURL.baseURL)/entered-party")
        case .checkMypage:
            return URL(string: "\(BaseURL.userURL)")
        case .checkNickname, .essentialInfo, .interest, .modifyInfo:
            return URL(string: "\(BaseURL.userURL)/")
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .detailCategory, .oauthKaKao, .oauthLogout, .isMemeber, .tokenReissue, .region, .reportParty, .checkEnteredParty, .partyDday, .checkMypage, .essentialInfo, .interest, .modifyInfo :
            return [
                "authorization": "Bearer eyJ0eXBlIjoiYWNjZXNzIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VySWQiOjEsImlhdCI6MTY4MTU1MDk2MCwiZXhwIjoxNjgzOTcwMTYwfQ.p0ZDKKUVoydIpWiUbSsiM2qnzrfdGe1vX2wxlXKICC0"
            ]
        case .parties, .createParty, .getPartyDetail, .modifyParty, .deleteParty, .calender, .recentView, .checkMyParty, .partyMember, .checkNickname:
            return [
                "authorization": "Bearer eyJ0eXBlIjoiYWNjZXNzIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VySWQiOjEsImlhdCI6MTY4MTU1MDk2MCwiZXhwIjoxNjgzOTcwMTYwfQ.p0ZDKKUVoydIpWiUbSsiM2qnzrfdGe1vX2wxlXKICC0",
                    "Content-Type" : "application/json;charset=UTF-8"
            ]
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case let .parties(categoryDetailId, orderCondition1, orderCondition2, pageNumber, categoryVersion):
            return [
                "categoryDetailId": categoryDetailId,
                "orderCondition1": orderCondition1,
                "orderCondition2": orderCondition2,
                "pageNumber": pageNumber,
                "categoryVersion": categoryVersion
            ]
        case let .getPartyDetail(partyId), let .modifyParty(partyId), let .deleteParty(partyId):
            return [
                "partyId": partyId
            ]
        case let .calender(month, year):
            return [
                "month": month,
                "year": year
            ]
        case let .recentView(partyIdStr):
            return [
                "partyIdStr": partyIdStr
            ]
        case let .checkMyParty(pageNumber):
            return [
                "pageNumber": pageNumber
            ]
        case let .partyMember(partyId, userId):
            return [
                "partyId": partyId,
                "userId": userId
            ]
        case let .checkNickname(nickName):
            return [
                "nickName": nickName
            ]
        default:
            return ["":""]
        }
    }
}
