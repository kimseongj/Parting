//
//  NewMyPageViewModel.swift
//  Parting
//
//  Created by 이병현 on 2023/09/25.
//

import Foundation
import RxSwift
import RxCocoa

final class NewMyPageViewModel: BaseViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    var input: Input
    var output: Output
    var checkMyPartyResponseData: CheckMyPartyResponse?
    var checkEnteredPartyResponseData: CheckMyPartyResponse?
    var settingUnfoldButtonState: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var etcUnfoldButtonState: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    private var coordinator: MyPageCoordinator?
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(), output: Output = Output(), coordinator: MyPageCoordinator?) {
        self.input = input
        self.output = output
        self.coordinator = coordinator
    }
    
    func checkMyPartyDataRequest() {
        let api = PartingAPI.checkMyParty(
            pageNumber: 0,
            lat: 35.232324,
            lng: 126.32323
        )
        
        guard let url = URL(string: api.url ?? "") else { return }

        APIManager.shared.requestParting(
            type: CheckMyPartyResponse.self,
            url: url,
            method: .get,
            parameters: api.parameters,
            headers: api.headers
        ) { data in
            print("getRequest ✅✅")
            if let response = try? data.get() {
                self.checkMyPartyResponseData = response
            }
        }
    }
    
    func checkEnteredPartyRequest() {
        let api = PartingAPI.checkEnteredParty(
            pageNumber: 0,
            lat: 35.232324,
            lng: 126.32323
        )
        guard let url = URL(string: api.url ?? "") else { return }
        
        APIManager.shared.requestParting(
            type: CheckMyPartyResponse.self,
            url: url,
            method: .get,
            parameters: api.parameters,
            headers: api.headers
        ) { data in
            print("getRequest ✅✅")
            if let response = try? data.get() {
                self.checkEnteredPartyResponseData = response
            }
        }
    }
    
    func setUnfoldButton(state: Bool) {
        if state == settingUnfoldButtonState.value {
            settingUnfoldButtonState.accept(false)
        } else {
            settingUnfoldButtonState.accept(state)
        }
    }
    
    func etcUnfoldButton(state: Bool) {
        if state == etcUnfoldButtonState.value {
            etcUnfoldButtonState.accept(false)
        } else {
            etcUnfoldButtonState.accept(state)
        }
    }
    
    func pushRecentlyVC() {
        self.coordinator?.pushRecentlyPartyVC()
    }
    
    func pushMyPartyVC() {
        guard let checkMyPartyResponseData else { return }
        self.coordinator?.pushMyPartyVC(responseData: checkMyPartyResponseData)
    }
    
    func pushEnteredPartyVC() {
        guard let checkEnteredPartyResponseData else { return }
        self.coordinator?.pushEnteredPartyVC(responseData: checkEnteredPartyResponseData)
        
    }
    
    func pushEditMyPageVC() {
        self.coordinator?.pushEditMyPageVC()
    }
    
    func presentNotificationSettingVC() {
        self.coordinator?.presentNotificationSettingVC()
    }
    
    func presentLogoutAlertVC() {
        self.coordinator?.presentLogoutAlertVC()
    }
}
