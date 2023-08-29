//
//  EnterPartyViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/08/22.
//

import Foundation
import RxSwift
import RxCocoa

final class EnterPartyViewModel{
    enum Input {
        case deleteParty(row: Int)
        case popCurrentVC
    }
    
    enum Output {
        case notificationReloadData
    }
    
    var deleteRows = PublishSubject<Int>()
    var checkResponseData: CheckMyPartyResponse?
    var myPartyList: [PartyInfoResponse] = []
    let input = PublishRelay<Input>()
    let output = PublishRelay<Output>()
    
    private var coordinator: MyPageCoordinator?
    private let disposeBag = DisposeBag()
    
    init(coordinator: MyPageCoordinator?, responseData: CheckMyPartyResponse?) {
        self.coordinator = coordinator
        self.checkResponseData = responseData
        self.myPartyList = (responseData?.result.partyInfos)!
        bind()
    }
    
    private func bind() {
        input
            .withUnretained(self)
            .subscribe(onNext: { owner, input in
                switch input {
                case let .deleteParty(row):
                    owner.deleteParty(row: row)
                case .popCurrentVC:
                    owner.popVC()
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    private func deleteParty(row: Int) {
        let partyId = myPartyList[row].partyID
        // MARK: - PartyId 삭제
        myPartyList.removeAll(where: {$0.partyID == partyId})
        output.accept(.notificationReloadData)
        let api = PartingAPI.deleteParty(partyId: partyId)
        
        guard let apiURL = api.url else { return }
        guard let url = URL(string: apiURL) else { return }
        APIManager.shared.requestParting(
            type: BasicResponse.self,
            url: url,
            method: .delete,
            parameters: api.parameters,
            encoding: .default,
            headers: api.headers) { data in
                print("deleteRequest ✅✅")
                if let response = try? data.get() {
                    print(response.code)
                }
            }
    }

    private func popVC() {
        self.coordinator?.popVC()
    }
    
    private func pushShowDetailParty() {
        
    }
}
