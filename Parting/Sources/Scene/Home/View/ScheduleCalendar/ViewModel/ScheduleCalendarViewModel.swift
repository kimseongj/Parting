//
//  ScheduleCalendarViewModel.swift
//  Parting
//
//  Created by kimseongjun on 1/29/24.
//

import Foundation
import RxSwift
import RxCocoa

final class ScheduleCalendarViewModel {
    private let disposeBag = DisposeBag()
    private let coordinator: HomeCoordinator?
    
    enum Input {
        case viewWillAppear
        case partyCellClicked
    }
    
    struct Output {
        let partyDateListRelay: BehaviorRelay<Set<Date>> = BehaviorRelay(value: [])
        let partyListRelay: BehaviorRelay<[PartyInfoWithDday]> = BehaviorRelay(value: [])
        let hasPartyRelay: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    }
    
    var input = PublishSubject<Input>()
    var output: Output = Output()
    private var partyIDList: [Int] = []
    private var partyDateList: Set<Date> = []
    private var hasParty: Bool = false
    
    init(coordinator: HomeCoordinator?) {
        self.coordinator = coordinator
    }
    
    private func bindInput() {
        input
            .withUnretained(self)
            .subscribe(onNext: { owner, input in
                switch input {
                case .viewWillAppear:
                    owner.fetchPartyDetails(date: Date())
                    print("asd")
                case .partyCellClicked:
                    print("zxc")
                }
            })
            .disposed(by: disposeBag)
    }
    
    func fetchNowMonth() -> String {
        
        let month = DateFormatterManager.dateFormatter.makeNowMonthDate()
        return month
    }
    
    func fetchPartyDetails(date: Date) {
        let year = DateFormatterManager.dateFormatter.makeYearInt(date: date)
        let month = DateFormatterManager.dateFormatter.makeMonthInt(date: date)
        let userLatitude = UserLocationManager.userLat
        let userLongitude = UserLocationManager.userLng
        
        let api = PartingAPI.detailCalendar(month: month,
                                            year: year,
                                            userLatitude: userLatitude,
                                            userLongitude: userLongitude)
        guard let apiURLString = api.url, let url = URL(string: apiURLString) else { return }
        
        APIManager.shared.requestPartingWithObservable(
            type: CalendarDetailResponse.self,
            url: url,
            method: .get,
            parameters: api.parameters,
            headers: api.headers)
        .withUnretained(self)
        .subscribe(onNext: { owner, response in
            if let data = try? response.get() {
                var partyInfoList: [PartyInfoWithDday] = []
                
                if data.result.isEmpty {
                    owner.output.hasPartyRelay.accept(false)
                } else {
                    owner.output.hasPartyRelay.accept(true)
                }

                data.result.forEach {
                    owner.partyDateList.insert(owner.makeIntToDate(year: year, month: month, day: $0.day))
                    
                    let day = $0.day
                    let dDay = owner.makeDday(year: year, month: month, day: $0.day)
                    
                    $0.parties.forEach {
                        let partyInfoWithDday = PartyInfoWithDday(day: day, dDay: dDay,
                                                                  address: $0.address,
                                                                  distance: $0.distance,
                                                                  distanceUnit: $0.distanceUnit,
                                                                  partyName: $0.partyName)
                        partyInfoList.append(partyInfoWithDday)
                    }
                }
                
                owner.output.partyDateListRelay.accept(owner.partyDateList)
                owner.output.partyListRelay.accept(partyInfoList)
            }
        })
        .disposed(by: disposeBag)
    }
    
    func pushPartyDetailVC(id: Int) {
        coordinator?.pushDetailPartyVC(partyId: id)
    }
    
    private func makeIntToDate(year: Int, month: Int, day: Int) -> Date {
        let stringDate = String(year) + "-" + String(month) + "-" + String(day)
        
        return DateFormatterManager.dateFormatter.makeDateFrom(stringDate: stringDate)
    }
    
    private func makeDday(year: Int, month: Int, day: Int) -> Int {
        let stringDate = String(year) + "-" + String(month) + "-" + String(day)
        let currentDate = Calendar.current.startOfDay(for: Date())
        let eventDate = Calendar.current.startOfDay(for: DateFormatterManager.dateFormatter.makeDateFrom(stringDate: stringDate))
        
        let timeInterval = eventDate.timeIntervalSince(currentDate)
        let dDay = timeInterval / (60 * 60 * 24)
        
        return Int(dDay)
    }
}
// 여기서 공부한점 Calendar ?? // timeIntervalSince
