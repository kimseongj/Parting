//
//  JoinViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/04/17.
//

import Foundation

class JoinViewModel: BaseViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    var input: Input
    var output: Output
    
    private weak var coordinator: JoinCoordinator?
    
    init(input: Input = Input(), output: Output = Output(), coordinator: JoinCoordinator?) {
        self.input = input
        self.output = output
        self.coordinator = coordinator
    }
}
