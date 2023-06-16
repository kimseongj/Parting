//
//  DetailInterestsViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/06/10.
//

import UIKit
import RxSwift
import RxCocoa

class DetailInterestsViewModel: BaseViewModel {
    struct Input {
        let popDetailInterestsViewTrigger: PublishSubject<Void> = PublishSubject()
    }
    
    struct Output {
    }
    
    var input: Input
    var output: Output
    var count: BehaviorRelay<[Int]>
    var categoryNameList: BehaviorRelay<[String]>
    var associatedNameList: BehaviorRelay<[[String]]>
    
    private weak var coordinator: JoinCoordinator?
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(), output: Output = Output(), coordinator: JoinCoordinator, cellList: [Int], categoryNameList: [String], associatedNameList: [[String]]) {
        self.input = input
        self.output = output
        self.coordinator = coordinator
        self.count = BehaviorRelay(value: cellList)
        self.categoryNameList = BehaviorRelay(value: categoryNameList)
        self.associatedNameList = BehaviorRelay(value: associatedNameList)
        viewChangeTrigger()
    }
    
    private func viewChangeTrigger() {
        input.popDetailInterestsViewTrigger
            .subscribe(onNext: {[weak self] _ in
                self?.popDetailInterestsViewController()
            })
            .disposed(by: disposeBag)
    }
    
    private func popDetailInterestsViewController() {
        self.coordinator?.popDetailInterestsViewController()
    }
}
