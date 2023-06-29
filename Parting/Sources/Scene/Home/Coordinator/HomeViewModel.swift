//
//  HomeViewModel.swift
//  Parting
//
//  Created by 김민규 on 2023/05/09.
//

import Foundation

class HomeViewModel: BaseViewModel {
	
	struct Input {
		
	}
	
	struct Output {
		
	}
	
	var input: Input
	var output: Output
	
	private weak var coordinator: HomeCoordinator?
	
	init(input: Input = Input(), output: Output = Output(), coordinator: HomeCoordinator?) {
		self.input = input
		self.output = output
		self.coordinator = coordinator
	}
	
	
}
