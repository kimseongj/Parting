//
//  CreatePartyViewModel.swift
//  Parting
//
//  Created by 김민규 on 2023/07/17.
//

import Foundation
import RxSwift
import RxCocoa

class CreatePartyViewModel: BaseViewModel {
	
	struct Input {
		let popVCTrigger = PublishSubject<Void>()
//		let pushCreatePartyVCTrigger = PublishSubject<Void>()
	}
	
	struct Output {
//		let categoryImages: BehaviorRelay<[String]> = BehaviorRelay(value: [])
//		let categoryNames: BehaviorRelay<[String]> = BehaviorRelay(value: [])
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
			.subscribe(onNext: { [weak self] in
				self?.coordinator?.popVC()
			})
			.disposed(by: disposeBag)
		
	}
	
	
	
	
}
