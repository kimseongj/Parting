//
//  MapViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/07/14.
//

import Foundation

final class MapViewModel: BaseViewModel {
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    var input: Input
    var output: Output
    
    private var mapCoordinator: MapCoordinator?
    
    init(input: Input = Input(), output: Output = Output(), mapCoordinator: MapCoordinator?) {
        self.input = input
        self.output = output
        self.mapCoordinator = mapCoordinator
    }
}
