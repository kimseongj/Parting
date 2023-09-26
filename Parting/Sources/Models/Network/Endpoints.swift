//
//  Endpoints.swift
//  Parting
//
//  Created by 박시현 on 2023/03/18.
//

import Foundation
import Alamofire
//import Alamofire

enum PartingAPI {
    case detailCategory(categoryVersion: String)
    case associatedCategory(categoryId: Int)
    case oauthKaKao
    case oauthLogout
    case isMemeber
    case tokenReissue
    case parties(params: PartyListParams)
    case createParty(
        address: String,
        capacity: Int,
        categoryDetailIdList: [Int],
        categoryId: Int,
        hashTagNameList: [String],
        maxAge: Int,
        minAge: Int,
        openChattingRoomURL: String,
        partyDescription: String,
        partyEndDateTime: String,
        partyLatitude: Double,
        partyLongitude: Double,
        partyName: String,
        partyStartDateTime: String,
        storeName: String
    )
    case getPartyDetail(
        partyId: Int,
        userLatitude: Double,
        userLongitude: Double
    )
    case modifyParty(partyId: Int)
    case deleteParty(partyId: Int)
    case calender(month: Int, year: Int)
    case recentView(partyIdStr: String)
    case region
    case reportParty
    case checkMyParty(pageNumber: Int, lat: Double, lng: Double)
    case partyMember(partyId: Int, userId: Int)
    case checkEnteredParty(pageNumber: Int, lat: Double, lng: Double)
    case partyDday
    case checkMypage
    case checkNickname(nickName: String)
    case essentialInfo(birth: String, job: String, nickName: String, sex: String, sigunguCd: Int)
    case interest
    case modifyInfo
    case getAroundParty(
        beforeSearchHighLatitude: Double? = nil,
        beforeSearchHighLongitude: Double? = nil,
        beforeSearchLowLatitude: Double? = nil,
        beforeSearchLowLongitude: Double? = nil,
        searchHighLatitude: Double,
        searchHighLongitude: Double,
        searchLowLatitude: Double,
        searchLowLongitude: Double
    )
    case getMapPartyDetailInfo(
        partyIdList: [Int],
        userLatitude: Double,
        userLongitude: Double
    )
    case getMypage
}

extension PartingAPI {
    struct PartyListParams {
        let categoryId: Int
        let categoryDetailIds: [Int]
        let orderCondition1: String
        let orderCondition2: String
        let pageNumber: Int
        let userLatitude: Double
        let userLongitude: Double
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
        case .parties:
            return "\(BaseURL.baseURL)/parties"
        case .createParty:
            return  "\(BaseURL.partyURL)"
        case .modifyParty, .calender, .recentView:
            return  "\(BaseURL.partyURL)/calendar"
        case .partyDday:
            return "\(BaseURL.partyURL)/d-day"
        case let .partyMember(partyId, userId):
            return "\(BaseURL.partyURL)/\(partyId)/\(userId)"
        case let .getPartyDetail(partyId, _, _):
            return "\(BaseURL.partyURL)/\(partyId)"
        case let .deleteParty(partyId):
            return "\(BaseURL.partyURL)/\(partyId)/member"
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
        case .getAroundParty:
            return "\(BaseURL.partyURL)/map"
        case .getMapPartyDetailInfo:
            return "\(BaseURL.partyURL)/map/detail"
        case .getMypage:
            return "\(BaseURL.userURL)/modify"
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .oauthKaKao, .oauthLogout, .isMemeber, .tokenReissue, .reportParty, .checkEnteredParty, .partyDday, .checkMypage, .interest, .modifyInfo :
            return [
                "authorization": "Bearer eyJ0eXBlIjoiYWNjZXNzIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VySWQiOjEsImlhdCI6MTY5NDI2MjY5MywiZXhwIjoxNjk2NjgxODkzfQ.7a6FASp4Us1RPdtONo3hNyqOFOQ-d0GhAT3gD0x5rew"
            ]
        case .parties, .associatedCategory, .createParty, .getPartyDetail, .modifyParty, .deleteParty, .calender, .region, .recentView, .checkMyParty, .partyMember, .detailCategory, .checkNickname, .essentialInfo, .getAroundParty, .getMapPartyDetailInfo, .getMypage:

            return [
                "authorization": "Bearer eyJ0eXBlIjoiYWNjZXNzIiwiYWxnIjoiSFMyNTYifQ.eyJ1c2VySWQiOjEsImlhdCI6MTY5NDI2MjY5MywiZXhwIjoxNjk2NjgxODkzfQ.7a6FASp4Us1RPdtONo3hNyqOFOQ-d0GhAT3gD0x5rew",
                "Content-Type": "application/json;charset=UTF-8"
            ]
        }
    }
        
        var parameters: [String: Any] {
            switch self {
            case .parties(let params):
                return [
                    "categoryId": params.categoryId,
                    "categoryDetailId": params.categoryDetailIds,
                    "orderCondition1": params.orderCondition1,
                    "orderCondition2": params.orderCondition2,
                    "pageNumber": params.pageNumber,
                    "categoryVersion": "1.0.0",
                    "userLatitude": params.userLatitude,
                    "userLongitude": params.userLongitude
                ]
            case let .createParty(
                address,
                capacity,
                categoryDetailIDList,
                categoryID,
                hashTagNameList,
                maxAge,
                minAge,
                openChattingRoomURL,
                partyDescription,
                partyEndDateTime,
                partyLatitude,
                partyLongitude,
                partyName,
                partyStartDateTime,
                storeName
            ):
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
            case let .modifyParty(partyId), let .deleteParty(partyId):
                return [
                    "partyId": partyId
                ]
            case let .getPartyDetail(partyId, userLatitude, userLongitude):
                return [
                    "partyId": partyId,
                    "userLatitude": userLatitude,
                    "userLongitude": userLongitude
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
            case let .checkMyParty(pageNumber, lat, lng):
                return [
                    "pageNumber": pageNumber,
                    "userLatitude": lat,
                    "userLongitude": lng
                ]
            case let .checkEnteredParty(pageNumber, lat, lng):
                return [
                    "pageNumber": pageNumber,
                    "userLatitude": lat,
                    "userLongitude": lng
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
            case let .getAroundParty(
                beforeSearchHighLatitude,
                beforeSearchHighLongitude,
                beforeSearchLowLatitude,
                beforeSearchLowLongitude,
                searchHighLatitude,
                searchHighLongitude,
                searchLowLatitude,
                searchLowLongitude):
                return [
//                    "beforeSearchHighLatitude": beforeSearchHighLatitude,
//                    "beforeSearchHighLongitude": beforeSearchHighLongitude,
//                    "beforeSearchLowLatitude": beforeSearchLowLatitude,
//                    "beforeSearchLowLongitude": beforeSearchLowLongitude,
                    "searchHighLatitude": searchHighLatitude,
                    "searchHighLongitude": searchHighLongitude,
                    "searchLowLatitude": searchLowLatitude,
                    "searchLowLongitude": searchLowLongitude
                ]
            case let .getMapPartyDetailInfo(
                partyIdList,
                userLatitude,
                userLongitude
            ):
                return [
                    "partyIdList": partyIdList,
                    "userLatitude": userLatitude,
                    "userLongitude": userLongitude
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
