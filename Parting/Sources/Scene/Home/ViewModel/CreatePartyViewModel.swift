//
//  CreatePartyViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/07/22.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import CoreData

class CreatePartyViewModel: BaseViewModel {
    struct Input {
        
    }
    
    struct Output {
        let categories: BehaviorRelay<[CategoryModel]> = BehaviorRelay(value: [])
        let categoryImages: BehaviorRelay<[CategoryModel]> = BehaviorRelay(value: [])
    }
    
    var input: Input
    var output: Output
    
    private let disposeBag = DisposeBag()
    private var mapCoordinator: MapCoordinator?
    
    init(input: Input = Input(), output: Output = Output(), mapCoordinator: MapCoordinator?) {
        self.input = input
        self.output = output
        self.mapCoordinator = mapCoordinator
        loadCategories()
    }
    
    private func loadCategories() {
        CoreDataManager.fetchCategories()
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                owner.output.categories.accept(result)
            })
            .disposed(by: disposeBag)
    }
    
}
