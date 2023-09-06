//
//  SplashViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/04/17.
//

import Foundation
import RxSwift
import RxCocoa

final class SplashViewModel: BaseViewModel {
    struct Input {
        let showJoinViewController: PublishSubject<Void> = PublishSubject()
        let viewDidLoadTrigger: PublishSubject<Void> = PublishSubject()
    }
    
    struct Output {
        let calendarDays: BehaviorRelay<[Int]> = BehaviorRelay<[Int]>(value: [])
    }
    
    var input: Input
    var output: Output
    
    private weak var coordinator: AppCoordinator?
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(), output: Output = Output(), coordinator: AppCoordinator?) {
        self.input = input
        self.output = output
        self.coordinator = coordinator
        viewChangeTrgger()
        binding()
    }
    
    private func binding() {
        input.viewDidLoadTrigger
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.getCalendarInfo()
            })
            .disposed(by: disposeBag)
    }
    
    private func getCalendarInfo() {
        let api = PartingAPI.calender(
            month: 8,
            year: 2023
        )
        guard let apiURL = api.url else { return }
        guard let url = URL(string: apiURL) else { return }
        
        APIManager.shared.requestParting(
            type: CalendarResponse.self,
            url: url,
            method: .get,
            parameters: api.parameters,
            headers: api.headers) { data in
                if let response = try? data.get() {
                    self.output.calendarDays.accept(response.result)
                }
            }
    }
    
    private func viewChangeTrgger() {
        input.showJoinViewController
            .subscribe(onNext: { _ in
                self.showJoinViewController()
            })
            .disposed(by: disposeBag)
    }
    
    func showJoinViewController() {
//        self.coordinator?.showJoinViewController()
    }
}
