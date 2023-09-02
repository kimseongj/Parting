//
//  HomeViewModel.swift
//  Parting
//
//  Created by 김민규 on 2023/05/09.
//

import Foundation
import RxSwift
import RxCocoa
import CoreData

final class HomeViewModel: BaseViewModel {
	
	enum LocalStorageError: Error {
		case noFileName
		case noImageInDisk
		case noContext
		case noEntity
		case fetchingError
	}
	
	struct Input {
        let viewDidLoadTrigger = PublishSubject<Void>()
		let pushScheduleVCTrigger = PublishSubject<Void>()
	}
	
	struct Output {
        let categories: BehaviorRelay<[CategoryModel]> = BehaviorRelay(value: [])
		let categoryImages: BehaviorRelay<[CategoryModel]> = BehaviorRelay(value: [])
        let widgetData: BehaviorRelay<WidgetResult?> = BehaviorRelay<WidgetResult?>(value: nil)
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
        
        input.viewDidLoadTrigger
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.getDdayInfo()
                owner.getCalendarInfo()
            })
            .disposed(by: disposeBag)
	}
    
    private func getDdayInfo() {
        let api = PartingAPI.partyDday
        guard let apiURL = api.url else { return }
        guard let url = URL(string: apiURL) else { return }
        APIManager.shared.requestParting(
            type: WidgetResponse.self,
            url: url,
            method: .get,
            parameters: api.parameters,
            headers: api.headers
        ) { data in
            if let response = try? data.get() {
                self.output.widgetData.accept(response.result)
            }
        }
    }
    
    private func getCalendarInfo() {
        let api = PartingAPI.calender(
            month: 8,
            year: 2023
        )
        guard let apiURL = api.url else { return }
        guard let url = URL(string: apiURL) else { return }
        
        APIManager.shared.requestParting(
            type: CalendarResponse.self,
            url: url,
            method: .get,
            parameters: api.parameters,
            headers: api.headers) { data in
                if let response = try? data.get() {
                    print(response.result)
                }
            }
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
