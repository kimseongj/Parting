//
//  MyPageViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/07/13.
//

import Foundation

class MyPageViewModel: BaseViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    var input: Input
    var output: Output
    
    private var coordinator: HomeCoordinator?
    
    init(input: Input = Input(), output: Output = Output(), coordinator: HomeCoordinator?) {
        self.input = input
        self.output = output
        self.coordinator = coordinator
    }
}
