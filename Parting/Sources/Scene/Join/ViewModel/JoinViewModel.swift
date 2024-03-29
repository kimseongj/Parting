//
//  JoinViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/04/17.
//

import Foundation
import RxSwift
import RxCocoa

final class JoinViewModel: BaseViewModel{
   
    struct Input {
        let viewChangeTrigger: PublishSubject<Void> = PublishSubject()
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
        input.viewChangeTrigger
            .subscribe(onNext: { [weak self] _ in
                print(self?.coordinator, "coordi")
                self?.pushUserAgreementVC()
            })
            .disposed(by: disposeBag)
    }
    
    func pushUserAgreementVC() {
        self.coordinator?.pushUserAgreementViewController()
    }
}
