//
//  InterestsViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/04/20.
//

import Foundation
import RxSwift
import RxCocoa

enum CategoryTitleImage: Int, CaseIterable {
    case 문화생활
    case 관람
    case 자기개발
    case 한입
    case 운동
    case 오락
    case 카페
    case 한잔
    
    var item: String {
        switch self {
        case .관람:
            return "관람"
        case .문화생활:
            return "문화생활"
        case .한잔:
            return "술"
        case .오락:
            return "오락"
        case .한입:
            return "음식"
        case .운동:
            return "운동"
        case .자기개발:
            return "자기개발"
        case .카페:
            return "카페"
        }
    }
}

protocol InterestsViewModelProtocol {
    func getCategoryInfo()
}

final class InterestsViewModel: BaseViewModel, InterestsViewModelProtocol {
    
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
    }
    
    func getCategoryInfo() {
        let api = PartingAPI.detailCategory(categoryVersion: "1.0.0")
        guard let url = URL(string: api.url!) else { return }
        APIManager.shared.requestPartingWithObservable(
            type: CategoryResponse.self,
            url: url,
            method: .get,
            parameters: api.parameters,
            headers: api.headers
        )
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
    
    //MARK: - 카테고리별 세부 항목 API
    func getAssociatedCategory(_ categoryId: [Int]) {
        let semaphore = DispatchSemaphore(value: 1)
        
        DispatchQueue.global().async {
            for categoryId in categoryId {
                let api = PartingAPI.associatedCategory(categoryId: categoryId)
                guard let apiURL = api.url else { return }
                guard let url = URL(string: apiURL) else { return }
                semaphore.wait() // value = 0
                print("\(categoryId)  💢💢")
                APIManager.shared.requestPartingWithObservable(
                    type: CategoryDetailResponse.self,
                    url: url,
                    method: .get,
                    parameters: api.parameters,
                    headers: api.headers)
                .withUnretained(self)
                .subscribe(onNext: { owner, response in
                    if let data = try? response.get() {
                        for idx in 0..<data.result.count {
                            owner.tempAssociatedList.append(data.result[idx].categoryDetailName)
                            print("\(data.result[idx].categoryDetailName) + \(data.result[idx].categoryDetailID) associatedCategoryName ▶️▶️")
                        }
                        owner.associatedNameList.append(owner.tempAssociatedList)
                        owner.tempAssociatedList = []
                        semaphore.signal() // value++
                    }
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
    
    private func popInterestsViewController() {
        self.coordinator?.popInterestsViewController()
    }
    
    private func pushDetailInterestsViewController(_ number: [Int], _ categoryNames: [String], _ associatedCategoryNames: [[String]]) {
        self.coordinator?.pushDeteilInterestsViewController(number, categoryNames, associatedCategoryNames)
    }
}
