//
//  EditMyPageViewModel.swift
//  Parting
//
//  Created by 이병현 on 2023/09/22.
//

import Foundation
import RxSwift
import RxCocoa

enum GenderCase: String {
    case man = "M"
    case woman = "F"
}

struct SidoSigunguData {
    enum Sido: String {
        case 서울 = "서울특별시"
        case 부산 = "부산광역시"
        case 대구 = "대구광역시"
        case 대전 = "대전광역시"
        case 인천 = "인천광역시"
        case 광주 = "광주광역시"
        case 울산 = "울산광역시"
        case 세종 = "세종특별자치시"
        case 경기도 = "경기도"
        case 강원도 = "강원도"
        case 충청북도 = "충청북도"
        case 충청남도 = "충청남도"
        case 전라북도 = "전라북도"
        case 전라남도 = "전라남도"
        case 경상북도 = "경상북도"
        case 경상남도 = "경상남도"
        case 제주특별자치도 = "제주특별자치도"
    }
    
    struct SidoSigungu {
        let sido: Sido
        let sigungu: [String]
    }
    
    static let list: [SidoSigungu] = [
        SidoSigungu(
            sido: .서울,
            sigungu: ["종로구", "중구", "용산구", "성동구", "광진구", "동대문구", "중랑구", "성북구", "강북구", "도봉구", "노원구", "은평구", "서대문구", "마포구", "양천구", "강서구", "구로구", "금천구", "영등포구", "동작구", "관악구", "서초구", "강남구", "송파구", "강동구"]),
        SidoSigungu(
            sido: .인천,
            sigungu: ["중구", "동구", "연수구", "남동구", "부평구", "계양구", "서구", "미추홀구", "강화군", "옹진군"]),
        SidoSigungu(
            sido: .대전,
            sigungu: ["동구", "중구", "서구", "유성구", "대덕구"]),
        SidoSigungu(
            sido: .대구,
            sigungu: ["중구", "동구", "서구", "남구", "북구", "수성구", "달서구", "달성군"]),
        SidoSigungu(sido: .강원도, sigungu: ["춘천시", "원주시", "강릉시", "동해시", "태백시", "속초시", "삼척시", "홍천군", "횡성군", "영월군", "평창군", "정선군", "철원군", "화천군", "양구군", "인제군", "고성군", "양양군"]),
        SidoSigungu(
            sido: .부산,
            sigungu: ["중구", "서구", "동구", "영도구", "부산진구", "동래구", "남구", "북구", "해운대구", "사하구", "금정구", "강서구", "연제구", "수영구", "사상구", "기장군"]),
        SidoSigungu(
            sido: .울산,
            sigungu: ["중구", "남구", "동구", "북구", "울주군"]),
        SidoSigungu(
            sido: .광주,
            sigungu: ["동구", "서구", "남구", "북구", "광산구"]),
        SidoSigungu(
            sido: .세종,
            sigungu: ["세종시"]),
        SidoSigungu(
            sido: .경기도,
            sigungu: ["수원시 장안구", "수원시 권선구", "수원시 팔달구", "수원시 영통구", "성남시 수정구", "성남시 중원구", "성남시 분당구", "의정부시", "안양시 만안구", "안양시 동안구", "부천시", "광명시", "평택시", "동두천시", "안산시 상록구", "안산시 단원구", "고양시 덕양구", "고양시 일산동구", "고양시 일산서구", "과천시", "구리시", "남양주시", "오산시", "시흥시", "군포시", "의왕시", "하남시", "용인시 처인구", "용인시 기흥구", "용인시 수지구", "파주시", "이천시", "안성시", "김포시", "화성시", "광주시", "양주시", "포천시", "여주시", "연천군", "가평군", "양평군"]),
        SidoSigungu(
            sido: .충청북도,
            sigungu: ["충주시", "제천시", "청주시 상당구", "청주시 서원구", "청주시 흥덕구", "청주시 청원구", "보은군", "옥천군", "영동군", "진천군", "괴산군", "음성군", "단양군", "증평군"]),
        SidoSigungu(
            sido: .충청남도,
            sigungu: ["천안시 동남구", "천안시 서북구", "공주시", "보령시", "아산시", "서산시", "논산시", "계룡시", "당진시", "금산군", "부여군", "서천군", "청양군", "홍성군", "예산군", "태안군"]),
        SidoSigungu(
            sido: .전라북도,
            sigungu: ["전주시 완산구", "전주시 덕진구", "군산시", "익산시", "정읍시", "남원시", "김제시", "완주군", "진안군", "무주군", "장수군", "임실군", "순창군", "고창군", "부안군"]),
        SidoSigungu(
            sido: .전라남도,
            sigungu: ["목포시", "여수시", "순천시", "나주시", "광양시", "담양군", "곡성군", "구례군", "고흥군", "보성군", "화순군", "장흥군", "강진군", "해남군", "영암군", "무안군", "함평군", "영광군", "장성군", "완도군", "진도군", "신안군"]),
        SidoSigungu(
            sido: .경상북도, 
            sigungu: ["포항시 남구", "포항시 북구", "경주시", "김천시", "안동시", "구미시", "영주시", "영천시", "상주시", "문경시", "경산시", "군위군", "의성군", "청송군", "영양군", "영덕군", "청도군", "고령군", "성주군", "칠곡군", "예천군", "봉화군", "울진군", "울릉군"]),
        SidoSigungu(
            sido: .경상남도,
            sigungu: ["진주시", "통영시", "사천시", "김해시", "밀양시", "거제시", "양산시", "창원시 의창구", "창원시 성산구", "창원시 마산합포구", "창원시 마산회원구", "창원시 진해구", "의령군", "함안군", "창녕군", "고성군", "남해군", "하동군", "산청군", "함양군", "거창군", "합천군"]),
        SidoSigungu(
            sido: .제주특별자치도,
            sigungu: ["제주시", "서귀포시"])
    ]
}

