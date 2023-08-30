//
//  ShowDetailPartyViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/08/29.
//

import Foundation
import RxSwift
import RxCocoa

class PartyDetailInfoViewModel {
    enum Input {
        case viewDidLoadTrigger
    }
    
    enum Output {
        
    }
    
    private var coordinator: MyPageCoordinator?
    private let disposeBag = DisposeBag()
    let partyId: Int?
    let input = PublishSubject<Input>()
    
    init(coordinator: MyPageCoordinator?, partyId: Int) {
        self.coordinator = coordinator
        self.partyId = partyId
        bind()
    }
    
    private func bind() {
        input
            .withUnretained(self)
            .subscribe(onNext: { owner, input in
                switch input {
                case .viewDidLoadTrigger:
                    print(owner.partyId, "Clicked Cell 데이터 전달 💛")
                    guard let partyId = owner.partyId else { return }
                    owner.getDetailPartyInfo(partyId: partyId)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func getDetailPartyInfo(partyId: Int) {
        let api = PartingAPI.getPartyDetail(partyId: partyId, userLatitude: 35, userLongitude: 35)
        guard let apiURL = api.url else { return }
        guard let url = URL(string: apiURL) else { return }
        APIManager.shared.requestParting(
            type: DetailPartyInfoResponse.self,
            url: url,
            method: .get,
            parameters: api.parameters,
            headers: api.headers) { data in
                if let response = try? data.get() {
                    print(response.result.minAge, response.result.maxAge)
                }
            }
    }
    
    private func popVC() {
        self.coordinator?.popVC()
    }
    
}
