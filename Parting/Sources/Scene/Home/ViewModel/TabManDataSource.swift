//
//  TabManViewModel.swift
//  Parting
//
//  Created by 박시현 on 2023/09/29.
//

import UIKit
import RxSwift

final class TabManDataSource {
    private weak var coordinator: HomeCoordinator?
    var tabControllers: [UIViewController] = []
    var tabTitle: [String] = []
    private var categoryModel: CategoryModel
    
    enum Input {
        case viewDidLoad
        case backButtonTap
    }
    
    enum Output {
        case reloadPage
    }
    
    init(coordinator: HomeCoordinator?, categoryModel: CategoryModel) {
        self.coordinator = coordinator
        self.categoryModel = categoryModel
        bind()
    }
    
    var input = PublishSubject<Input>()
    var output = PublishSubject<Output>()
    
    private let disposeBag = DisposeBag()
    
    func bind() {
        input
            .withUnretained(self)
            .subscribe(onNext: { owner, input in
                switch input {
                case let .viewDidLoad:
                    owner.getDetailCategory(id: owner.categoryModel.id)
                case .backButtonTap:
                    owner.popVC()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func popVC() {
        self.coordinator?.popVC()
    }
    
    private func getDetailCategory(id: Int) {
        let api = PartingAPI.associatedCategory(categoryId: id)
        guard let apiURL = api.url else { return }
        guard let url = URL(string: apiURL) else { return }
        
        APIManager.shared.requestParting(
            type: CategoryDetailResponse.self,
            url: url,
            method: .get,
            parameters: api.parameters,
            headers: api.headers) { response in
                switch response {
                case let .success(data):
                    dump(data)
                    for ele in data.result {
//                        print(ele.categoryDetailName) // 디테일 카테고리 이름
//                        print(ele.categoryDetailID) // 디테일 카테고리 고유 ID
                        let apiModelDTO = PartyTabResponse(
                            categoryDetailId: ele.categoryDetailID,
                            categoryId: self.categoryModel.id,
                            orderCondition1: "NONE",
                            orderCondition2: "NONE",
                            pageNumber: 0,
                            categoryVersion: "1.0.0",
                            userLat: 22,
                            userLng: 22
                        )
                        let viewModel = PartyListViewModel(
                            coordinator: self.coordinator,
                            category: self.categoryModel,
                            apiModel: apiModelDTO
                        )
                        let vc = PartyListViewController(viewModel: viewModel)
                        self.tabControllers.append(vc)
                        self.tabTitle.append(ele.categoryDetailName)
                        print(self.tabControllers.count, "tab 컨트롤러 갯수")
                        print(self.tabTitle.count, "tab 타이틀 갯수")
                        self.output.onNext(.reloadPage)
                    }
                case let .failure(error):
                    print("error")
                }
            }
    }
}