final class EditMyPageViewModel {
    enum Input {
        case BirthTextFieldTrigger
        case viewdidLoadTrigger
        case editCompleteButtonClicked
    }
    
    enum Output {

    }
    
    struct State {
        var nameTextField = BehaviorRelay<String>(value: "")
        var selectedGender = BehaviorRelay(value: GenderCase.man)
        var birthTextField = BehaviorRelay<String>(value: "")
        var regionTextField = BehaviorRelay<String>(value: "")
        var introduceTextView = BehaviorRelay<String>(value: "")
        var completeButtonIsValidState = BehaviorRelay(value: false)
    }
    
    var input = PublishSubject<Input>()
    private var coordinator: MyPageCoordinator?
    private let disposeBag = DisposeBag()
    let list = SidoSigunguData.list
    var regionDataList: regionResult?
    var sidoCDList: [Int] = []
    var sigunguDict: [Int: [String]] = [:]
    let myPageData = PublishRelay<MyPageResponse>()
    let nickNameDuplicateState = BehaviorRelay(value: false)
    var state = State()
    
    init(coordinator: MyPageCoordinator?) {
        self.coordinator = coordinator
        bind()
    }
    
    var completeButtonIsValid: Observable<Bool> {
           Observable.combineLatest(state.nameTextField, state.birthTextField, state.regionTextField, state.introduceTextView) { name, birth, region, introduce in
               if name != "" && birth != "" && introduce != "" && region != "" {
                   return true
               } else {
                   return false
               }
           }
       }
    
