//
//  HomeViewModel.swift
//  Parting
//
//  Created by 김민규 on 2023/05/09.
//

import Foundation
import RxSwift
import RxCocoa
import Kingfisher
import CoreData
import UIKit

final class HomeViewModel: BaseViewModel {
	
	enum LocalStorageError: Error {
		case noFileName
		case noImageInDisk
		case noContext
		case noEntity
		case fetchingError
	}
	
	struct Input {
		let pushScheduleVCTrigger = PublishSubject<Void>()
	}
	
	struct Output {
        let categories: BehaviorRelay<[CategoryModel]> = BehaviorRelay(value: [])
		let categoryImages: BehaviorRelay<[CategoryModel]> = BehaviorRelay(value: [])
	}
	
	private let disposeBag = DisposeBag()
	
	
	var input: Input
	var output: Output
	
	private weak var coordinator: HomeCoordinator?
    
    init(input: Input = Input(), output: Output = Output(), coordinator: HomeCoordinator?) {
		self.input = input
		self.output = output
		self.coordinator = coordinator
		setupBindings()
		loadCategories()
	}
	
	private func setupBindings() {
		input.pushScheduleVCTrigger
            .withUnretained(self)
			.subscribe(onNext: { owner, _ in
				owner.coordinator?.pushScheduleVC()
			})
			.disposed(by: disposeBag)

		
	}
	
	private func loadCategories() {
        CoreDataManager.fetchCategories()
            .withUnretained(self)
            .subscribe(onNext: { owner, result in
                let inOrder = result.sorted(by: { category1, category2 in
                    return category1.id < category2.id
                })
                                            
                owner.output.categories.accept(inOrder)
            })
            .disposed(by: disposeBag)
	}
	
	
	
	func pushPartyListVC(category: CategoryModel) {
		self.coordinator?.pushPartyListVC(category: category)
	}
	
}
