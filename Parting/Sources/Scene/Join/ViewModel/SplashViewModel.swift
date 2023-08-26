//
//  SplashViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/04/17.
//

import Foundation
import RxSwift

final class SplashViewModel: BaseViewModel {
    struct Input {
        let showJoinViewController: PublishSubject<Void> = PublishSubject()
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
        viewChangeTrgger()
    }
    
    private func viewChangeTrgger() {
        input.showJoinViewController
            .subscribe(onNext: { _ in
                self.showJoinViewController()
            })
            .disposed(by: disposeBag)
    }
    
    func showJoinViewController() {
        self.coordinator?.showJoinViewController()
    }
}
