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
        let BirthTextFieldTrigger: PublishSubject<Date> = PublishSubject()
        let checkNicknameTrigger: PublishSubject<String?> = PublishSubject()
        let duplicatedNickNameTrigger: PublishSubject<String?> = PublishSubject()
        let postEssentialInfoTrigger: PublishSubject<Void> = PublishSubject()
    }
    
    struct Output {
        let birthDateData: BehaviorRelay<[String]?> = BehaviorRelay(value: nil)
        let sidoListData: BehaviorRelay<[String]?> = BehaviorRelay(value: nil)
        let sigugunListData: BehaviorRelay<[String]?> = BehaviorRelay(value: nil)
        let sigugunCodeData: BehaviorRelay<[Int]?> = BehaviorRelay(value: nil)
        let nickNameValidate: BehaviorRelay<Bool> = BehaviorRelay(value: false)
        let duplicatedNickNameCheck: BehaviorRelay<Bool> = BehaviorRelay(value: false)
        let postResponseData: BehaviorRelay<NickNameResponse?> = BehaviorRelay(value: nil)
    }
    
    var input: Input
    var output: Output
    var sidoList: [String] = []
    var sigugunList: [String] = []
    var sigugunCD: [Int] = []
    
    private weak var coordinator: JoinCoordinator?
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(), output: Output = Output(), coordinator: JoinCoordinator?) {
        self.input = input
        self.output = output
        self.coordinator = coordinator
        viewChangeTrigger()
        datePickerValueChanged()
        getAddress()
        duplicatedNickNameCheck()
    }
    
    func postEssentialInfo(_ birth: String, _ job: String, _ nickName: String, _ sex: String, _ sigunguCd: Int) {
        APIManager.shared.enterEssentialInfo(birth, job, nickName, sex, sigunguCd)
            .subscribe(onNext: {[weak self] data in
                print("\(data) 🔥🔥")
            })
            .disposed(by: disposeBag)
    }
    
    private func duplicatedNickNameCheck() {
        input.duplicatedNickNameTrigger
            .flatMap { nickName in
                APIManager.shared.checkValidateNickName(nickName ?? "")
            }
            .subscribe(onNext: { data in
                self.output.duplicatedNickNameCheck.accept(data.isSuccess)
            })
            .disposed(by: disposeBag)
    }
    
    func nicknameValidCheck(_ nickname: String) -> Bool {
        //MARK: - 닉네임 정규식 표현
        let regexPattern = "^[a-zA-Z0-9가-힣_-]{2,16}$"
        let nicknamePredicate = NSPredicate(format: "SELF MATCHES %@", regexPattern)
        return nicknamePredicate.evaluate(with: nickname)
    }
    
    private func datePickerValueChanged() {
        input.BirthTextFieldTrigger
            .subscribe(onNext: { date in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateString = dateFormatter.string(from: date)
                let birthDate: [String] = dateString.split(separator: "-").map{String($0)}
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
            .flatMap { _ in
                APIManager.shared.getRegionAPI()
            }
            .subscribe(onNext: {[weak self] data in
                guard let self else { return }
                for idx in 0..<data.result.sidoInfoList.count {
                    sidoList.append(data.result.sidoInfoList[idx].sidoNm)
                }
                for idx in 0..<data.result.sigunguInfoList.count {
                    sigugunList.append(data.result.sigunguInfoList[idx].sigunguNm)
                }
                
                for idx in 0..<data.result.sigunguInfoList.count {
                    sigugunCD.append(data.result.sigunguInfoList[idx].sigunguCD)
                }
                self.output.sidoListData.accept(sidoList)
                self.output.sigugunListData.accept(sigugunList)
                self.output.sigugunCodeData.accept(sigugunCD)
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
