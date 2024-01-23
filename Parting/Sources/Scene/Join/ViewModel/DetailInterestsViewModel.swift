//
//  DetailInterestsViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/06/10.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailInterestsViewModel: BaseViewModel {
    struct Input {
        let popDetailInterestsViewTrigger: PublishSubject<Void> = PublishSubject()
        let pushStartWithLoginViewTrigger: PublishSubject<Void> = PublishSubject()
    }
    
    struct Output {
        let categoryDictionaryRelay: BehaviorRelay<[String: [CategoryDetail]]> = BehaviorRelay(value: [:])
        let selectedDetailCategoryIDListRelay: BehaviorRelay<[Int]> = BehaviorRelay(value: [])
    }
    
    var input: Input
    var output: Output
    
    private weak var coordinator: JoinCoordinator?
    private let disposeBag = DisposeBag()
    
    var categoryIDList: [String]
    var categoryDictionary: [String: [CategoryDetail]] = [:]
    var selectedDetailCategoryIDList: [Int] = []
    
    init(input: Input = Input(), output: Output = Output(), coordinator: JoinCoordinator, categoryIDList: [String]) {
        self.input = input
        self.output = output
        self.coordinator = coordinator
        self.categoryIDList = categoryIDList
        viewChangeTrigger()
    }
     
    private func viewChangeTrigger() {
        input.popDetailInterestsViewTrigger
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.popDetailInterestsViewController()
            })
            .disposed(by: disposeBag)
        
        input.pushStartWithLoginViewTrigger
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                
                owner.coordinator?.pushStartWithLoginViewController()
            })
            .disposed(by: disposeBag)
    }
    
    private func popDetailInterestsViewController() {
        self.coordinator?.popDetailInterestsViewController()
    }
    
    //MARK: - 카테고리별 세부 항목 API
    func getAssociatedCategory() {
        let semaphore = DispatchSemaphore(value: 1)
        
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            
            for categoryId in self.categoryIDList {
                let api = PartingAPI.associatedCategory(categoryId: Int(categoryId)!)
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
                        owner.categoryDictionary[data.result.categoryName] = data.result.categoryDetailList
                        semaphore.signal() // value++
                    }
                    
                    if categoryId == owner.categoryIDList.last {
                        self.output.categoryDictionaryRelay.accept(self.categoryDictionary)
                        print("🎀🎀\(owner.categoryDictionary)")
                    }
                    
                })
                .disposed(by: self.disposeBag)
            }
        }
    }
    
    func postDetailInterests() {
        let api = PartingAPI.interest(categoryVersion: "1.0.0", ids: selectedDetailCategoryIDList)
        guard let apiUrl = api.url else { return }
        guard let url = URL(string: apiUrl) else { return }
        APIManager.shared.requestPartingWithObservable(
            type: BasicResponse.self,
            url: url,
            method: .post,
            parameters: api.parameters,
            encoding: .default,
            headers: api.headers)
        .withUnretained(self)
        .subscribe(onNext: { owner, response in
            print(response)
        })
        .disposed(by: disposeBag)
    }

    func addSelectedDetailCategoryID(_ id: Int) {
        selectedDetailCategoryIDList.append(id)
        output.selectedDetailCategoryIDListRelay.accept(selectedDetailCategoryIDList)
    }
    
    func removeSelectedDetailCategoryID(_ id: Int) {
        selectedDetailCategoryIDList.removeAll(where: { $0 == id })
        output.selectedDetailCategoryIDListRelay.accept(selectedDetailCategoryIDList)
    }
}
