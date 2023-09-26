//
//  InquireViewModel.swift
//  Parting
//
//  Created by 이병현 on 2023/09/26.
//

import Foundation
import RxSwift
import RxCocoa

final class InquireViewModel: BaseViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    var input: Input
    var output: Output
    
    private var coordinator: MyPageCoordinator?
    private let disposeBag = DisposeBag()
    
    init(input: Input = Input(), output: Output = Output(), coordinator: MyPageCoordinator?) {
        self.input = input
        self.output = output
        self.coordinator = coordinator
        bind()
    }
    
    private func bind() {
    }
}
