//
//  TabManViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/09/29.
//

import Foundation
import RxSwift

final class TabManDataSource {
    private weak var coordinator: HomeCoordinator?
    
    enum Input {
        case backButtonTap
    }
    
    init(coordinator: HomeCoordinator?) {
        self.coordinator = coordinator
        bind()
    }
    
    var input = PublishSubject<Input>()
    private let disposeBag = DisposeBag()
    
    func bind() {
        input
            .withUnretained(self)
            .subscribe(onNext: { owner, input in
                switch input {
                case .backButtonTap:
                    owner.popVC()
                }
            })
            .disposed(by: disposeBag)
    }
    
    func popVC() {
        self.coordinator?.popVC()
    }
}
