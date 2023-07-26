//
//  ScheduleViewModel.swift
//  Parting
//
//  Created by 김민규 on 2023/07/01.
//

import Foundation
import RxSwift

class ScheduleViewModel: BaseViewModel {
	struct Input {
		let popVCTrigger = PublishSubject<Void>()
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

		input.popVCTrigger
            .withUnretained(self)
			.subscribe(onNext: { owner, _ in
				owner.coordinator?.popVC()
			})
			.disposed(by: disposeBag)
	}
	
	
}
