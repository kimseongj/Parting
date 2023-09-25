//
//  MapViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/07/14.
//

import Foundation
import RxSwift
import RxCocoa

final class MapViewModel {
    enum Input {
        case viewDidLoadTrigger
    }
    
    enum Output {
        
    }
    
    var input: PublishSubject<Input> = PublishSubject()
    
    private var mapCoordinator: MapCoordinator?
    private let disposeBag = DisposeBag()
    
    init(mapCoordinator: MapCoordinator?) {
        self.mapCoordinator = mapCoordinator
        bind()
    }
    
    private func bind() {
        input
            .withUnretained(self)
            .subscribe(onNext: { owner, event in
                owner.getAroundParty()
            })
            .disposed(by: disposeBag)
    }
    
    private func getAroundParty() {
        let api = PartingAPI.getAroundParty(
            searchHighLatitude: 35.795557757,
            searchHighLongitude: 128.62472,
            searchLowLatitude: 35.87139,
            searchLowLongitude: 128.63845
        )
        
        guard let apiurl = api.url else { return }
        guard let url = URL(string: apiurl) else { return }
        
        print(url, "🌆")

        APIManager.shared.requestParting(
            type: AroundPartyResponse.self,
            url: url,
            method: .get,
            parameters: api.parameters,
            headers: api.headers
        ) { response in
                switch response {
                case let .success(data):
                    print(data, "✅")
                case let .failure(error):
                    print(error)
                }
            }
    }
}
