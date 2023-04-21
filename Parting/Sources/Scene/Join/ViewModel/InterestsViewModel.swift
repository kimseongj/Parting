//
//  InterestsViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/04/20.
//

import UIKit
import RxSwift
import RxCocoa

class InterestsViewModel: BaseViewModel {
    struct Input {
        let viewChangeTrigger: PublishSubject<Void> = PublishSubject()
    }
    
    struct Output {
        
    }
    
    var input: Input
    var output: Output
    
    private weak var coordinator: JoinCoordinator?
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(), output: Output = Output(), coordinator: JoinCoordinator) {
        self.input = input
        self.output = output
        self.coordinator = coordinator
        viewChangeTrigger()
    }
    
    private func viewChangeTrigger() {
        input.viewChangeTrigger
            .subscribe(onNext:{ _ in
                self.popInterestsViewController()
            })
            .disposed(by: disposeBag)
    }
    
    func popInterestsViewController() {
        self.coordinator?.popInterestsViewController()
    }
}