    private func bind() {
        state.nameTextField
            .withUnretained(self)
            .subscribe(onNext: { owner, text in
                print(text, "💛")
            })
            .disposed(by: disposeBag)
        
        state.birthTextField
            .withUnretained(self)
            .subscribe(onNext: { owner, text in
                print(text, "💛")
            })
            .disposed(by: disposeBag)
        
        state.regionTextField
            .withUnretained(self)
            .subscribe(onNext: { owner, text in
                print(text, "💛")
            })
            .disposed(by: disposeBag)
        
        input
            .withUnretained(self)
            .subscribe(onNext: { owner, input in
                switch input {
                case .viewdidLoadTrigger:
                    owner.getSidoSigungu()
                    owner.getMyPageData()
                case .editCompleteButtonClicked:
                    print("프로필 수정 API CALL")
                    owner.putModifyProfile()
                default:
                    break
                }
            })
            .disposed(by: disposeBag)
    }
    
    func popVC() {
        self.coordinator?.popVC()
    }
    
}

extension EditMyPageViewModel {
    private func putModifyProfile() {
            let api = PartingAPI.modifyInfo(
                birth: state.birthTextField.value,
                introduce: state.introduceTextView.value,
                nickName: state.nameTextField.value,
                gender: state.selectedGender.value.rawValue,
                sigunguCd: 11020
            )
        
        print(state.birthTextField.value, state.introduceTextView.value, state.nameTextField.value, state.selectedGender.value.rawValue)

            guard let apiURL = api.url else { return }
            guard let url = URL(string: apiURL) else { return }

            APIManager.shared.requestParting(
                type: BasicResponse.self,
                url: url,
                method: .put,
                parameters: api.parameters,
                encoding: .default,
                headers: api.headers) { response in
                    switch response {
                    case let .success(data):
                        print("프로필 수정 PUT 데이터\(data)", "💛")
                        print(data)
                        self.popVC()
                    case let .failure(error):
                        print(error)
                    }
                }
        }
    
    func getMyPageData() {
        APIManager.shared.requestGetMyPageData()
            .subscribe { [weak self] data in
                guard let self else { return }
//                print(data)
                self.myPageData.accept(data)
            } onError: { error in
                print(error)
            }
            .disposed(by: disposeBag)

    }
    
    private func getSidoSigungu() {
        let api = PartingAPI.region
        guard let apiURL = api.url else { return }
        guard let url = URL(string: apiURL) else { return }
        
        APIManager.shared.requestParting(
            type: RegionData.self,
            url: url,
            method: .get,
            parameters: api.parameters,
            headers: api.headers) { [weak self] response in
                switch response {
                case let .success(data):
                    guard let self else { return }
                    self.regionDataList = data.result
                    print(self.regionDataList, "✅")
                    guard let sidoList = self.regionDataList?.sidoInfoList else { return }
                    guard let sigunguList = self.regionDataList?.sigunguInfoList else { return }
                    for sido in sidoList {
                        sidoCDList.append(sido.sidoCD)
                    }
                    
                    
                    for sidoCD in sidoCDList {
                        for sigungu in sigunguList {
                            if sidoCD == sigungu.sidoCD {
                                if var existingArray = sigunguDict[sidoCD] {
                                    existingArray.append(sigungu.sigunguNm)
                                    sigunguDict[sidoCD] = existingArray
                                    } else {
                                        // 해당 키에 대한 배열이 없을 경우, 새로운 배열을 생성하여 값을 추가합니다.
                                        sigunguDict[sidoCD] = [sigungu.sigunguNm]
                                    }
                            }
                        }
                    }
                    print(sidoCDList)
                    print(sigunguDict)
                case let .failure(error):
                    print(error)
                }
            }
    }
    
    func duplicationNickname(nickname: String) {
        let api = PartingAPI.checkNickname(nickName: nickname)
        guard let apiURL = api.url else { return }
        guard let url = URL(string: apiURL) else { return }
        APIManager.shared.requestPartingWithObservable(
            type: BasicResponse.self,
            url: url,
            method: .get,
            parameters: api.parameters,
            headers: api.headers
        )
        .withUnretained(self)
        .subscribe(onNext: { owner, response in
            if let data = try? response.get() {
                print(response)
                owner.nickNameDuplicateState.accept(data.isSuccess)
            }
        })
        .disposed(by: disposeBag)
    }
}
