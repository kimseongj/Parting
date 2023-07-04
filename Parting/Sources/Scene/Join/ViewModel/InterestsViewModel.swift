//
//  InterestsViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/04/20.
//

import UIKit
import RxSwift
import RxCocoa


protocol InterestsViewModelProtocol {
    func viewDidLoadAction()
}

class InterestsViewModel: BaseViewModel, InterestsViewModelProtocol {
    func viewDidLoadAction() {
        APIManager.shared.getCategoryAPI()
            .withUnretained(self)
            .subscribe(onNext: { owner, data in
                for idx in 0..<data.result.categories.count {
                    owner.imageDataList.append(data.result.categories[idx].imgURL)
                    owner.categoryNameList.append(data.result.categories[idx].categoryName)
                }
                owner.output.categoryImage.accept(owner.imageDataList)
            })
            .disposed(by: disposeBag)
    }
    
    struct Input {
        let popInterestsViewTrigger: PublishSubject<Void> = PublishSubject()
        let getCategoryImageTrigger: PublishSubject<Void> = PublishSubject()
        let pushDetailInterestViewTrigger: PublishSubject<[Int]> = PublishSubject()
    }
    
    struct Output {
        let categoryImage: BehaviorRelay<[String]> = BehaviorRelay(value: [])
        let categoryNames: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    }
    
    var input: Input
    var output: Output
    var imageDataList: [String] = []
    var categoryNameList: [String] = []
    var associatedNameList: [[String]] = []
    var tempAssociatedList: [String] = []
    var selectedAssociatedNameList: [[String]] = []
    var selectedCategoryNameList: [String] = []
    
    private weak var coordinator: JoinCoordinator?
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(), output: Output = Output(), coordinator: JoinCoordinator) {
        self.input = input
        self.output = output
        self.coordinator = coordinator
        viewChangeTrigger()
//        getCategoryImage()
    }
    
    func getAssociatedCategory(_ categoryId: [Int]) {
        let semaphore = DispatchSemaphore(value: 1)
        DispatchQueue.global().async {
            for categoryId in categoryId {
                semaphore.wait() // value = 0
                print("\(categoryId)  💢💢")
                APIManager.shared.getCategoryDetailList(categoryId)
                    .subscribe(onNext: {[weak self] data in
                        for idx in 0..<data.result.count {
                            self?.tempAssociatedList.append(data.result[idx].categoryDetailName)
                            print("\(data.result[idx].categoryDetailName) + \(data.result[idx].categoryDetailID) associatedCategoryName ▶️▶️")
                        }
                        self?.associatedNameList.append(self?.tempAssociatedList ?? [])
                        self?.tempAssociatedList = []
                        semaphore.signal() // value++
                    })
                    .disposed(by: self.disposeBag)
                print("🎀🎀")
            }
            semaphore.wait()
            print("\(self.associatedNameList) 💛💛")
            semaphore.signal()
        }
        
        
    }
    
    
    private func viewChangeTrigger() {
        input.popInterestsViewTrigger
            .subscribe(onNext:{ [weak self] _ in
                self?.popInterestsViewController()
            })
            .disposed(by: disposeBag)
        
        input.pushDetailInterestViewTrigger
            .subscribe(onNext: {[weak self] data in
                for ele in data {
                    self?.selectedAssociatedNameList.append(self?.associatedNameList[ele-1] ?? [])
                    self?.selectedCategoryNameList.append(self?.categoryNameList[ele-1] ?? "")
                }
                print("\(self?.associatedNameList) 💜💜")

                self?.pushDetailInterestsViewController(data, self?.selectedCategoryNameList ?? [], self?.selectedAssociatedNameList ?? [])
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
                    self.categoryNameList.append(data.result.categories[idx].categoryName)
                }
                self.output.categoryImage.accept(imageDataList)
            })
            .disposed(by: disposeBag)
    }
    
    private func popInterestsViewController() {
        self.coordinator?.popInterestsViewController()
    }
    
    private func pushDetailInterestsViewController(_ number: [Int], _ categoryNames: [String], _ associatedCategoryNames: [[String]]) {
        self.coordinator?.pushDeteilInterestsViewController(number, categoryNames, associatedCategoryNames)
    }
}
