//
//  EssentialInfoViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/04/20.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire

protocol EssentialInfoViewModelProtocol {
    var genderState: PublishRelay<Int> { get }
    var jobState: PublishRelay<Int> { get }
    var nickNameValidateState: PublishRelay<Int> { get }
    var nickNameDuplicateState: PublishRelay<Bool> { get }
    var isValidForm: Observable<Bool> { get }
    
    func tapNextButton(isValid: Bool)
    func tapGenderButton(gender: Int)
    func tapJobButton(job: Int)
    func tapDuplicatedCheckButton(nickName: String)
    func postEssentialInfo(_ birth: String, _ job: String, _ nickName: String, _ sex: String, _ sigunguCd: Int)
}

final class EssentialInfoViewModel: BaseViewModel, EssentialInfoViewModelProtocol {
    
    struct Input {
        let popEssentialViewTrigger: PublishSubject<Void> = PublishSubject()
        let pushInterestsViewTrigger: PublishSubject<Void> = PublishSubject()
        let BirthTextFieldTrigger: PublishSubject<Date> = PublishSubject()
        let checkNicknameTrigger: PublishSubject<String?> = PublishSubject()
        let duplicatedNickNameTrigger: PublishSubject<String?> = PublishSubject()
        let postEssentialInfoTrigger: PublishSubject<Void> = PublishSubject()
        
        
        // MARK: - 개선중인 코드는 이 아래로
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
    
    let checkNicknameValidate = BehaviorRelay<Bool>(value: false)
    let checkBirthNotEmpty = BehaviorRelay<String?>(value: nil)
    let checkAddressNotEmpty = BehaviorRelay<String?>(value: nil)
    
    var nickNameValidateState: PublishRelay<Int> = PublishRelay()
    var nickNameDuplicateState: PublishRelay<Bool> = PublishRelay()
    var genderState: PublishRelay<Int> = PublishRelay()
    var jobState: PublishRelay<Int> = PublishRelay()

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
    
    // MARK: - 성별 직업 버튼 선택 여부
    var jobAndGenderButtonState: Observable<Bool> {
        Observable.combineLatest(genderState, jobState) { genderState, jobState  in
            if (genderState == 0 || genderState == 1) && (jobState == 0 || jobState == 1) {
                return true
            } else {
                return false
            }
        }
    }
    
    func tapGenderButton(gender: Int) {
        genderState.accept(gender)
    }
    
    func tapJobButton(job: Int) {
        jobState.accept(job)
        
    }
    
    func tapNextButton(isValid: Bool) {
        if isValid {
            self.pushInterestsViewController()
        }
    }
    
    // MARK: - 닉네임 중복검사 API
    func tapDuplicatedCheckButton(nickName: String) {
        let api = PartingAPI.checkNickname(nickName: nickName)
        guard let apiURL = api.url else { return }
        guard let url = URL(string: apiURL) else { return }
        APIManager.shared.requestPartingWithObservable(
            type: NickNameResponse.self,
            url: url,
            method: .get,
            parameters: api.parameters,
            headers: api.headers
        )
        .withUnretained(self)
        .subscribe(onNext: { owner, response in
            if let data = try? response.get() {
                print("TEST")
                owner.nickNameDuplicateState.accept(data.isSuccess)
            }
        })
        .disposed(by: disposeBag)
    }
    
    // MARK: - 다음단계로 버튼 활성화 유효성 검사
    var isValidForm: Observable<Bool> {
        // check nickNameValidate -> Bool Type
        // check nickNameDuplicated -> Bool Type
        // check birth TextField Not empty
        // check sido, sigungu TextField Not empty
        // check Button selected -> Bool Type
        return Observable.combineLatest(
            checkNicknameValidate,
            nickNameDuplicateState,
            checkBirthNotEmpty,
            checkAddressNotEmpty,
            jobAndGenderButtonState
        ) { nicknameValidate, nickNameDuplicated, birth, address, jobAndGender in
         
            guard birth != nil && address != nil else { return false }
            print("\(nicknameValidate) \(nickNameDuplicated)  \(jobAndGender)  \(!address!.isEmpty) \(!birth!.isEmpty)")
            // 위의 조건에 따른 return
            return nicknameValidate && nickNameDuplicated && jobAndGender && !address!.isEmpty && !birth!.isEmpty
        }
    }
    
