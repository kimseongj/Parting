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
    case parties(params: PartyListParams)
    case createParty(address: String, capacity: Int, categoryDetailIdList: [Int], categoryId: Int, hashTagNameList: [String], maxAge: Int, minAge: Int, openChattingRoomURL: String, partyDescription: String, partyEndDateTime: String, partyLatitude: Double, partyLongitude: Double, partyName: String, partyStartDateTime: String, storeName: String)
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
    struct PartyListParams {
        let categoryId: Int
        let categoryDetailId: Int
        let orderCondition1: String
        let orderCondition2: String
        let pageNumber: Int
    }
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
        case .parties(let params):
            return "\(BaseURL.baseURL)/parties?categoryDetailId=\(params.categoryDetailId)&categoryId=\(params.categoryId)&orderCondition1=\(params.orderCondition1)&orderCondition2=\(params.orderCondition2)&pageNumber=\(params.pageNumber)&categoryVersion=1.0.0&userLatitude=1.00232&userLongitude=223.2345"
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
        case .oauthKaKao, .oauthLogout, .isMemeber, .tokenReissue, .reportParty, .checkEnteredParty, .partyDday, .checkMypage, .interest, .modifyInfo :
            return [
                "authorization": "Bearer eyJ0eXBlIjoiYWNjZXNzIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VySWQiOjEsImlhdCI6MTY4OTY2Mjc5NSwiZXhwIjoxNjkyMDgxOTk1fQ.qwKegwOutI8bWPmDBE0jx5KOspSQTVZL_Ucc-I6D_hY"
            ]
        case .parties, .associatedCategory, .createParty, .getPartyDetail, .modifyParty, .deleteParty, .calender, .region, .recentView, .checkMyParty, .partyMember, .detailCategory, .checkNickname, .essentialInfo:
            return [
                "authorization": "Bearer eyJ0eXBlIjoiYWNjZXNzIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VySWQiOjEsImlhdCI6MTY4OTY2Mjc5NSwiZXhwIjoxNjkyMDgxOTk1fQ.qwKegwOutI8bWPmDBE0jx5KOspSQTVZL_Ucc-I6D_hY",
                "Content-Type": "application/json;charset=UTF-8"
            ]
        }
    }
    
    var parameters: [String: Any] {
        switch self {
        case let .createParty(address, capacity, categoryDetailIDList, categoryID, hashTagNameList, maxAge, minAge, openChattingRoomURL, partyDescription, partyEndDateTime, partyLatitude, partyLongitude, partyName, partyStartDateTime, storeName):
            return [
                "address": address,
                "capacity": capacity,
                "categoryDetailIdList": categoryDetailIDList,
                "categoryId": categoryID,
                "hashTagNameList": hashTagNameList,
                "maxAge": maxAge,
                "minAge": minAge,
                "openChattingRoomURL": openChattingRoomURL,
                "partyDescription": partyDescription,
                "partyEndDateTime": partyEndDateTime,
                "partyLatitude": partyLatitude,
                "partyLongitude": partyLongitude,
                "partyName": partyName,
                "partyStartDateTime": partyStartDateTime,
                "storeName": storeName
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

extension PartingAPI {
    enum partySortingCondition {
        enum byNumberOfPeople: String {
            case few = "FEW_PEOPLE"
            case many = "MANY_PEOPLE"
            case none = "NONE"
        }
        
        enum byTime: String {
            case latest = "LATEST"
            case closingTime = "CLOSING_TIME"
            case none = "NONE"
        }
    }
}
