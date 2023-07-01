//
//  HomeViewModel.swift
//  Parting
//
//  Created by 김민규 on 2023/05/09.
//

import Foundation
import RxSwift

class HomeViewModel: BaseViewModel {
	
	struct Input {
		let pushScheduleVCTrigger = PublishSubject<Void>()
	}
	
	struct Output {
		
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
	}
	
	
}
