//
//  HomeViewController.swift
//  Parting
//
//  Created by 김민규 on 2023/05/09.
//

import Foundation
import UIKit
import RxSwift
import Kingfisher
import RxCocoa

enum PartyList: Int, CaseIterable {
    case 관람팟
    case 자기개발팟
    case 문화생활팟
    case 음식팟
    case 운동팟
    case 오락팟
    case 카페팟
    case 한잔팟

    var imageNameList: String {
        switch self {
        case .관람팟:
            return "관람"
        case .자기개발팟:
            return "자기개발"
        case .문화생활팟:
            return "문화생활"
        case .음식팟:
            return "음식"
        case .운동팟:
            return "운동"
        case .오락팟:
            return "오락"
        case .카페팟:
            return "카페"
        case .한잔팟:
            return "술"
        }
    }

    static var numberOfItems: Int {
        return Self.allCases.count
    }
}

class HomeViewController: BaseViewController<HomeView> {
    
    private var viewModel: HomeViewModel
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.input.onNext(.viewWillAppear)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellResigster()
        setDatasourceAndDelegate()
        bind()
    }
    
    func cellResigster() {
        rootView.categoryCollectionView.register(TestViewCollectionViewCell.self, forCellWithReuseIdentifier: TestViewCollectionViewCell.identifier)
    }
    
    func setDatasourceAndDelegate() {
    }
    
    func bind() {
        viewModel.state.categories
            .bind(to: rootView.categoryCollectionView.rx.items(cellIdentifier: TestViewCollectionViewCell.identifier, cellType: TestViewCollectionViewCell.self)) { [weak self] index, partyType, cell in
                cell.configureCell(item: partyType)
            }
            .disposed(by: disposeBag)
        
        rootView.categoryCollectionView.rx
            .modelSelected(CategoryModel.self)
            .withUnretained(self)
            .subscribe(onNext: { owner, model in
                print(model.id)
                owner.viewModel.input.onNext(.didSelectedCell(model: model))
//                owner.viewModel.input.didSelectedCell.onNext(model)
            })
            .disposed(by: disposeBag)
    }
}
