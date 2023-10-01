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
        let didSelectCell = PublishSubject<Int>()
        let viewDidLoad = PublishSubject<Void>()
        let viewWillAppear = PublishSubject<Void>()
    }
    
    struct Output {
        let partyList: BehaviorRelay<[PartyListItemModel]> = BehaviorRelay(value: [])
        let reloadData = PublishSubject<Void>()
    }
    
    
    private let disposeBag = DisposeBag()
    
    var input: Input
    var output: Output
    
    private weak var coordinator: HomeCoordinator?
    
    private let category: CategoryModel
    private let apiModel: PartyTabResponse
    private var partyListItemModels: [PartyListItemModel] = []
    
    var currentPage: Int
    
    init(
        input: Input = Input(),
        output: Output = Output(),
        coordinator: HomeCoordinator?,
        category: CategoryModel,
        apiModel: PartyTabResponse
    ) {
        self.category = category
        self.input = input
        self.output = output
        self.coordinator = coordinator
        self.apiModel = apiModel
        self.currentPage = 0
        getDetailPartyList(model: apiModel)
        setupBindings()
    }
    
    func getDetailPartyList(model: PartyTabResponse) {
        let api = PartingAPI.parties(params: model)
        guard let apiURL = api.url else { return }
        guard let url = URL(string: apiURL) else { return }
        
        APIManager.shared.requestParting(
            type: PartyListResponse.self,
            url: url,
            method: .get,
            parameters: api.parameters,
            headers: api.headers) { response in
                switch response {
                case let .success(data):
                    self.partyListItemModels = []
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
                    self.output.partyList.accept(self.partyListItemModels)
                    print(self.output.partyList.value.count, "파티 리스트 갯수")
                    self.output.reloadData.onNext(())
                case let .failure(error):
                    print(error)
                }
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
        
        input.viewWillAppear
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.getDetailPartyList(model: owner.apiModel)
            })
            .disposed(by: disposeBag)
        
        input.viewDidLoad
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.getDetailPartyList(model: owner.apiModel)
            })
            .disposed(by: disposeBag)
        
        input.didSelectCell
            .withUnretained(self)
            .subscribe(onNext: { owner, partyId in
                owner.pushDetailInfoVC(partyId: partyId)
            })
            .disposed(by: disposeBag)
        
    } /* End func setupBindings() */
    
    
    private func pushDetailInfoVC(partyId: Int) {
        self.coordinator?.pushDetailPartyVC(partyId: partyId)
    }
}

