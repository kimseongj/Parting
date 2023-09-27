//
//  MapViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/07/14.
//

import Foundation
import RxSwift
import RxCocoa

final class MapViewModel {
    enum Input {
        case viewWillAppearTrigger
        case viewDidLoadTrigger
        case markerClicked(data: MapDetailPartyDTO)
    }
    
    enum Output {
        
    }
    
    struct State {
        var aroundPartyList: BehaviorRelay<[PartyInfoOnMapList]> = BehaviorRelay<[PartyInfoOnMapList]>(value: [])
    }
    
    var input: PublishSubject<Input> = PublishSubject()
    var state = State()
    var partyDetailInfo: [PartyInfoOnMapList] = []
    
    private var mapCoordinator: MapCoordinator?
    private let disposeBag = DisposeBag()
    
    init(mapCoordinator: MapCoordinator?) {
        self.mapCoordinator = mapCoordinator
        bind()
    }
    
    private func bind() {
        input
            .withUnretained(self)
            .subscribe(onNext: { owner, event in
                switch event {
                case .viewWillAppearTrigger:
                    owner.getAroundParty()
                case .viewDidLoadTrigger:
                    owner.getAroundParty()
                case let .markerClicked(data):
                    for ele in owner.partyDetailInfo {
                        print(data.partyLatitude, ele.partyLatitude)
                        if data.partyLatitude == ele.partyLatitude {
                            print(ele.partyID, ele.partyLatitude, ele.partyLongitude, "✅")
                            owner.getMapPartyDetailInfo(
                                partyId: ele.partyID,
                                partyLat: ele.partyLatitude,
                                partyLng: ele.partyLongitude
                            )
                            break
                        }
                    }
                }
                
            })
            .disposed(by: disposeBag)
    }
    
    private func getAroundParty() {
        let api = PartingAPI.getAroundParty(
            searchHighLatitude: 37.51895456923172,
            searchHighLongitude: 126.88782916277418,
            searchLowLatitude:  37.517739605481474,
            searchLowLongitude:  126.88459585441812
        )
        
        guard let apiurl = api.url else { return }
        guard let url = URL(string: apiurl) else { return }
        
        print(url, "🌆")

        APIManager.shared.requestParting(
            type: AroundPartyResponse.self,
            url: url,
            method: .get,
            parameters: api.parameters,
            headers: api.headers
        ) { response in
                switch response {
                case let .success(data):
                    print(data, "✅")
                    print(data.result)
                    self.state.aroundPartyList.accept(data.result.partyInfoOnMapList)
                case let .failure(error):
                    print(error)
                }
            }
    }
    
    private func getMapPartyDetailInfo(
        partyId: Int,
        partyLat: Double,
        partyLng: Double
    ) {
        let api = PartingAPI.getMapPartyDetailInfo(
            partyIdList: [partyId],
            userLatitude: partyLat,
            userLongitude: partyLng
        )
        
        guard let apiURL = api.url else { return }
        guard let url = URL(string: apiURL) else { return }
        
        APIManager.shared.requestParting(
            type: AroundPartyDetailResponse.self,
            url: url,
            method: .get,
            parameters: api.parameters,
            headers: api.headers
        ) { response in
            switch response {
            case let .success(data):
                print(data, "💛")
                self.showBottomSheetVC(data: data)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    private func showBottomSheetVC(data: AroundPartyDetailResponse) {
        self.mapCoordinator?.showPartyDetailBottomsheetVC(data: data)
    }
}
