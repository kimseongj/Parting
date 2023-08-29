//
//  ShowDetailPartyViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/08/29.
//

import Foundation
import RxSwift
import RxCocoa

class ShowDetailPartyViewModel {
    enum Input {
        
    }
    
    enum Output {
        
    }
    
    private var coordinator: MyPageCoordinator?
    private let disposeBag = DisposeBag()
    
    init(coordinator: MyPageCoordinator?) {
        self.coordinator = coordinator
        bind()
    }
    
    private func bind() {
        
    }
    
}
