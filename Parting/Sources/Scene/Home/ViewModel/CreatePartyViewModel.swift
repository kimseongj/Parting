//
//  CreatePartyViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/07/22.
//

import UIKit
import RxSwift
import RxCocoa

final class CreatePartyViewModel: BaseViewModel {
    struct Input {
        let popVCTrigger = PublishSubject<Void>()
        // 뷰모델이 클릭한 Cell에 대한 상태 물고있어야함
        let partyCellClickedState =  PublishSubject<Int>()
        let setMapVCTrigger = PublishSubject<Void>()
        let detailCategoryCellSelectedIndexPath = PublishSubject<Int>()
    }
    
    struct Output {
        let categories: BehaviorRelay<[CategoryModel]> = BehaviorRelay(value: [])
        let categoryImages: BehaviorRelay<[CategoryModel]> = BehaviorRelay(value: [])
        let categoryDetailLists: BehaviorRelay<[CategoryDetailResultContainisSelected]> = BehaviorRelay(value: [])
        let categoryDetailResponses: BehaviorRelay<[CategoryResponse]> = BehaviorRelay(value: [])
    }
    
    var input: Input
    var output: Output
    
    var categoryDetailListsData: [CategoryDetailResult]?
    var isSeletedCellIdx: BehaviorSubject<Int?> = BehaviorSubject(value: nil)
    var selectedIndex: Int?
    var selectedDetailCategoryCell = BehaviorRelay<Set<Int>>(value: [])
    private let disposeBag = DisposeBag()
    private var coordinator: HomeCoordinator?
    var toastMessage = BehaviorRelay<String>(value: "")
    
    init(input: Input = Input(), output: Output = Output(), coordinator: HomeCoordinator?) {
        self.input = input
        self.output = output
        self.coordinator = coordinator
        loadCategories()
        changeVC()
        bind()
    }
    
    func createPartyAPICall(
        _ address: String,
        _ capacity: Int,
        _ categoryDetailIDList: [Int],
        _ categoryId: Int,
        _ hashTagNameList: [String],
        _ maxAge: Int,
        _ minAge: Int,
        _ openChattingRoomURL: String,
        _ partyDescription: String,
        _ partyEndDateTime: String,
        _ partyLatitude: Double,
        _ partyLongitude: Double,
        _ partyName: String,
        _ partyStartDateTime: String,
        _ storeName: String) {
        APIManager.shared.createPartyPost(
            address,
            capacity,
            categoryDetailIDList,
            categoryId,
            hashTagNameList,
            maxAge,
            minAge,
            openChattingRoomURL,
            partyDescription,
            partyEndDateTime,
            partyLatitude,
            partyLongitude,
            partyName,
            partyStartDateTime,
            storeName) { statusCode in
            print(statusCode, "상태코드 💜")
        }
    }
    
    private func bind() {
        input.detailCategoryCellSelectedIndexPath
            .bind { [weak self] index in
                var curSelectedDetailCategoryCell =  self?.selectedDetailCategoryCell.value
                if curSelectedDetailCategoryCell?.count ?? 0 >= 2 {
                    self?.toastMessage.accept("최대 2개까지 중복선택 가능합니다.")
                    
                } else {
                    curSelectedDetailCategoryCell?.insert(index)
                    self?.selectedDetailCategoryCell.accept(curSelectedDetailCategoryCell ?? [])
                }
            }
            .disposed(by: disposeBag)
        
        input.partyCellClickedState
            .flatMap { [weak self] id in
                APIManager.shared.getCategoryDetailList(id)
            }
            .subscribe(onNext: { [weak self] data in
                self?.categoryDetailListsData = data.result
                var newData: [CategoryDetailResultContainisSelected] = []
                guard let arr =  self?.categoryDetailListsData else { return }
                for ele in arr {
                    let data = CategoryDetailResultContainisSelected(categoryDetailID: ele.categoryDetailID, categoryDetailName: ele.categoryDetailName)
                    newData.append(data)
                }
                self?.output.categoryDetailLists.accept(newData)
            })
            .disposed(by: disposeBag)
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
            .withUnretained(self)
            .subscribe(onNext: {owner, _ in
                owner.coordinator?.popVC()
            })
            .disposed(by: disposeBag)
        
        input.setMapVCTrigger
            .withUnretained(self)
            .subscribe(onNext: {owner, _ in
                owner.coordinator?.pushSetMapVC()
            })
            .disposed(by: disposeBag)
    }
    
}
