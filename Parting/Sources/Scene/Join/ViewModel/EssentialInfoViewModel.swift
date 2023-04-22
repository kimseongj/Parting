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
        let firstJobCheckButtonTrigger: PublishSubject<Void> = PublishSubject()
        let secondJobCheckButtonTrigger: PublishSubject<Void> = PublishSubject()
        let firstGenderCheckButtonTrigger: PublishSubject<Void> = PublishSubject()
        let secondGenderCheckButtonTrigger: PublishSubject<Void> = PublishSubject()
    }
    
    struct Output {
        let firstJobCheckButtonUpdate: BehaviorRelay<Void> = BehaviorRelay(value: ())
        let secondJobCheckButtonUpdate: BehaviorRelay<Void> = BehaviorRelay(value: ())
        let firstGenderCheckButtonUpdate: BehaviorRelay<Void> = BehaviorRelay(value: ())
        let secondGenderCheckButtonUpdate: BehaviorRelay<Void> = BehaviorRelay(value: ())
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
        buttonCheckTrigger()
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
    
    private func buttonCheckTrigger() {
        input.firstJobCheckButtonTrigger
            .subscribe(onNext: { _ in
                self.output.firstJobCheckButtonUpdate.accept(())
            })
            .disposed(by: disposeBag)
        
        input.secondJobCheckButtonTrigger
            .subscribe(onNext: { _ in
                self.output.secondJobCheckButtonUpdate.accept(())
            })
            .disposed(by: disposeBag)
        
        input.firstGenderCheckButtonTrigger
            .subscribe(onNext: { _ in
                self.output.firstGenderCheckButtonUpdate.accept(())
            })
            .disposed(by: disposeBag)
        
        input.secondGenderCheckButtonTrigger
            .subscribe(onNext: { _ in
                self.output.secondGenderCheckButtonUpdate.accept(())
            })
            .disposed(by: disposeBag)
    }
    
    func popEssentialInfoViewController() {
        self.coordinator?.popJoinCompleteViewController()
    }
    
    func pushInterestsViewController() {
        self.coordinator?.pushInterestsViewController()
    }
}
