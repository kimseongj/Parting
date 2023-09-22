//
//  EditMyPageViewModel.swift
//  Parting
//
//  Created by 이병현 on 2023/09/22.
//

import Foundation
import RxSwift
import RxCocoa

class EditMyPageViewModel {
    enum Input {
        
    }
    
    enum Output {
        
    }
    
    private var coordinator: MyPageCoordinator?
    private let disposeBag = DisposeBag()
    
    let input = PublishSubject<Input>()
    let output = PublishSubject<Output>()
    
    init(coordinator: MyPageCoordinator?) {
        self.coordinator = coordinator
        bind()
    }
    
    private func bind() {
        
    }
    
    func popVC() {
        self.coordinator?.popVC()
    }
    
}
