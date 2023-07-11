//
//  HomeViewModel.swift
//  Parting
//
//  Created by 김민규 on 2023/05/09.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel: BaseViewModel {
	
	struct Input {
		let pushScheduleVCTrigger = PublishSubject<Void>()
	}
	
	struct Output {
		let categoryImages: BehaviorRelay<[String]> = BehaviorRelay(value: [])
		let categoryNames: BehaviorRelay<[String]> = BehaviorRelay(value: [])
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
	}
	
	private func setupBindings() {
		input.pushScheduleVCTrigger
			.subscribe(onNext: { [weak self] in
				self?.coordinator?.pushScheduleVC()
			})
			.disposed(by: disposeBag)
		
		bindCategory()
	}
	
	private func bindCategory() {
		
		var imageDataList: [String] = []
		var categoryNameList: [String] = []
		
		APIManager.shared.getCategoryAPI()
			.withUnretained(self)
			.subscribe(onNext: { owner, data in
				for idx in 0..<data.result.categories.count {
					imageDataList.append(data.result.categories[idx].imgURL)
					categoryNameList.append(data.result.categories[idx].categoryName)
				}
				owner.output.categoryImages.accept(imageDataList)
			})
			.disposed(by: disposeBag)
	}
	
	func pushPartyListVC(title: String) {
		self.coordinator?.pushPartyListVC(title: title)
	}
	
}
