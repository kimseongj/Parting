//
//  SetPopUpViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/08/13.
//

import UIKit
import RxSwift


class SetPopUpViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()
    private let coordinator: HomeCoordinator?
    
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
