//
//  SetPopUpViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/08/13.
//

import Foundation
import RxSwift

protocol SetPopUpViewStateProtocol {
    var popUpButtonIsClicked: PublishSubject<Int> { get }
    
    func tapPopUpButton(state: Int)
}


final class SetPopUpViewModel: BaseViewModel, SetPopUpViewStateProtocol {
    
    private let disposeBag = DisposeBag()
    private let coordinator: HomeCoordinator?
    var popUpButtonIsClicked = PublishSubject<Int>()
    
    struct Input {
        let popVCTrigger = PublishSubject<Void>()

    }
    
    struct Output {
        
    }
    
    var input: Input
    var output: Output
    
    init(input: Input = Input(), output: Output = Output(), coordinator: HomeCoordinator?) {
        self.input = input
        self.output = output
        self.coordinator = coordinator
        bind()
        viewTransition()
    }
    
    func tapPopUpButton(state: Int) {
        popUpButtonIsClicked.onNext(state)
    }
    
    
    private func bind() {
        
    }
    
    private func viewTransition() {
        input.popVCTrigger
            .bind { [weak self] event in
                self?.coordinator?.dismissPopUpVC()
            }
            .disposed(by: disposeBag)
    }
}
