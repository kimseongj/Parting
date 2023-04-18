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
    
    func testAPI() -> Observable<Test> {
        return Observable.create { emitter in
            let url = PartingAPI.calender(month: 12, year: 2020)
            AF.request(url.url!, method: .get, parameters: url.parameters, headers: url.headers).responseDecodable(of: Test.self) {  response in
                print(response.result)
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

