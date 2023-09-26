//
//  EditMyPageViewModel.swift
//  Parting
//
//  Created by 이병현 on 2023/09/22.
//

import Foundation
import RxSwift
import RxCocoa

enum GenderCase {
    case man
    case woman
}

class EditMyPageViewModel {
    struct Input {
        let BirthTextFieldTrigger: PublishSubject<Date> = PublishSubject()
        let viewDidLoadTrigger: PublishRelay<Void> = PublishRelay()
    }
    
    struct Output {
    }
    
    var input: Input
    var output: Output
    
    private var coordinator: MyPageCoordinator?
    private let disposeBag = DisposeBag()
    var selectedGender = BehaviorRelay(value: GenderCase.man)
    let myPageData = PublishRelay<MyPageResponse>()
    let nickNameDuplicateState = BehaviorRelay(value: false)
    
    init(input: Input = Input(), output: Output = Output(), coordinator: MyPageCoordinator?) {
        self.input = input
        self.output = output
        self.coordinator = coordinator
        bind()
    }
    
    private func bind() {
        input.viewDidLoadTrigger
            .withUnretained(self)
            .bind { vm, _ in
                vm.getMyPageData()
            }
            .disposed(by: disposeBag)
    }
    
    func popVC() {
        self.coordinator?.popVC()
    }
    
}

extension EditMyPageViewModel {
    func getMyPageData() {
        APIManager.shared.requestGetMyPageData()
            .subscribe { [weak self] data in
                guard let self else { return }
                print(data)
                self.myPageData.accept(data)
            } onError: { error in
                print(error)
            }
            .disposed(by: disposeBag)

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
