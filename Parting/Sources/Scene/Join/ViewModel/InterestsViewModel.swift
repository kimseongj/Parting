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
        let pushDetailInterestViewTrigger: PublishSubject<[String]> = PublishSubject()
    }
    
    struct Output {
        let categoryRelay: BehaviorRelay<[CategoryDTO]> = BehaviorRelay(value: [])
        let selectedIDRelay: BehaviorRelay<[String]> = BehaviorRelay(value: [])
    }
    
    var input: Input
    var output: Output
    
    private weak var coordinator: JoinCoordinator?
    private let disposeBag = DisposeBag()
    
    var categoryList: [CategoryDTO] = []
    var selectedIDList: [String] = []
    
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
                        let categoryName = owner.changeCategory(name: result.result.categories[idx].categoryName)
                        
                        owner.categoryList.append(CategoryDTO(id: result.result.categories[idx].categoryID,
                                                                               name: categoryName)
                            )
                    }
                    owner.output.categoryRelay.accept(owner.categoryList)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func changeCategory(name: String) -> String {
        switch name {
        case "관람팟":
            return "관람"
        case "문화생활팟":
            return "문화생활"
        case "한잔팟":
            return "술"
        case "오락팟":
            return "오락"
        case "한입팟":
            return "음식"
        case "운동팟":
            return "운동"
        case "자기개발팟":
            return "자기개발"
        case "카페팟":
            return "카페"
        default:
            return "관람"
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
            .subscribe(onNext: { owner, _ in
                owner.pushDetailInterestsViewController(categoryIDs: owner.selectedIDList)
            })
            .disposed(by: disposeBag)
    }
    
    func addSelected(index: Int) {
        let categoryID = categoryList[index].id
        
        selectedIDList.append(categoryID)
        output.selectedIDRelay.accept(selectedIDList)
    }
    
    func removeSelected(index: Int) {
        let categoryID = categoryList[index].id
        
        selectedIDList.removeAll { $0 == categoryID }
        output.selectedIDRelay.accept(selectedIDList)
    }
    
    private func popInterestsViewController() {
        self.coordinator?.popInterestsViewController()
    }
    
    private func pushDetailInterestsViewController(categoryIDs: [String]) {
        self.coordinator?.pushDeteilInterestsViewController(categoryIDList: categoryIDs)
    }
}
