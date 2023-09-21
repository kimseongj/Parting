//
//  CheckMyPartyViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/08/16.
//

import Foundation
import RxSwift
import RxCocoa

class CheckMyPartyViewModel {
    enum Input {
        case pushDetailPartyInfo(partyId: Int)
        case popVC
    }
    
    enum Output {
        
    }
    
    let input = PublishSubject<Input>()
    
    var checkMyPartyResponseData: CheckMyPartyResponse?
    var myPartyList: BehaviorRelay<[PartyInfoResponse]> = BehaviorRelay(value: [])
    
    private let disposeBag = DisposeBag()
    
    private var coordinator: MyPageCoordinator?
    
    init(coordinator: MyPageCoordinator?, responseData: CheckMyPartyResponse?) {
        self.coordinator = coordinator
        self.checkMyPartyResponseData = responseData
        self.myPartyList.accept((responseData?.result.partyInfos)!)
        bind()
    }
    
    private func bind() {
        input
            .withUnretained(self)
            .subscribe(onNext: { owner, input in
                switch input {
                case .popVC:
                    owner.popVC()
                case let .pushDetailPartyInfo(partyId):
                    owner.pushDetailInfoVC(partyId: partyId)
                    print("Cell Clicked! 🔥")
                }
            })
            .disposed(by: disposeBag)
    }
    
    
    private func pushDetailInfoVC(partyId: Int) {
        self.coordinator?.pushDetailPartyVC(partyId: partyId)
    }
    
    private func popVC() {
        self.coordinator?.popVC()
    }
    
}
