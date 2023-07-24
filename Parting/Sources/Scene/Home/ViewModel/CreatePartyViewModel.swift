//
//  CreatePartyViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/07/22.
//

import UIKit
import RxSwift
import RxCocoa

class CreatePartyViewModel: BaseViewModel {
    struct Input {
        let popVCTrigger = PublishSubject<Void>()
    }
    
    struct Output {
        let categories: BehaviorRelay<[CategoryModel]> = BehaviorRelay(value: [])
        let categoryImages: BehaviorRelay<[CategoryModel]> = BehaviorRelay(value: [])
    }
    
    var input: Input
    var output: Output
    
    private let disposeBag = DisposeBag()
    private var coordinator: HomeCoordinator?
    
    init(input: Input = Input(), output: Output = Output(), coordinator: HomeCoordinator?) {
        self.input = input
        self.output = output
        self.coordinator = coordinator
        loadCategories()
        changeVC()
    }
    
    private func loadCategories() {
        CoreDataManager.fetchCategories()
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                owner.output.categories.accept(result)
            })
            .disposed(by: disposeBag)
    }
    
    private func changeVC() {
        input.popVCTrigger
            .subscribe(onNext: {[weak self] _ in
                self?.coordinator?.popVC()
            })
            .disposed(by: disposeBag)
    }
    
}
