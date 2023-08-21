//
//  PartyListViewModel.swift
//  Parting
//
//  Created by 김민규 on 2023/07/11.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

class PartyListViewModel: BaseViewModel {
    
    struct Input {
        let popVCTrigger = PublishSubject<Void>()
        let pushCreatePartyVCTrigger = PublishSubject<Void>()
        let updateAssociatedCategoriesTrigger = PublishSubject<IndexPath>()
        let updateSortingOptionTrigger = PublishSubject<SortingOption>()
    }
    
    struct Output {
        let associatedCategories: BehaviorRelay<[CategoryDetail]> = BehaviorRelay(value: [])
        let associatedCategoriesToRequest: BehaviorRelay<[(CategoryDetail, Bool)]> = BehaviorRelay(value: [])
        let partyList: BehaviorRelay<[PartyListItemModel]> = BehaviorRelay(value: [])
        let sortingOptions: BehaviorRelay<[String]> = BehaviorRelay(value: [SortingOption.numberOfPeople(.none).displayName, SortingOption.time(.none).displayName, "지도"])
        let currentSortingOption1: BehaviorRelay<SortingOption.NumberOfPeopleType> = BehaviorRelay(value: .none)
        let currentSortingOption2: BehaviorRelay<SortingOption.TimeType> = BehaviorRelay(value: .closest)
        let isLoadingMore: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    }
    
    
    private let disposeBag = DisposeBag()
    
    var input: Input
    var output: Output
    
    private weak var coordinator: HomeCoordinator?
    
    private let category: CategoryModel
    
    var currentPage: Int
    
    var categoryDetailIdsToRequest: [Int] {
        
        var ids = [Int]()

        self.output.associatedCategoriesToRequest.value.forEach { (categoryDetail, shouldRequest) in
            if shouldRequest {
                ids.append(categoryDetail.categoryDetailID)
            }
        }
        
        return ids
    }
    
    init(input: Input = Input(), output: Output = Output(), coordinator: HomeCoordinator?, category: CategoryModel) {
        self.category = category
        self.input = input
        self.output = output
        self.coordinator = coordinator
        
        self.currentPage = 0
        
        setupBindings()
        loadPartyList()
    }
    
    
    // MARK: Data Fetching
    func loadPartyList() {
        
        Task {
            
            guard let associatedCategories = try? await APIManager.shared
                .getCategoryDetailList(categoryId: category.id) else { return }
            
            let firstCategoryDetailId = associatedCategories[0].categoryDetailID
            
            guard let parties = try? await APIManager.shared
                .getPartyList(
                    categoryId: category.id,
                    categoryDetailIds: [firstCategoryDetailId],
                    orderCondition1: .few,
                    orderCondition2: .latest,
                    pageNumber: 0,
                    location: CLLocation(
                        latitude: 35.232324,
                        longitude: 126.32323
                    )
                ) else { return }
            
            print(parties, "🌆🌆🌆")
            
            self.output.partyList.accept(parties)
            self.output.associatedCategories.accept(associatedCategories)
            print(parties, "통신성공")
            let categoryDetailsToRequest = associatedCategories.enumerated().map({ (index, categoryDetail) in
                return index == 0 ? (categoryDetail, true) : (categoryDetail, false)
            })

            self.output.associatedCategoriesToRequest.accept(categoryDetailsToRequest)
            
            
        } /* End Task */
        
    }
    
