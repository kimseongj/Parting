//
//  MyPageViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/07/13.
//

import Foundation
import RxSwift
import RxCocoa

final class MyPageViewModel: BaseViewModel {
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
        print(url)

        APIManager.shared.requestParting(
            type: CheckMyPartyResponse.self,
            url: url,
            method: .get,
            parameters: api.parameters,
            headers: api.headers
        ) { data in
            print(data)
            if let response = try? data.get() {
                self.checkMyPartyResponseData = response
            }
            print(data, "CheckMyPartyData + Generic 🤣🤣")
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
            headers: api.headers,
            completion: { data in
            print(data, "🤣🤣")
            if let respsonse = try? data.get() {
                self.checkEnteredPartyResponseData = respsonse
            }
            print(data, "CheckEnteredPartyData + Generic 🤣🤣")
        })
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
        print(checkMyPartyResponseData)
        guard let checkMyPartyResponseData else { return }
        self.coordinator?.pushMyPartyVC(responseData: checkMyPartyResponseData)
    }
    
    func pushEnteredPartyVC() {
        guard let checkEnteredPartyResponseData else { return }
        self.coordinator?.pushEnteredPartyVC(responseData: checkEnteredPartyResponseData)
        
    }
}
