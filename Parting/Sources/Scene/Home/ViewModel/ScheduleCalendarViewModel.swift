//
//  ScheduleCalendarViewModel.swift
//  Parting
//
//  Created by kimseongjun on 1/29/24.
//

import Foundation
import RxSwift

final class ScheduleCalendarViewModel: BaseViewModel {
    private let disposeBag = DisposeBag()
    private let coordinator: HomeCoordinator?
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    var input: Input
    var output: Output
    private var partyIDList: [Int] = []
    private var month: String = ""
    
    init(input: Input = Input(), output: Output = Output(), coordinator: HomeCoordinator?) {
        self.input = input
        self.output = output
        self.coordinator = coordinator
    }
    
    func fetchNowMonth() -> String {
        DateFormatterManager.dateFormatter.makeMonthFormatter()
        let month = DateFormatterManager.dateFormatter.string(from: Date())
        return month
    }
    
    func fetchSchedule() {

    }
    
    func pushPartyDetailVC(id: Int) {
        coordinator?.pushDetailPartyVC(partyId: id)
    }
}
