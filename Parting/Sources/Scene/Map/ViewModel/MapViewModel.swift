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
    struct Input {
        let pushPartyDetailTrigger: PublishSubject<Void> = PublishSubject()
    }
    
    struct Output {
        var aroundPartyList: BehaviorRelay<[PartyInfoOnMapList]> = BehaviorRelay<[PartyInfoOnMapList]>(value: [])
        var selectedParty: BehaviorRelay<MarkerPartyInfo> = BehaviorRelay<MarkerPartyInfo>(value: MarkerPartyInfo(address: "", categoryImg: "", currentPartyMemberCount: 0, description: "", distance: 0, distanceUnit: "", hashTagNameList: [""], maxPartyMemberCount: 0, partyEndTime: "", partyID: 0, partyName: "", partyStartTime: "", status: ""))
    }
    
    struct State {
        var aroundPartyList: BehaviorRelay<[PartyInfoOnMapList]> = BehaviorRelay<[PartyInfoOnMapList]>(value: [])
    }
    
    var input = Input()
    var output = Output()
    var state = State()
    var partyInfoOnMapList: [PartyInfoOnMapList] = []
    var partyOnMapList: [Int] = []
    var selectedPartyID: Int = 0
    
    private var mapCoordinator: MapCoordinator?
    private let disposeBag = DisposeBag()
    
    init(mapCoordinator: MapCoordinator?) {
        self.mapCoordinator = mapCoordinator
    }

    func searchPartyOnMap(searchHighLatitude: Double,
                                searchHighLongitude: Double,
                                searchLowLatitude:  Double,
                                searchLowLongitude:  Double) {
        let api = PartingAPI.getAroundParty(
            searchHighLatitude: searchHighLatitude,
            searchHighLongitude: searchHighLongitude,
            searchLowLatitude:  searchLowLatitude,
            searchLowLongitude:  searchLowLongitude
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
                self.output.aroundPartyList.accept(data.result.partyInfoOnMapList)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getMapPartyDetailInfo(
        partyId: Int,
        partyLat: Double,
        partyLng: Double
    ) {
        let api = PartingAPI.getMapPartyDetailInfo(
            partyIdList: [partyId],
            userLatitude: partyLat,
            userLongitude: partyLng
        )
        
        guard let apiURL = api.url, let url = URL(string: apiURL) else { return }
        
        APIManager.shared.requestParting(
            type: AroundPartyDetailResponse.self,
            url: url,
            method: .get,
            parameters: api.parameters,
            headers: api.headers
        ) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case let .success(data):
                print(data, "💛")
                selectedPartyID = data.result.partyInfos.first?.partyID ?? 0
                self.output.selectedParty.accept(data.result.partyInfos.first!)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func pushPartyDetailViewController() {
        mapCoordinator?.pushPartyDetailVC(partyID: selectedPartyID)
    }
}