    //MARK: - 필수정보 입력 POST API
    func postEssentialInfo(
        _ birth: String,
        _ job: String,
        _ nickName: String,
        _ sex: String,
        _ sigunguCd: Int
    ) {
        let api = PartingAPI.essentialInfo(
            birth: birth,
            job: job,
            nickName: nickName,
            sex: sex,
            sigunguCd: sigunguCd
        )
        guard let apiUrl = api.url else { return }
        guard let url = URL(string: apiUrl) else { return }
        APIManager.shared.requestPartingWithObservable(
            type: NickNameResponse.self,
            url: url,
            method: .post,
            parameters: api.parameters,
            encoding: JSONEncoding.default,
            headers: api.headers)
        .withUnretained(self)
        .subscribe(onNext: { owner, response in
            
        })
        .disposed(by: disposeBag)
    }
    
    //MARK: - 닉네임 정규식 표현
    func nicknameValidCheck(_ nickname: String) -> Bool {
        let regexPattern = "^[a-zA-Z0-9가-힣_-]{2,16}$"
        let nicknamePredicate = NSPredicate(format: "SELF MATCHES %@", regexPattern)
        self.checkNicknameValidate.accept(nicknamePredicate.evaluate(with: nickname))
        return nicknamePredicate.evaluate(with: nickname)
    }
    
    // MARK: - 시도, 시군구 API
    func getAddress() {
        let api = PartingAPI.region
        guard let apiUrl = api.url else { return }
        guard let url = URL(string: apiUrl) else { return }
        
        APIManager.shared.requestPartingWithObservable(
            type: RegionData.self,
            url: url,
            method: .get,
            parameters: api.parameters,
            headers: api.headers
        )
        .withUnretained(self)
        .subscribe(onNext: { owner, response in
            if let data = try? response.get() {
                data.result.sidoInfoList.forEach {
                    owner.sidoList.append($0.sidoNm)
                    owner.sidoCD.append($0.sidoCD)
                }
                
                data.result.sidoInfoList.forEach {
                    let sidoCd = $0.sidoCD, sidoNm = $0.sidoNm
                    if owner.sidoCDDict[sidoNm] == nil {
                        owner.sidoCDDict[sidoNm] = 0
                    }
                    owner.sidoCDDict[sidoNm] = sidoCd
                }
                
                data.result.sigunguInfoList.forEach {  owner.sigugunCD.append($0.sigunguCD)
                }
                
                data.result.sigunguInfoList.forEach {
                    let sidoCd = $0.sidoCD,  sigunguNm = $0.sigunguNm
                    if owner.sigunguCDDict[sidoCd] == nil {
                        owner.sigunguCDDict[sidoCd] = []
                    }
                    owner.sigunguCDDict[sidoCd]?.append(sigunguNm)
                }
                
                data.result.sigunguInfoList.forEach {
                    owner.sigugunList.append($0.sigunguNm)
                }
                
                owner.output.sidoListData.accept(owner.sidoList)
                owner.output.sigugunListData.accept(owner.sigugunList)
                owner.output.sigugunCodeData.accept(owner.sigugunCD)
                owner.output.sidoCDDictData.accept(owner.sidoCDDict)
                owner.output.sigunguCDDictData.accept(owner.sigunguCDDict)
            }
            })
            .disposed(by: disposeBag)
    }
    
    private func datePickerValueChanged() {
        input.BirthTextFieldTrigger
            .withUnretained(self)
            .subscribe(onNext: { owner, date in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateString = dateFormatter.string(from: date)
                let birthDate: [String] = dateString.split(separator: "-").map{String($0)}
                owner.output.birthDateData.accept(birthDate)
            })
            .disposed(by: disposeBag)
    }
    
    private func viewChangeTrigger() {
        input.popEssentialViewTrigger
            .withUnretained(self)
            .subscribe(onNext:{ owner, _ in
                owner.popEssentialInfoViewController()
            })
            .disposed(by: disposeBag)
        
        input.pushInterestsViewTrigger
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.pushInterestsViewController()
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
