//
//  UserAgreementViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/09/20.
//

import Foundation
import RxSwift
import RxCocoa

class UserAgreementViewModel {
    enum Input {
        case nextButtonClicked
        case serviceAgreementClicked
        case personalInfoAgreementClicked
    }
    
    enum Output {
        case initial
        case test
    }
    
    struct State {
        var serviceAgreement = BehaviorRelay<Bool>(value: false)
        var personalInfoAgreement = BehaviorRelay<Bool>(value: false)
        var nextButtonIsValidState = BehaviorRelay<Bool>(value: false)
    }
    
    private weak var coordinator: JoinCoordinator?
    private let disposeBag = DisposeBag()
    
    var input: PublishSubject<Input> = .init()
    var output: BehaviorRelay<Output> = .init(value: .test)
    let state: State = State()
    
    init(
        input: PublishSubject<Input> = .init(),
        output: BehaviorRelay<Output> = .init(value: .initial),
        coordinator: JoinCoordinator?
    ) {
        self.input = input
        self.output = output
        self.coordinator = coordinator
        bind()
    }
    
    private func bind() {
        input
            .withUnretained(self)
            .subscribe(onNext: { owner, event in
            switch event {
            case .nextButtonClicked:
                if owner.state.nextButtonIsValidState.value {
                    owner.pushEssentialInfoViewController()
                } else {
                    // MARK: - 토스트 메시지 띄우기 (모든 버튼을 체크해주세요)
                }
                
            case .serviceAgreementClicked:
                if owner.state.serviceAgreement.value {
                    owner.state.serviceAgreement.accept(false)
                } else {
                    owner.state.serviceAgreement.accept(true)
                }
            case .personalInfoAgreementClicked:
                if owner.state.personalInfoAgreement.value {
                    owner.state.personalInfoAgreement.accept(false)
                } else {
                    owner.state.personalInfoAgreement.accept(true)
                }
            }
        })
        .disposed(by: disposeBag)
    }
    
    var nextButtonIsValid: Observable<Bool> {
        Observable.combineLatest(state.serviceAgreement, state.personalInfoAgreement) { serviceState, personalInfoState in
            print(serviceState, personalInfoState)
            if serviceState && personalInfoState {
                self.state.nextButtonIsValidState.accept(true)
                return true
            } else {
                self.state.nextButtonIsValidState.accept(false)
                return false
            }
        }
    }
    
    func popUserAgreementVC() {
        self.coordinator?.popUserAgreementVC()
    }
    
    func pushEssentialInfoViewController() {
        self.coordinator?.pushEssentialInfoViewController()
    }
}
