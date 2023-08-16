//
//  CheckMyPartyViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/08/16.
//

import UIKit

class CheckMyPartyViewModel: BaseViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    var input: Input
    var output: Output
    
    init(input: Input = Input(), output: Output = Output(), mapCoordinator: MapCoordinator?) {
        self.input = input
        self.output = output
        
    }
}
