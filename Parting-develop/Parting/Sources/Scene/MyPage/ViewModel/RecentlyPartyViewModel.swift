//
//  RecentlyPartyViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/08/21.
//

import Foundation

class RecentlyPartyViewModel: BaseViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    var input: Input
    var output: Output
    private var coordinator: MyPageCoordinator?
    
    init(input: Input = Input(), output: Output = Output(), myPageCoordinator: MyPageCoordinator?) {
        self.input = input
        self.output = output
        self.coordinator = myPageCoordinator
    }
    
    func popVC() {
        self.coordinator?.popVC()
    }
}
