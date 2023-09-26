//
//  BottomSheetViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/09/26.
//

import Foundation
import RxSwift

final class BottomSheetViewModel {
    enum Input {
        case closeButtonClicked
    }
    
    enum Output {
        
    }
    
    struct State {
        
    }
    
    private var mapCoordinator: MapCoordinator?
    let partyInfoData: AroundPartyDetailResponse?
    var input = PublishSubject<Input>()
    private let disposeBag = DisposeBag()
    
    init(coorinator: MapCoordinator, data: AroundPartyDetailResponse) {
        self.mapCoordinator = coorinator
        self.partyInfoData = data
        bind()
    }
    
    private func bind() {
        input
            .withUnretained(self)
            .subscribe(onNext: { owner, input in
                switch input {
                case .closeButtonClicked:
                    owner.mapCoordinator?.dismissPartyDetailBottomSheetVC()
                }
            })
            .disposed(by: disposeBag)
    }
}
