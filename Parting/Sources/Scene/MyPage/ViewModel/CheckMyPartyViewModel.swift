//
//  CheckMyPartyViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/08/16.
//

import Foundation
import RxSwift
import RxCocoa

class CheckMyPartyViewModel: BaseViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    var input: Input
    var output: Output
    var checkMyPartyResponseData: CheckMyPartyResponse?
    var myPartyList: BehaviorRelay<[PartyInfoResponse]> = BehaviorRelay(value: [])
    
    private var coordinator: MyPageCoordinator?
    
    init(input: Input = Input(), output: Output = Output(), coordinator: MyPageCoordinator?, responseData: CheckMyPartyResponse?) {
        self.input = input
        self.output = output
        self.coordinator = coordinator
        self.checkMyPartyResponseData = responseData
        self.myPartyList.accept((responseData?.result.partyInfos)!)
    }
    
    
    
    func popVC() {
        self.coordinator?.popVC()
    }
    
}
