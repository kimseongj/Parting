//
//  SplashViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/04/17.
//

import Foundation
import RxSwift
import RxCocoa

final class SplashViewModel: BaseViewModel {
    struct Input {
        let viewDidLoadTrigger: PublishSubject<Void> = PublishSubject()
    }
    
    struct Output {
        let calendarDays: BehaviorRelay<[Int]> = BehaviorRelay<[Int]>(value: [])
    }
    
    var input: Input
    var output: Output
    
    private weak var coordinator: AppCoordinator?
    private let disposeBag = DisposeBag()
    var isLogin: Bool = true
    
    init(input: Input = Input(), output: Output = Output(), coordinator: AppCoordinator?) {
        self.input = input
        self.output = output
        self.coordinator = coordinator
        viewTransition()
    }
    
    // MARK: - Coordinator
    private func viewTransition() {
        // 1. 로그인 여부 데이터 얻기
        input.viewDidLoadTrigger
            .withUnretained(self)
            .subscribe(onNext: { owner, action in
                // 2. AppCoordinator에 로그인 여부 보내기
                owner.coordinator?.checkLogin(isLogin: owner.isLogin)
            })
            .disposed(by: disposeBag)
    }
}
