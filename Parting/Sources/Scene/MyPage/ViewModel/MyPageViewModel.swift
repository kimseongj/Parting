//
//  MyPageViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/07/13.
//

import Foundation
import RxSwift
import RxCocoa

final class MyPageViewModel: BaseViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    var input: Input
    var output: Output
    var settingUnfoldButtonState: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var etcUnfoldButtonState: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    
    private var coordinator: MyPageCoordinator?
    
    init(input: Input = Input(), output: Output = Output(), coordinator: MyPageCoordinator?) {
        self.input = input
        self.output = output
        self.coordinator = coordinator
    }
    
    func setUnfoldButton(state: Bool) {
        if state == settingUnfoldButtonState.value {
            settingUnfoldButtonState.accept(false)
        } else {
            settingUnfoldButtonState.accept(state)
        }
    }
    
    func etcUnfoldButton(state: Bool) {
        if state == etcUnfoldButtonState.value {
            etcUnfoldButtonState.accept(false)
        } else {
            etcUnfoldButtonState.accept(state)
        }
    }
}
