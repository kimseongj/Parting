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
    
    func getCategoryAPI() -> Observable<CategoryData> {
        return Observable.create { emitter in
            guard let url = PartingAPI.detailCategory.url else { return Disposables.create() }
            AF.request(url, method: .get, headers: PartingAPI.detailCategory.headers).validate(statusCode: 200...500).responseDecodable(of: CategoryData.self) { response in
                print("\(response.response?.statusCode ?? 1) ✅✅")
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

