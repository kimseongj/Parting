//
//  SetMapViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/07/31.
//

import UIKit
import RxSwift
import RxCocoa

final class SetMapViewModel: BaseViewModel {
    struct Input {
        let popVCTrigger = PublishSubject<Void>()
    }

    struct Output {
        
    }

    var input: Input
    var output: Output

    private let coordinator: HomeCoordinator?
    private let disposeBag = DisposeBag()

    init(input: Input = Input(), output: Output = Output(), coordinator: HomeCoordinator?) {
        self.input = input
        self.output = output
        self.coordinator = coordinator
        viewTransition()
    }
    
    private func viewTransition() {
        input.popVCTrigger
            .subscribe(onNext: {[weak self] _ in
                self?.popVC()
            })
            .disposed(by: disposeBag)
    }
    
    private func popVC() {
        self.coordinator?.popVC()
    }
}

