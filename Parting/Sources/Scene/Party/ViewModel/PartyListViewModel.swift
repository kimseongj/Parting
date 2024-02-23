//
//  PartyListViewModel.swift
//  Parting
//
//  Created by 김성준 on 2023/02/20.
//

import Foundation
import RxSwift
import RxCocoa
import CoreLocation

class PartyListViewModel: BaseViewModel {
    struct Input {
        let popVCTrigger = PublishSubject<Void>()
        let pushCreatePartyVCTrigger = PublishSubject<Void>()
        let didSelectCell = PublishSubject<Int>()
        let viewDidLoad = PublishSubject<Void>()
        let viewWillAppear = PublishSubject<Void>()
        
        var currentSortingOptionRelay: BehaviorRelay<SortingOption> = BehaviorRelay(value: .none)
        var currentPageNum: Int = 0
    }
    
    struct Output {
        let partyList: BehaviorRelay<[PartyListItemModel]> = BehaviorRelay(value: [])
        let reloadData = PublishSubject<Void>()
        let sortingOptionList: [SortingOption] = [.none, .closingDistance, .closingTime, .latest, .manyPeople, .fewPeople]
        var selectedSortingOptionIndexPath: IndexPath?
        var hasNextPage: Bool = true
        var hasParty: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    }
    
    
    private let disposeBag = DisposeBag()
    
    var input: Input
    var output: Output
    
    private weak var coordinator: HomeCoordinator?
    
    private var apiModel: PartyListQuery
    private var partyListItemModels: [PartyListItemModel] = []
    private var currentSortingOption: SortingOption = .none
    var currentPage: Int
    
    init(
        input: Input = Input(),
        output: Output = Output(),
        coordinator: HomeCoordinator?,
        apiModel: PartyListQuery
    ) {
        self.input = input
        self.output = output
        self.coordinator = coordinator
        self.apiModel = apiModel
        self.currentPage = 0
        setupBindings()
    }
    
    func getFirstDetailPartyList(model: PartyListQuery) {
        let api = PartingAPI.parties(params: model)
        guard let apiURL = api.url else { return }
        guard let url = URL(string: apiURL) else { return }
        
        APIManager.shared.requestParting(
            type: PartyListResponse.self,
            url: url,
            method: .get,
            parameters: api.parameters,
            headers: api.headers) { [weak self] response in
                guard let self = self else { return }
                
                switch response {
                case let .success(data):
                    for ele in data.result.partyInfos {
                        let partyListItemDTO = PartyListItemModel(
                            id: ele.partyId,
                            title: ele.partyName,
                            location: ele.address,
                            distance: ele.distanceUnit,
                            currentPartyMemberCount: ele.currentPartyMemberCount,
                            maxPartyMemberCount: ele.maxPartyMemberCount,
                            partyDuration: ele.partyEndTime,
                            tags: ele.hashTagNameList,
                            status: PartyStatus.recruiting,
                            imgURL: ele.categoryImg
                        )
                        self.partyListItemModels.append(partyListItemDTO)
                    }
                    if data.result.partyInfos.count != 10 {
                        self.output.hasNextPage = false
                    }
                    
                    self.output.partyList.accept(self.partyListItemModels)
                    print(self.output.partyList.value.count, "파티 리스트 갯수")
                    
                    if self.partyListItemModels.count == 0 {
                        self.output.hasParty.accept(false)
                    } else {
                        self.output.hasParty.accept(true)
                    }
                    
                    case let .failure(error):
                    print(error)
                }
            }
    }
    
    func getDetailPartyList(model: PartyListQuery) {
        let api = PartingAPI.parties(params: model)
        guard let apiURL = api.url else { return }
        guard let url = URL(string: apiURL) else { return }
        
        APIManager.shared.requestParting(
            type: PartyListResponse.self,
            url: url,
            method: .get,
            parameters: api.parameters,
            headers: api.headers) { [weak self] response in
                guard let self = self else { return }
                
                switch response {
                case let .success(data):
                    for ele in data.result.partyInfos {
                        let partyListItemDTO = PartyListItemModel(
                            id: ele.partyId,
                            title: ele.partyName,
                            location: ele.address,
                            distance: ele.distanceUnit,
                            currentPartyMemberCount: ele.currentPartyMemberCount,
                            maxPartyMemberCount: ele.maxPartyMemberCount,
                            partyDuration: ele.partyEndTime,
                            tags: ele.hashTagNameList,
                            status: PartyStatus.recruiting,
                            imgURL: ele.categoryImg
                        )
                        self.partyListItemModels.append(partyListItemDTO)
                    }
                    if data.result.partyInfos.count != 10 {
                        self.output.hasNextPage = false
                    }
                    
                    self.output.partyList.accept(self.partyListItemModels)
                    print(self.output.partyList.value.count, "파티 리스트 갯수")
                    self.output.reloadData.onNext(())
                    case let .failure(error):
                    print(error)
                }
            }
    }
    
    func sortPartyList() {
        output.hasNextPage = true
        partyListItemModels = []
        apiModel.pageNumber = 0
        apiModel.orderCondition = input.currentSortingOptionRelay.value.queryDescription
        getDetailPartyList(model: apiModel)
    }
    
    func pagePartyList() {
        apiModel.pageNumber += 1
        getDetailPartyList(model: apiModel)
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
        
        input.viewDidLoad
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.getFirstDetailPartyList(model: owner.apiModel)
            })
            .disposed(by: disposeBag)
        
        input.didSelectCell
            .withUnretained(self)
            .subscribe(onNext: { owner, partyId in
                owner.pushDetailInfoVC(partyId: partyId)
            })
            .disposed(by: disposeBag)
    }
    
    private func pushDetailInfoVC(partyId: Int) {
        self.coordinator?.pushDetailPartyVC(partyId: partyId)
    }
}
