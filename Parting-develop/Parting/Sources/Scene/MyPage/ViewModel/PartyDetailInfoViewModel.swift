//
//  ShowDetailPartyViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/08/29.
//

import Foundation
import RxSwift
import RxCocoa

class PartyDetailInfoViewModel {
    enum Input {
        case viewDidLoadTrigger
        case perssonelInfo(userId: Int)
    }
    
    enum Output {
        case detailPartyResponseData
    }
    
    private var coordinator: MyPageCoordinator?
    private let disposeBag = DisposeBag()
    let partyId: Int?
    let input = PublishSubject<Input>()
    let ouput = PublishSubject<Output>()
    var partyDetailData: DetailPartyInfoResponse?
    var partyTypeDataList: BehaviorRelay<[String]> = BehaviorRelay<[String]>(value: [])
    var hashTagDataList: BehaviorRelay<[String]> = BehaviorRelay<[String]>(value: [])
    var perssonalDataList: BehaviorRelay<[PartyMemberList]> = BehaviorRelay<[PartyMemberList]>(value: [])
    var selectedPartyID: Int?
    
    init(coordinator: MyPageCoordinator?, partyId: Int) {
        self.coordinator = coordinator
        self.partyId = partyId
        bind()
    }
    
    private func bind() {
        input
            .withUnretained(self)
            .subscribe(onNext: { owner, input in
                switch input {
                case .viewDidLoadTrigger:
                    print(owner.partyId, "Clicked Cell 데이터 전달 💛")
                    guard let partyId = owner.partyId else { return }
                    owner.getDetailPartyInfo(partyId: partyId)
                case let .perssonelInfo(userId):
                    guard let selectedPartyID = owner.selectedPartyID else { return }
                    print("partyId는 \(selectedPartyID)야 🔥🔥, userId는 \(userId)야 🔥🔥 ")
                    owner.getUserInfo(partyId: selectedPartyID, userId: userId)
                }
            })
            .disposed(by: disposeBag)
        
    }
    
    private func getUserInfo(partyId: Int, userId: Int) {
        let api = PartingAPI.partyMember(partyId: partyId, userId: userId)
        guard let apiURL = api.url else { return }
        guard let url = URL(string: apiURL) else { return }
        APIManager.shared.requestParting(
            type: UserInfoResponse.self,
            url: url,
            method: .get,
            parameters: api.parameters,
            headers: api.headers) { data in
                if let response = try? data.get() {
                    print(response)
                }
            }
    }
    
    private func getDetailPartyInfo(partyId: Int) {
        let api = PartingAPI.getPartyDetail(partyId: partyId, userLatitude: 35, userLongitude: 35)
        guard let apiURL = api.url else { return }
        guard let url = URL(string: apiURL) else { return }
        APIManager.shared.requestParting(
            type: DetailPartyInfoResponse.self,
            url: url,
            method: .get,
            parameters: api.parameters,
            headers: api.headers) { data in
                if let response = try? data.get() {
                    self.partyDetailData = response
                    self.partyTypeDataList.accept(response.result.categoryName)
                    self.hashTagDataList.accept(response.result.hashTag)
                    self.perssonalDataList.accept(response.result.partyMemberList)
                    self.ouput.onNext(.detailPartyResponseData)
                    print(response.result.memberStatus, "memberStatus 💜💜")
                    print(response.result.partyID, "partyID 💜💜")
                    self.selectedPartyID = response.result.partyID
                }
            }
    }
    
    private func popVC() {
        self.coordinator?.popVC()
    }
    
}
