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
    
    func getCategoryImageAPI() -> Observable<[CategoryModel]> {
        return Observable.create { emitter in
            let api = PartingAPI.detailCategory(categoryVersion: "1.0.0")
            guard let categoryURL = api.url else { return Disposables.create() }
            AF.request(categoryURL, method: .get, headers: api.headers)
                .validate(statusCode: 200...500)
                .responseDecodable(of: CategoryResponse.self) { response in
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
    
    func getCategoryDetailList(categoryId: Int) async throws -> [CategoryDetail] {
        let api = PartingAPI.associatedCategory(categoryId: categoryId)
        
        return await withCheckedContinuation({ continuation in
            guard let url = api.url else { return }
            AF.request(url, method: .get, parameters: api.parameters, encoding: URLEncoding.default, headers: api.headers).responseDecodable(of: CategoryDetailResponse.self) { response in
                switch response.result {
                case .success(let data):
                    let associatedCategories = data.result.categoryDetailList
                    continuation.resume(returning: associatedCategories)
                case .failure(let error):
                    print(error)
                }
            }
        })
    }
}

// MARK: - Generic 활용해보기
extension APIManager {
    // MARK: - Request
    func requestParting<T: Decodable>(
        type: T.Type = T.self,
        url: URL,
        method: HTTPMethod = .get,
        parameters: [String: Any]? = nil,
        encoding: JSONEncoding = .default,
        headers: HTTPHeaders,
        completion: @escaping (Result<T, Error>) -> ()) {
            switch method {
            case .get:
                AF.request(
                    url,
                    method: method,
                    parameters: parameters,
                    headers: headers
                ).responseDecodable(of: T.self) { response in
                    switch response.result {
                    case let .success(value):
                        completion(.success(value))
                    case let .failure(error): // 열거형 에러 타입 만들어 줘도 된다.
                        print(error)
                        completion(.failure(error))
                    }
                }
            case .post, .put:
                AF.request(
                    url,
                    method: method,
                    parameters: parameters,
                    encoding: encoding,
                    headers: headers
                ).responseDecodable(of: T.self) { response in
                    print(response)
                    switch response.result {
                    case let .success(value):
                        completion(.success(value))
                    case let .failure(error): // 열거형 에러 타입 만들어 줘도 된다.
                        print(error)
                        completion(.failure(error))
                    }
                }
            case .delete:
                AF.request(
                    url,
                    method: method,
                    parameters: parameters,
                    encoding: encoding,
                    headers: headers
                ).responseDecodable(of: T.self) { response in
                    print(response)
                    switch response.result {
                    case let .success(value):
                        completion(.success(value))
                    case let .failure(error): // 열거형 에러 타입 만들어 줘도 된다.
                        print(error)
                        completion(.failure(error))
                    }
                }
            default:
                break
            }
            
        }
    
    func requestPartingWithObservable<T: Decodable>(
        type: T.Type = T.self,
        url: URL,
        method: HTTPMethod = .get,
        parameters: [String:Any]? = nil,
        encoding: JSONEncoding = .default,
        headers: HTTPHeaders
    ) -> Observable<Result<T, Error>> {
        return Observable.create { emitter in
            switch method {
            case .get:
                AF.request(
                    url,
                    method: method,
                    parameters: parameters,
                    headers: headers
                )
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
            case .post, .put:
                AF.request(
                    url,
                    method: method,
                    parameters: parameters,
                    encoding: encoding,
                    headers: headers
                )
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
            default:
                break
            }
            
            return Disposables.create ()
        }
    }
}

extension APIManager {
    func requestGetMyPageData() -> Observable<MyPageResponse> {
        return Observable.create { emitter in
            let api = PartingAPI.getMypage
            guard let myPageURL = api.url else { return Disposables.create() }
            AF.request(myPageURL, method: .get, headers: api.headers)
                .validate(statusCode: 200...500)
                .responseDecodable(of: MyPageResponse.self) { response in
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
}