    func loadPartyListMore() {
        if output.isLoadingMore.value {
            return
        }
        
        self.output.isLoadingMore.accept(true)
        
        let orderCondition1 = self.output.currentSortingOption1.value
        let orderCondition2 = self.output.currentSortingOption2.value
        let detailIds = self.categoryDetailIdsToRequest
        
        self.currentPage += 1
        
        Task {
            guard let parties = try? await APIManager.shared
                .getPartyList(categoryId: category.id, categoryDetailIds: detailIds, orderCondition1: orderCondition1, orderCondition2: orderCondition2, pageNumber: currentPage, location: CLLocation(latitude: 35.232324, longitude: 126.32323)) else {
                self.output.isLoadingMore.accept(false)
                return
            }

            let newParties = self.output.partyList.value + parties
            self.output.partyList.accept(newParties)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.output.isLoadingMore.accept(false)
            }
        }
        
    }
    
    private func updatePartyList(orderCondition1: SortingOption.NumberOfPeopleType, orderCondition2: SortingOption.TimeType) {
        
        self.currentPage = 0
        
        let uncapturedList = self.categoryDetailIdsToRequest
        
        Task {
            
            guard let parties = try? await APIManager.shared
                .getPartyList(categoryId: category.id, categoryDetailIds: uncapturedList, orderCondition1: orderCondition1, orderCondition2: orderCondition2, pageNumber: 0, location: CLLocation(latitude: 35.232324, longitude: 126.32323)) else {

                return
            }
            
            self.output.partyList.accept(parties)
        }
        
    }
    
    
    // MARK: Bindings
    private func setupBindings() {
        input.popVCTrigger
            .subscribe(onNext: { [weak self] in
                self?.coordinator?.popVC()
            })
            .disposed(by: disposeBag)
        
        input.pushCreatePartyVCTrigger
            .subscribe(onNext: { [weak self] in
                self?.coordinator?.pushCreatePartyVC()
            })
            .disposed(by: disposeBag)
        
        input.updateAssociatedCategoriesTrigger
            .withUnretained(self)
            .subscribe(onNext: { owner, indexPath in
                let index = indexPath[1]
                let originalList = self.output.associatedCategoriesToRequest.value
                let originalItem = originalList[index]
                let updatedItem = (originalItem.0, !originalItem.1)
                
                let updatedList = originalList.enumerated().map { (idx, item) in
                    if idx == index {
                        return updatedItem
                    } else {
                        return item
                    }
                }
                
                owner.output.associatedCategoriesToRequest.accept(updatedList)
                
                owner.updatePartyList(orderCondition1: .few, orderCondition2: .closest)
                
            })
            .disposed(by: disposeBag)
        
        input.updateSortingOptionTrigger
            .withUnretained(self)
            .subscribe(onNext: { owner, option in
                
                var option1ToRequest: SortingOption.NumberOfPeopleType = owner.output.currentSortingOption1.value
                var option2ToRequest: SortingOption.TimeType = owner.output.currentSortingOption2.value
                
                switch option {
                case .numberOfPeople(let peopleNumberOption):
                    owner.output.currentSortingOption1.accept(peopleNumberOption)
                    option1ToRequest = peopleNumberOption
                    option2ToRequest = owner.output.currentSortingOption2.value
                case .time(let timeOption):
                    owner.output.currentSortingOption2.accept(timeOption)
                    option2ToRequest = timeOption
                }
                
                owner.updatePartyList(orderCondition1: option1ToRequest, orderCondition2: option2ToRequest)

            })
            .disposed(by: disposeBag)
        
        self.output.currentSortingOption1
            .withUnretained(self)
            .subscribe(onNext: { owner, peopleNumberOption in
                let newOptionList = owner.output.sortingOptions.value.enumerated().map { (index, item) in
                    if index == 0 {
                        return SortingOption.numberOfPeople(peopleNumberOption).displayName
                    } else {
                        return item
                    }
                }
                
                owner.output.sortingOptions.accept(newOptionList)
            })
            .disposed(by: disposeBag)
        
        self.output.currentSortingOption2
            .withUnretained(self)
            .subscribe(onNext: { owner, timeOption in
                let newOptionList = owner.output.sortingOptions.value.enumerated().map { (index, item) in
                    if index == 1 {
                        return SortingOption.time(timeOption).displayName
                    } else {
                        return item
                    }
                }
                
                owner.output.sortingOptions.accept(newOptionList)
            })
            .disposed(by: disposeBag)
        
    } /* End func setupBindings() */
    
    
    
    
}

