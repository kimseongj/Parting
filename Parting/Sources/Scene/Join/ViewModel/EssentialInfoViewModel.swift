//
//  EssentialInfoViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/04/20.
//

import UIKit
import RxSwift
import RxCocoa

class EssentialInfoViewModel: BaseViewModel {
    struct Input {
        let popEssentialViewTrigger: PublishSubject<Void> = PublishSubject()
        let pushInterestsViewTrigger: PublishSubject<Void> = PublishSubject()
        let getAddressTrigger: PublishSubject<Void> = PublishSubject()
        let yearTextFieldTrigger: PublishSubject<Date> = PublishSubject()
    }
    
    struct Output {
        let birthDateData: BehaviorRelay<[String]?> = BehaviorRelay(value: nil)
    }
    
    var input: Input
    var output: Output
    
    private weak var coordinator: JoinCoordinator?
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(), output: Output = Output(), coordinator: JoinCoordinator?) {
        self.input = input
        self.output = output
        self.coordinator = coordinator
        viewChangeTrigger()
        datePickerValueChanged()
        getAddress()
    }
    
    private func datePickerValueChanged() {
        input.yearTextFieldTrigger
            .subscribe(onNext: { date in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let dateString = dateFormatter.string(from: date)
                let startIndex = dateString.index(dateString.startIndex, offsetBy: 0)// 사용자지정 시작인덱스
                let endIndex = dateString.index(dateString.startIndex, offsetBy: 10)
                let slicedDate: String = String(dateString[startIndex..<endIndex])
                let birthDate: [String] = slicedDate.split(separator: "-").map{String($0)}
                self.output.birthDateData.accept(birthDate)
            })
            .disposed(by: disposeBag)
    }
    
    private func viewChangeTrigger() {
        input.popEssentialViewTrigger
            .subscribe(onNext:{ _ in
                self.popEssentialInfoViewController()
            })
            .disposed(by: disposeBag)
        
        input.pushInterestsViewTrigger
            .subscribe(onNext: { _ in
                self.pushInterestsViewController()
            })
            .disposed(by: disposeBag)
    }
    private func getAddress() {
        input.getAddressTrigger
            .subscribe(onNext: { _ in
                
            })
            .disposed(by: disposeBag)
    }
    
    
    private func popEssentialInfoViewController() {
        self.coordinator?.popJoinCompleteViewController()
    }
    
    private func pushInterestsViewController() {
        self.coordinator?.pushInterestsViewController()
    }
    
}
