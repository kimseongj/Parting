//
//  APIManager.swift
//  Parting
//
//  Created by 박시현 on 2023/03/18.
//

import Foundation
import Alamofire
import RxSwift
import CoreLocation

struct CreatePartyMockData {
    static let address: String = "대구 북구 산격동"
    static let capacity: Int = 5
    static let categoryDetailIDList: [Int] = [1]
    static let categoryID: Int = 0
    static let hashTagNameList: [String] = ["iOS Test"]
    static let maxAge: Int = 30
    static let minAge: Int = 22
    static let openChattingRoomURL: String = "https://open.kakao.com/o/gVRPbTzf"
    static let partyDescription: String = "팟팅 POST 통신 테스트"
    static let partyEndDateTime: String = "2023-12-30 12:30:00"
    static let partyLatitude: Double = 1.00232
    static let partyLongitude: Double = 223.2345
    static let partyName: String = "술먹을 사람"
    static let partyStartDateTime: String = "2023-12-30 12:00:00"
    static let storeName: String = "사군자"
}

class APIManager {
    static let shared = APIManager()
    
    private init() {}
    
    func requestPartingWithObservable<T: Decodable>(type: T.Type = T.self, url: URL, method: HTTPMethod = .get, parameters: [String:Any]? = nil, headers: HTTPHeaders) -> Observable<Result<T, Error>> {
        return Observable.create { emitter in
            AF.request(url, method: method, parameters: parameters, headers: headers)
                .validate(statusCode: 200...500)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case let .success(value):
                        emitter.onNext(.success(value))
                        emitter.onCompleted()
                    case let .failure(error):
                        emitter.onError(error)
                    }
                }
            return Disposables.create ()
        }
    }
    
    //MARK: - 카테고리 종류 API
    func getCategoryAPI() -> Observable<CategoryResponse> {
        return Observable.create { emitter in
            let api = PartingAPI.detailCategory(categoryVersion: "1.0.0")
            guard let categoryURL = api.url else { return Disposables.create() }
            AF.request(categoryURL, method: .get, headers: api.headers)
				.validate(statusCode: 200...500)
				.responseDecodable(of: CategoryResponse.self) { response in
                print("카테고리 종류 API 상태코드 \(response.response?.statusCode) 🌱🌱")
                switch response.result {
                case let .success(value):
					print(value)
                    emitter.onNext(value)
                    emitter.onCompleted()
                case let .failure(error):
                    emitter.onError(error)
                }
            }

            return Disposables.create()
        }
    }
	
	func getCategoryImageAPI() -> Observable<[CategoryModel]> {
        return Observable.create { emitter in
            let api = PartingAPI.detailCategory(categoryVersion: "1.0.0")
            guard let categoryURL = api.url else { return Disposables.create() }
            AF.request(categoryURL, method: .get, headers: api.headers)
				.validate(statusCode: 200...500)
				.responseDecodable(of: CategoryResponse.self) { response in
                print("카테고리 종류 API 상태코드 \(response.response?.statusCode) 🌱🌱")
                switch response.result {
                case let .success(value):
					let categories = value.result.categories
					
					var categoryList: [CategoryModel] = []
					
					for category in categories {
						guard let safeID = Int(category.categoryID) else { return }
						let newCategory = CategoryModel(id: safeID, name: category.categoryName, imgURL: category.imgURL, localImgSrc: nil)
						categoryList.append(newCategory)
					}

                    emitter.onNext(categoryList)
					emitter.onCompleted()
                case let .failure(error):
                    emitter.onError(error)
                }
            }

            return Disposables.create()
        }
    }
    
    //MARK: - 시도, 시군구 API
    func getRegionAPI() -> Observable<RegionData> {
        return Observable.create { emitter in
            let api = PartingAPI.region
            guard let regionURL = api.url else { return Disposables.create() }
            AF.request(regionURL, method: .get, headers: api.headers)
                .validate(statusCode: 200...500)
                .responseDecodable(of: RegionData.self) {
                response in
                print("시도, 시군구 API 상태코드 \(response.response?.statusCode) 🌱🌱")
                switch response.result {
                case let .success(value):
                    emitter.onNext(value)
                    emitter.onCompleted()
                case let .failure(error):
                    emitter.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    //MARK: - 닉네임 중복 검사 API
    func checkNickNameIsDuplicated(_ nickname: String) -> Observable<NickNameResponse> {
        return Observable.create { emitter in
            let api = PartingAPI.checkNickname(nickName: nickname)
            guard let nickNameurl = api
                .url else { return Disposables.create() }
            AF.request(nickNameurl, method: .get, parameters: api.parameters, encoding: URLEncoding.default, headers: api.headers).responseDecodable(of: NickNameResponse.self) {
                response in
                print("닉네임 중복 검사 API 상태코드 \(response.response?.statusCode) 🌱🌱")
                switch response.result {
                case let .success(value):
                    emitter.onNext(value)
                    emitter.onCompleted()
                case let .failure(error):
                    emitter.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    //MARK: - 필수정보 입력 POST API
    func enterEssentialInfo(_ birth: String, _ job: String, _ nickName: String, _ sex: String, _ sigunguCd: Int) -> Observable<NickNameResponse> {
        return Observable.create { emitter in
            let api = PartingAPI.essentialInfo(birth: birth, job: job, nickName: nickName, sex: sex, sigunguCd: sigunguCd)
            guard let essentialURL = api.url else { return Disposables.create() }
            AF.request(essentialURL, method: .post, parameters: api.parameters, encoding: JSONEncoding.default, headers: api.headers)
                .responseDecodable(of: NickNameResponse.self) { response in
                print("필수정보 입력 API 상태 코드 \(response.response?.statusCode) 🌱🌱")
                switch response.result {
                case let .success(value):
                    emitter.onNext(value)
                    emitter.onCompleted()
                case let .failure(error):
                    emitter.onError(error)
                }
            }
            return Disposables.create()
        }
    }

    
    // MARK: - 파티 생성
    func createPartyPost(
        address: String,
        capacity: Int,
        categoryDetailIDList: [Int],
        categoryID: Int,
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
        storeName: String,
        completion: @escaping (Int?) -> Void) {
        let api = PartingAPI.createParty(
            address: address,
            capacity: capacity,
            categoryDetailIdList: categoryDetailIDList,
            categoryId: categoryID,
            hashTagNameList: hashTagNameList,
            maxAge: maxAge,
            minAge: minAge,
            openChattingRoomURL: openChattingRoomURL,
            partyDescription: partyDescription,
            partyEndDateTime: partyEndDateTime,
            partyLatitude: partyLatitude,
            partyLongitude: partyLongitude,
            partyName: partyName,
            partyStartDateTime: partyStartDateTime,
            storeName: storeName
        )
        print(api)

        guard let url = api.url else { return }
        AF.request(url,
            method: .post,
            parameters: api.parameters,
            encoding: JSONEncoding.default,
            headers: api.headers).responseDecodable(of: CreatePartyPostResponseModel.self) { response in
                switch response.result {
                case let .success(value):
                    print(response.result, "💛💛")
                    guard let statuscode = response.response?.statusCode else { return }
                    completion(value.code)
                case .failure(_):
                    print(response.result, "🥶🥶")
                    guard let statuscode = response.response?.statusCode else { return }
                    completion(statuscode)
            }
        }
    }
    
    //MARK: - 카테고리별 세부 항목 API
    func getCategoryDetailList(_ categoryId: Int) -> Observable<CategoryDetailResponse> {
        return Observable.create { emitter in
            let api = PartingAPI.associatedCategory(categoryId: categoryId)
            guard let associatedCategoryURL = api.url else { return Disposables.create() }
            AF.request(associatedCategoryURL, method: .get, parameters: api.parameters, encoding: URLEncoding.default, headers: api.headers)
                .responseDecodable(of: CategoryDetailResponse.self) { response in
                print("카테고리별 세부 항복 API 상태코드 \(response.response?.statusCode) 🌱🌱")
                switch response.result {
                case let .success(value):
                    emitter.onNext(value)
                    emitter.onCompleted()
                case let .failure(error):
                    emitter.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func getCategoryDetailList(categoryId: Int) async throws -> [CategoryDetail] {
        let api = PartingAPI.associatedCategory(categoryId: categoryId)
        
        return await withCheckedContinuation({ continuation in
            guard let url = api.url else { return }
            AF.request(url, method: .get, parameters: api.parameters, encoding: URLEncoding.default, headers: api.headers).responseDecodable(of: CategoryDetailResponse.self) { response in
                switch response.result {
                case .success(let data):
                    print(data.code)
                    let associatedCategories = data.result
                    continuation.resume(returning: associatedCategories)
                case .failure(let error):
                    print(error)
                }
            }
        })
           
         
    }
	
	// MARK: 파티 리스트 API
//	func getPartyList(categoryId: Int, categoryDetailId: Int, orderCondition1: PartingAPI.partySortingCondition.byNumberOfPeople, orderCondition2: PartingAPI.partySortingCondition.byTime, pageNumber: Int) async throws -> [PartyListItemModel]? {
//
//		let urlParams = PartingAPI.PartyListParams(categoryId: categoryId, categoryDetailId: categoryDetailId, orderCondition1: orderCondition1.rawValue, orderCondition2: orderCondition2.rawValue, pageNumber: pageNumber)
//
//		let api = PartingAPI.parties(params: urlParams)
//		guard let url = api.url else { return nil }
//
//		return try await withUnsafeContinuation({ continuation in
//			AF.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: api.headers)
//                .responseDecodable(of: PartyListResponse.self) { response in
//
//				switch response.result {
//
//				case .success(let data):
//
//					let partyInfoList = data.result.partyInfos
//
//					let partyList = partyInfoList.map { info in
//						let distanceString = String(info.distance) + info.distanceUnit
//						let partyStatus = PartyStatus.strToStatus(info.status)
//
//						return PartyListItemModel(id: info.partyId, title: info.partyName, location: info.address, distance: distanceString, currentPartyMemberCount: info.currentPartyMemberCount, maxPartyMemberCount: info.maxPartyMemberCount, partyDuration: info.partyTimeStr, tags: info.hashTagNameList, status: partyStatus, imgURL: info.categoryImg)
//					}
//
//					continuation.resume(returning: partyList)
//
//				case .failure(let error):
//					print(error)
//				}
//
//			} /* AF Request */
//		}) /* End withUnsafeContinuation() */
//
//
//	} /* End func getPartyList() */
    
    
    
    func getPartyList(categoryId: Int, categoryDetailIds: [Int], orderCondition1: SortingOption.NumberOfPeopleType, orderCondition2: SortingOption.TimeType, pageNumber: Int, location: CLLocation) async throws -> [PartyListItemModel] {
            
            return await withCheckedContinuation({ continuation in
                
//                guard let location = LocationManager.shared.getLocation() else { return }
                let urlParams = PartingAPI.PartyListParams(categoryId: categoryId, categoryDetailIds: categoryDetailIds, orderCondition1: orderCondition1.rawValue, orderCondition2: orderCondition2.rawValue, pageNumber: pageNumber, userLatitude: location.coordinate.latitude, userLongitude: location.coordinate.longitude)
                print(urlParams, "urlParmas")
                let api = PartingAPI.parties(params: urlParams)
                guard let url = api.url else { return }
                
                AF.request(url, method: .get, parameters: api.parameters, encoding: URLEncoding.default, headers: api.headers).responseDecodable(of: PartyListResponse.self) { response in
                    
                    switch response.result {
                    case .success(let data):
                        print(response.response?.statusCode, "💛💛💛")
                        let partyInfoList = data.result.partyInfos
                        
                        let partyList = partyInfoList.map { info in
                            let distanceString = String(info.distance) + info.distanceUnit
                            let partyStatus = PartyStatus.strToStatus(info.status)
                            
                            return PartyListItemModel(id: info.partyId, title: info.partyName, location: info.address, distance: distanceString, currentPartyMemberCount: info.currentPartyMemberCount, maxPartyMemberCount: info.maxPartyMemberCount, partyDuration: info.partyStartTime, tags: info.hashTagNameList, status: partyStatus, imgURL: info.categoryImg)
                        }
                        continuation.resume(returning: partyList)
                        
                    case .failure(let error):
                        print(response.response?.statusCode, "💛💛💛")
                        print(error)
                    }
                    
                } /* AF Request */
            }) /* End withUnsafeContinuation() */
                
            
        } /* End func getPartyList() */
	
}

// MARK: - Generic 활용해보기
extension APIManager {
    func getRequestParting<T: Decodable>(
        type: T.Type = T.self,
        url: URL,
        method: HTTPMethod = .get,
        parameters: [String: Any]? = nil,
        headers: HTTPHeaders,
        completion: @escaping (Result<T, Error>) -> ()) {
        AF.request(url, method: method, parameters: parameters, headers: headers)
            .responseDecodable(of: T.self) { response in
                print(response.response?.statusCode)
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(_):
                    guard let statuscode = response.response?.statusCode else { return }
                    guard let error = PartingError(rawValue: statuscode) else { return }
                    completion(.failure(error))
                }
            }
    }
    
    func postRequestParting<T: Decodable>(
        type: T.Type = T.self,
        url: URL,
        method: HTTPMethod = .post,
        parameters: [String: Any]? = nil,
        encoding: JSONEncoding = .default,
        headers: HTTPHeaders,
        completion: @escaping (Result<T, Error>) -> ()) {
            AF.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).responseDecodable(of: T.self) { response in
                switch response.result {
                case let .success(value):
                    print(response.result, "💛💛")
                    guard let statusCode = response.response?.statusCode else { return }
                    completion(.success(value))
                case let .failure(error): // 열거형 에러 타입 만들어 줘도 된다.
                    guard let statusCode = response.response?.statusCode else { return }
                    completion(.failure(error))
                }
            }
    }
    
    
}

//MARK: - @escaping closure
extension APIManager {
    // MARK: - 내가 개설한 파티
    func checkMyParty(pageNumber: Int, lat: Double, lng: Double, completionHandler: @escaping(CheckMyPartyResponse) -> ()) {
        let api = PartingAPI.checkMyParty(pageNumber: pageNumber, lat: lat, lng: lng)
        guard let url = api.url else { return }
        AF.request(url, method: .get, parameters: api.parameters, headers: api.headers)
            .validate(statusCode: 200...500)
            .responseDecodable(of: CheckMyPartyResponse.self) { response in
                print("checkMyPage 상태코드 🌟🌟🌟\(response.response?.statusCode)")
                switch response.result {
                case .success(let value):
                    print(value)
                    print("서버 상태코드", value.code)
                    completionHandler(value)
                case let .failure(error):
                    print(error)
                    print("서버 실패 상태코드😱😱", response.value?.code)
                    guard let statusCode = response.response?.statusCode else { return }
                    guard let error = PartingError(rawValue: statusCode) else { return }
                    print(error)
                }
            }
    }
}
