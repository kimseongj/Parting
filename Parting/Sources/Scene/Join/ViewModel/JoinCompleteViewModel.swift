//
//  JoinCompleteViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/04/20.
//

import Foundation
import RxSwift

final class JoinCompleteViewModel: BaseViewModel {
    struct Input {
        let popJoinCompleteViewTrigger: PublishSubject<Void> = PublishSubject()
        let pushEssentialInfoViewTrigger: PublishSubject<Void> = PublishSubject()
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
    }
    
    private func viewChangeTrigger() {
        input.popJoinCompleteViewTrigger
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.popJoinCompleteViewController()
            })
            .disposed(by: disposeBag)
        
        input.pushEssentialInfoViewTrigger
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.pushEssentialInfoViewController()
            })
            .disposed(by: disposeBag)
    }
    
    func popJoinCompleteViewController() {
        self.coordinator?.popJoinCompleteViewController()
    }
    
    func pushEssentialInfoViewController() {
        self.coordinator?.pushEssentialInfoViewController()
    }
    
}
