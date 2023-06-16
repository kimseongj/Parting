//
//  Endpoints.swift
//  Parting
//
//  Created by 박시현 on 2023/03/18.
//

import Foundation
import Alamofire

enum PartingAPI {
    case detailCategory(categoryVersion: String)
    case associatedCategory(categoryId: Int)
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
    case essentialInfo(birth: String, job: String, nickName: String, sex: String, sigunguCd: Int)
    case interest
    case modifyInfo
}

extension PartingAPI {
    var url: String? {
        switch self {
        case let .associatedCategory(categoryId):
            return  "\(BaseURL.baseURL)/categoryId/\(categoryId)/associated-category"
        case let .detailCategory(categoryVersion):
            return  "\(BaseURL.baseURL)/category-sortby/category-version/0.0.9"
        case .oauthKaKao, .oauthLogout, .isMemeber, .tokenReissue:
            return  "\(BaseURL.oauthURL)/"
        case .parties:
            return "\(BaseURL.baseURL)/parties"
        case .createParty:
            return  "\(BaseURL.partyURL)"
        case .getPartyDetail, .modifyParty, .deleteParty, .calender, .recentView, .partyMember, .partyDday:
            return  "\(BaseURL.partyURL)/calendar"
        case .region:
            return  "\(BaseURL.baseURL)/region"
        case .reportParty:
            return  "\(BaseURL.baseURL)/report/party"
        case .checkMyParty:
            return  "\(BaseURL.baseURL)/my-party"
        case .checkEnteredParty:
            return  "\(BaseURL.baseURL)/entered-party"
        case .checkMypage:
            return  "\(BaseURL.userURL)"
        case .checkNickname:
            return  "\(BaseURL.userURL)/check"
        case .essentialInfo, .interest, .modifyInfo:
            return  "\(BaseURL.userURL)/essential-information"
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .oauthKaKao, .oauthLogout, .isMemeber, .tokenReissue, .region, .reportParty, .checkEnteredParty, .partyDday, .checkMypage, .interest, .modifyInfo :
            return [
                "authorization": "Bearer eyJ0eXBlIjoiYWNjZXNzIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VySWQiOjEsImlhdCI6MTY4NTE2MTU1MSwiZXhwIjoxNjg3NTgwNzUxfQ.ZkMQ9PA2KAodD7AXyDClJEq-P47p3ucqbQ2G5c7aH8M"
            ]
        case .parties, .associatedCategory, .createParty, .getPartyDetail, .modifyParty, .deleteParty, .calender, .recentView, .checkMyParty, .partyMember, .detailCategory, .checkNickname, .essentialInfo:
            return [
                "authorization": "Bearer eyJ0eXBlIjoiYWNjZXNzIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VySWQiOjEsImlhdCI6MTY4NTE2MTU1MSwiZXhwIjoxNjg3NTgwNzUxfQ.ZkMQ9PA2KAodD7AXyDClJEq-P47p3ucqbQ2G5c7aH8M",
                    "Content-Type": "application/json;charset=UTF-8"
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
        case let .essentialInfo(birth, job, nickName, sex, sigunguCd):
            return [
                "birth": birth,
                "job": job,
                "nickName": nickName,
                "sex": sex,
                "sigunguCd": sigunguCd
            ]
        default:
            return ["":""]
        }
    }
}
