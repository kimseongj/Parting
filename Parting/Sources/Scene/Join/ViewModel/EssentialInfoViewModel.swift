//
//  EssentialInfoViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/04/20.
//

import UIKit
import RxSwift
import RxCocoa

class EssentialInfoViewModel: BaseViewModel {
    struct Input {
        let popEssentialViewTrigger: PublishSubject<Void> = PublishSubject()
        let pushInterestsViewTrigger: PublishSubject<Void> = PublishSubject()
        let getAddressTrigger: PublishSubject<Void> = PublishSubject()
    }
    
    struct Output {
        
    }
    
    var input: Input
    var output: Output
    
    private weak var coordinator: JoinCoordinator?
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(), output: Output = Output(), coordinator: JoinCoordinator?) {
        self.input = input
        self.output = output
        self.coordinator = coordinator
        viewChangeTrigger()
        getAddress()
    }
    
    private func viewChangeTrigger() {
        input.popEssentialViewTrigger
            .subscribe(onNext:{ _ in
                self.popEssentialInfoViewController()
            })
            .disposed(by: disposeBag)
        
        input.pushInterestsViewTrigger
            .subscribe(onNext: { _ in
                self.pushInterestsViewController()
            })
            .disposed(by: disposeBag)
    }
    private func getAddress() {
        
    }
    
    
    private func popEssentialInfoViewController() {
        self.coordinator?.popJoinCompleteViewController()
    }
    
    private func pushInterestsViewController() {
        self.coordinator?.pushInterestsViewController()
    }
    
}
