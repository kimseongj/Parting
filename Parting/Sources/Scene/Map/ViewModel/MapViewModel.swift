//
//  MapViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/07/14.
//

import Foundation
import RxSwift
import RxCocoa

final class MapViewModel {
    enum Input {
        case viewDidLoadTrigger
    }
    
    enum Output {
        
    }
    
    var input: PublishSubject<Input> = PublishSubject()
    
    private var mapCoordinator: MapCoordinator?
    private let disposeBag = DisposeBag()
    
    init(mapCoordinator: MapCoordinator?) {
        self.mapCoordinator = mapCoordinator
        bind()
    }
    
    private func bind() {
        input
            .withUnretained(self)
            .subscribe(onNext: { onwer, event in
                
            })
            .disposed(by: disposeBag)
    }
    
    private func getAroundParty() {
        
    }
}
