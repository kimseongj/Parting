//
//  PartyListViewModel.swift
//  Parting
//
//  Created by 김민규 on 2023/07/11.
//

import Foundation
import RxSwift
import RxCocoa

class PartyListViewModel: BaseViewModel {
	
	struct Input {
		let popVCTrigger = PublishSubject<Void>()
		let pushCreatePartyVCTrigger = PublishSubject<Void>()
	}
	
	struct Output {
//		let categoryImages: BehaviorRelay<[String]> = BehaviorRelay(value: [])
//		let categoryNames: BehaviorRelay<[String]> = BehaviorRelay(value: [])
		let partyList: BehaviorRelay<[PartyListItemModel]> = BehaviorRelay(value: [])
	}
	
	private let disposeBag = DisposeBag()
	
	var input: Input
	var output: Output
	
	private weak var coordinator: HomeCoordinator?
	
	private let category: CategoryModel
	
	init(input: Input = Input(), output: Output = Output(), coordinator: HomeCoordinator?, category: CategoryModel) {
		self.category = category
		self.input = input
		self.output = output
		self.coordinator = coordinator
		setupBindings()
		
		loadPartyList()
	}
	
	private func loadPartyList() {
        Task {
                    
                    do {
                        guard let parties = try await APIManager.shared.getPartyList(categoryId: category.id, categoryDetailId: 1, orderCondition1: .few, orderCondition2: .latest, pageNumber: 0) else { return }
                        
                        self.output.partyList.accept(parties)
                        
                    } catch {
                        print(error)
                    } /* End Do ~ Catch */
                    
                } /* End Task */
	}
	
	private func setupBindings() {
		input.popVCTrigger
			.subscribe(onNext: { [weak self] in
				self?.coordinator?.popVC()
			})
			.disposed(by: disposeBag)
		
		input.pushCreatePartyVCTrigger
			.subscribe(onNext: { [weak self] in
				self?.coordinator?.pushCreatePartyVC()
			})
			.disposed(by: disposeBag)
	}
	
	
	
	
}

