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

final class HomeViewModel {
	
	enum LocalStorageError: Error {
		case noFileName
		case noImageInDisk
		case noContext
		case noEntity
		case fetchingError
	}
    
    enum Input {
        case didSelectedCell(model: CategoryModel)
        case viewWillAppear
    }
    
    enum Output {
        
    }
    
    struct State {
        let categories: BehaviorRelay<[CategoryModel]> = BehaviorRelay(value: [])
        let categoryImages: BehaviorRelay<[CategoryModel]> = BehaviorRelay(value: [])
        let widgetData: BehaviorRelay<WidgetResult?> = BehaviorRelay<WidgetResult?>(value: nil)
        let calendarData: BehaviorRelay<[Int]?> = BehaviorRelay<[Int]?>(value: nil)
    }
	
    var input = PublishSubject<Input>()
    var state = State()
	private let disposeBag = DisposeBag()
	private weak var coordinator: HomeCoordinator?
    
    init(coordinator: HomeCoordinator?) {
		self.coordinator = coordinator
        bind()
		loadCategories()
	}
    
    private func bind() {
        input
            .withUnretained(self)
            .subscribe(onNext: { owner, input in
                switch input {
                case let .didSelectedCell(model):
                    owner.pushPartyListVC(category: model)
                case .viewWillAppear:
                    owner.getEnteredMyParty()
                }
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
        ) { [weak self] data in
            switch data {
            case let .success(data):
                self?.state.widgetData.accept(data.result)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    private func getEnteredMyParty() {
        let api = PartingAPI.checkEnteredParty(
            pageNumber: 0,
            lat: 23,
            lng: 24
        )
        
        guard let apiURL = api.url else { return }
        guard let url = URL(string: apiURL) else { return }
        
        APIManager.shared.requestParting(
            type: CheckMyPartyResponse.self,
            url: url,
            method: .get,
            parameters: api.parameters,
            headers: api.headers) { response in
                switch response {
                case let .success(data):
                    print(data)
                case let .failure(error):
                    print(error)
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
            headers: api.headers) { [weak self] data in
                switch data {
                case let .success(data):
                    self?.state.calendarData.accept(data.result)
                    print(data.result)
                case let .failure(error):
                    print(error)
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
                owner.state.categories.accept(inOrder)
            })
            .disposed(by: disposeBag)
	}
	
	func pushPartyListVC(category: CategoryModel) {
		self.coordinator?.pushPartyListVC(category: category)
	}
	
}

