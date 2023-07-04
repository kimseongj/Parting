//
//  APIManager.swift
//  Parting
//
//  Created by 박시현 on 2023/03/18.
//

import Foundation
import Alamofire
import RxSwift

class APIManager {
    static let shared = APIManager()
    
    //MARK: - 카테고리 종류 API
    func getCategoryAPI() -> Observable<CategoryResponse> {
        return Observable.create { emitter in
            let api = PartingAPI.detailCategory(categoryVersion: "1.0.0")
            guard let categoryURL = api.url else { return Disposables.create() }
            AF.request(categoryURL, method: .get, headers: api.headers).validate(statusCode: 200...500).responseDecodable(of: CategoryResponse.self) { response in
                print("카테고리 종류 API 상태코드 \(response.response?.statusCode) 🌱🌱")
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
    
    //MARK: - 시도, 시군구 API
    func getRegionAPI() -> Observable<RegionData> {
        return Observable.create { emitter in
            let api = PartingAPI.region
            guard let regionURL = api.url else { return Disposables.create() }
            AF.request(regionURL, method: .get, headers: api.headers).validate(statusCode: 200...500).responseDecodable(of: RegionData.self) {
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
            AF.request(essentialURL, method: .post, parameters: api.parameters, encoding: JSONEncoding.default, headers: api.headers).responseDecodable(of: NickNameResponse.self) { response in
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
    
    //MARK: - 카테고리별 세부 항목 API
    func getCategoryDetailList(_ categoryId: Int) -> Observable<CategoryDetailResponse> {
        return Observable.create { emitter in
            let api = PartingAPI.associatedCategory(categoryId: categoryId)
            guard let associatedCategoryURL = api.url else { return Disposables.create() }
            AF.request(associatedCategoryURL, method: .get, parameters: api.parameters, encoding: URLEncoding.default, headers: api.headers).responseDecodable(of: CategoryDetailResponse.self) { response in
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
}

