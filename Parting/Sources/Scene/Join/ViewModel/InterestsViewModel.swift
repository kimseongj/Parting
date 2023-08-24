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

final class InterestsViewModel: BaseViewModel, InterestsViewModelProtocol {
    func testObservableGeneric() {
        let api = PartingAPI.detailCategory(categoryVersion: "1.0.0")
        guard let url = URL(string: api.url!) else { return }
        APIManager.shared.requestPartingWithObservable(type: CategoryResponse.self, url: url, method: .get, parameters: api.parameters,  headers: api.headers)
            .withUnretained(self)
            .subscribe(onNext: { owner, response in
                if let result = try? response.get() {
                    print(result, "✅✅")
                    for idx in 0..<result.result.categories.count {
                        owner.imageDataList.append(result.result.categories[idx].imgURL)
                        owner.categoryNameList.append(result.result.categories[idx].categoryName)
                    }
                    owner.output.categoryImage.accept(owner.imageDataList)
                }
            })
            .disposed(by: disposeBag)
    }
    
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
                    .withUnretained(self)
                    .subscribe(onNext: { owner, data in
                        for idx in 0..<data.result.count {
                            owner.tempAssociatedList.append(data.result[idx].categoryDetailName)
                            print("\(data.result[idx].categoryDetailName) + \(data.result[idx].categoryDetailID) associatedCategoryName ▶️▶️")
                        }
                        owner.associatedNameList.append(owner.tempAssociatedList)
                        owner.tempAssociatedList = []
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
            .withUnretained(self)
            .subscribe(onNext:{ owner, _ in
                owner.popInterestsViewController()
            })
            .disposed(by: disposeBag)
        
        input.pushDetailInterestViewTrigger
            .withUnretained(self)
            .subscribe(onNext: { owner, data in
                for ele in data {
                    owner.selectedAssociatedNameList.append(owner.associatedNameList[ele-1] )
                    owner.selectedCategoryNameList.append(owner.categoryNameList[ele-1] )
                }
                print("\(owner.associatedNameList) 💜💜")

                owner.pushDetailInterestsViewController(data, owner.selectedCategoryNameList , owner.selectedAssociatedNameList )
            })
            .disposed(by: disposeBag)
    }
    
    private func getCategoryImage() {
        input.getCategoryImageTrigger
            .flatMap { _ in
                APIManager.shared.getCategoryAPI()
            }
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
    
    private func popInterestsViewController() {
        self.coordinator?.popInterestsViewController()
    }
    
    private func pushDetailInterestsViewController(_ number: [Int], _ categoryNames: [String], _ associatedCategoryNames: [[String]]) {
        self.coordinator?.pushDeteilInterestsViewController(number, categoryNames, associatedCategoryNames)
    }
}
