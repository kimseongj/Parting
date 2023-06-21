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
        let sidoCodeData: BehaviorRelay<[Int]?> = BehaviorRelay(value: nil)
        let nickNameValidate: BehaviorRelay<Bool> = BehaviorRelay(value: false)
        let duplicatedNickNameCheck: BehaviorRelay<Bool> = BehaviorRelay(value: false)
        let postResponseData: BehaviorRelay<NickNameResponse?> = BehaviorRelay(value: nil)
        let sigunguCDDictData: BehaviorRelay<[Int: [String]]?> = BehaviorRelay(value: [:])
        let sidoCDDictData: BehaviorRelay<[String: Int]?> = BehaviorRelay(value: [:])
    }
    
    var input: Input
    var output: Output
    var sidoList: [String] = []
    var sigugunList: [String] = []
    var sigugunCD: [Int] = []
    var sidoCD: [Int] = []
    var sigunguCDDict: [Int: [String]] = [:]
    var sidoCDDict: [String: Int] = [:]
    
    let checkNicknameValidate = BehaviorRelay<Bool?>(value: false)
    let checkNicknameDuplicated = BehaviorRelay<Bool?>(value: false)
    let checkBirthNotEmpty = BehaviorRelay<String?>(value: "")
    let checkAddressNotEmpty = BehaviorRelay<String?>(value: "")
    let checkJobAndGenderButtonisSelected = BehaviorRelay<Bool?>(value: false)
    
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
            .subscribe(onNext: { data in
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

                data.result.sidoInfoList.forEach {
                    self.sidoList.append($0.sidoNm)
                    self.sidoCD.append($0.sidoCD)
                }
                
                data.result.sidoInfoList.forEach {
                    let sidoCd = $0.sidoCD, sidoNm = $0.sidoNm
                    if self.sidoCDDict[sidoNm] == nil {
                        self.sidoCDDict[sidoNm] = 0
                    }
                    self.sidoCDDict[sidoNm] = sidoCd
                }
                
                data.result.sigunguInfoList.forEach {  self.sigugunCD.append($0.sigunguCD)
                }
                
                data.result.sigunguInfoList.forEach {
                    let sidoCd = $0.sidoCD,  sigunguNm = $0.sigunguNm
                    if self.sigunguCDDict[sidoCd] == nil {
                        self.sigunguCDDict[sidoCd] = []
                    }
                    self.sigunguCDDict[sidoCd]?.append(sigunguNm)
                }
                
                data.result.sigunguInfoList.forEach {
                    self.sigugunList.append($0.sigunguNm)
                }
                
                self.output.sidoListData.accept(sidoList)
                self.output.sigugunListData.accept(sigugunList)
                self.output.sigugunCodeData.accept(sigugunCD)
                self.output.sidoCDDictData.accept(sidoCDDict)
                self.output.sigunguCDDictData.accept(sigunguCDDict)
            })
            .disposed(by: disposeBag)
    }
    
    var isValidForm: Observable<Bool> {
        // check nickNameValidate
        // check nickNameDuplicated
        // check birth TextField Not empty
        // check sido, sigungu TextField Not empty
        // check Button selected
        return Observable.combineLatest(checkNicknameValidate, checkNicknameDuplicated, checkBirthNotEmpty, checkAddressNotEmpty, checkJobAndGenderButtonisSelected) { nicknameValidate, nickNameDuplicated, birth, address, jobAndGender in
            guard let nickNameValid = nicknameValidate else { return false }
            guard let nickNameDup = nickNameDuplicated else { return false }
            guard let jobAndGender = jobAndGender else { return false }
            guard !nickNameValid && !nickNameDup && birth != nil && address != nil && !jobAndGender else { return false }
            
            return true
            
        }
    }
    
    
    private func popEssentialInfoViewController() {
        self.coordinator?.popJoinCompleteViewController()
    }
    
    private func pushInterestsViewController() {
        self.coordinator?.pushInterestsViewController()
    }
    
}
