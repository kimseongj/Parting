//
//  MyPageViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/07/13.
//

import Foundation
import RxSwift
import RxCocoa

enum MyPageCellTitle: String {
    case current = "최근 본 파티"
    case create = "개설한 파티"
    case participate = "참여한 파티"
}

final class MyPageViewModel: BaseViewModel {
    struct Input {
        let viewWillAppearTrigger = PublishSubject<Void>()
        let cellSelected: PublishRelay<MyPageModel> = PublishRelay()
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
    let myPageData = PublishRelay<MyPageResponse>()
    
    init(input: Input = Input(), output: Output = Output(), coordinator: MyPageCoordinator?) {
        self.input = input
        self.output = output
        self.coordinator = coordinator
        bind()

    }
    
    private func bind() {
        input.viewWillAppearTrigger
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.getMyPageData()
            })
            .disposed(by: disposeBag)
        
        input.cellSelected
            .withUnretained(self)
            .bind { vm, cellItem in
                if cellItem.title == MyPageCellTitle.current.rawValue {
                    vm.pushRecentlyVC()
                } else if cellItem.title == MyPageCellTitle.create.rawValue {
                    vm.pushMyPartyVC()
                } else {
                    vm.pushEnteredPartyVC()
                }
            }
            .disposed(by: disposeBag)
    }
    
    func checkMyPartyDataRequest() {
        let api = PartingAPI.checkMyParty(
            pageNumber: 0,
            lat: UserLocationManager.userLat,
            lng: UserLocationManager.userLng
        )
        
        guard let url = URL(string: api.url ?? "") else { return }

        APIManager.shared.requestParting(
            type: CheckMyPartyResponse.self,
            url: url,
            method: .get,
            parameters: api.parameters,
            headers: api.headers
        ) { data in
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
    
    func pushInquireVC() {
        self.coordinator?.pushInquireVC()
    }
    
    func pushTermsOfServiceVC() {
        self.coordinator?.pushTermsOfServiceVC()
    }
}

extension MyPageViewModel {
    func getMyPageData() {
        APIManager.shared.requestGetMyPageData()
            .subscribe { [weak self] data in
                guard let self else { return }
                self.myPageData.accept(data)
            } onError: { error in
                print(error)
            }
            .disposed(by: disposeBag)
    }
}
