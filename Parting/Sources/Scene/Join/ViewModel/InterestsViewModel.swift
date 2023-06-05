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
        let getCategoryImageTrigger: PublishSubject<Void> = PublishSubject()
    }
    
    struct Output {
        let categoryImage: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    }
    
    var input: Input
    var output: Output
    var imageDataList: [String] = []
    
    private weak var coordinator: JoinCoordinator?
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(), output: Output = Output(), coordinator: JoinCoordinator) {
        self.input = input
        self.output = output
        self.coordinator = coordinator
        viewChangeTrigger()
        getCategoryImage()
    }
    
    private func viewChangeTrigger() {
        input.viewChangeTrigger
            .subscribe(onNext:{ [weak self] _ in
                self?.popInterestsViewController()
            })
            .disposed(by: disposeBag)
    }
    
    
    private func getCategoryImage() {
        input.getCategoryImageTrigger
            .flatMap { _ in
                APIManager.shared.getCategoryAPI()
            }
            .subscribe(onNext: { [weak self] data in
                guard let self else { return } 
                for idx in 0..<data.result.categories.count {
                    self.imageDataList.append(data.result.categories[idx].imgURL)
                }
                self.output.categoryImage.accept(imageDataList)
            })
            .disposed(by: disposeBag)
    }

    func popInterestsViewController() {
        self.coordinator?.popInterestsViewController()
    }
}
