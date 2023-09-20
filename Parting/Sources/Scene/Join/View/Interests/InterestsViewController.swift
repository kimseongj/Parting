//
//  InterestsViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/04/20.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

enum InterestsCategory: Int, CaseIterable {
    case culture
    case preview
    case selfDevelopement
    case food
    case exercise
    case playGame
    case cafe
    case drink
    
    var category: String {
        switch self {
        case .culture:
            return "문화생활"
        case .preview:
            return "관람"
        case .selfDevelopement:
            return "자기개발"
        case .food:
            return "음식"
        case .exercise:
            return "운동"
        case .playGame:
            return "오락"
        case .cafe:
            return "카페"
        case .drink:
            return "술"
        }
    }
    
    static var numberOfCategorys: Int {
        return InterestsCategory.allCases.count
    }
}

class InterestsViewController: BaseViewController<InterestsView> {
    private let viewModel: InterestsViewModel
    
    private var checkedCategoryList: [Int] = [1,2,3,4,5,6,7,8]
    private var selectedCellIndex: [Int] = []
    init(viewModel: InterestsViewModel) {
		self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("InterestsVC 메모리 해제")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selectedCellIndex.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.getAssociatedCategory(checkedCategoryList)
        navigationUI()
        configureCell()
        bindCategoryImage()
        didSelectedCell()
        nextButtonClicked()
        viewModel.getCategoryInfo()
    }
    
    private func configureCell() {
        rootView.categoryCollectionView.register(CategoryImageCollectionViewCell.self, forCellWithReuseIdentifier: CategoryImageCollectionViewCell.identifier)
    }
    
    private func bindCategoryImage() {
        viewModel.output.categoryImage
            .bind(to: rootView.categoryCollectionView.rx.items(cellIdentifier: CategoryImageCollectionViewCell.identifier, cellType: CategoryImageCollectionViewCell.self)) {
                index, categoryImage, cell in
                print("\(categoryImage) ▶️▶️")
                cell.configureCell(item: CategoryTitleImage(rawValue: index)?.item ?? "관람")

            }
            .disposed(by: disposeBag)
    }
    
    private func didSelectedCell() {
        rootView.categoryCollectionView.rx
            .itemSelected
            .observe(on: MainScheduler.instance)
            .withUnretained(self)
            .subscribe(onNext: { owner, indexPath in
                print("\(indexPath[1]) 🚫🚫")
                guard let cell = owner.rootView.categoryCollectionView.cellForItem(at: indexPath) as? CategoryImageCollectionViewCell else { return }
                if  cell.bgView.layer.borderColor == UIColor(hexcode: "FBB0C0").cgColor { // 선택이 이미 된 상태
                    if let firstIndex = owner.selectedCellIndex.firstIndex(of: indexPath[1]+1) {
                        owner.selectedCellIndex.remove(at: firstIndex)  // 1
                        print("\(owner.selectedCellIndex) + 체크 안됐을 때")
                    }
                    cell.interestsLabel.textColor = AppColor.gray400
                    cell.bgView.layer.borderColor = UIColor(hexcode: "F1F1F1").cgColor
                } else { // 선택이 안된 상태
                    let shadowPath0 = UIBezierPath(roundedRect: cell.bgView.bounds, cornerRadius: 16)
                    owner.selectedCellIndex.append(indexPath[1]+1)
                    print("\(owner.selectedCellIndex) + 체크됐을 때")
                    cell.interestsLabel.textColor = UIColor(hexcode: "65656D")
                    cell.bgView.layer.borderColor = UIColor(hexcode: "FBB0C0").cgColor
                    cell.bgView.layer.shadowPath
                    cell.bgView.layer.shadowPath = shadowPath0.cgPath
                    cell.bgView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
                    cell.bgView.layer.shadowOpacity = 1
                    cell.bgView.layer.shadowRadius = 1
                    cell.bgView.layer.shadowOffset = CGSize(width: 0, height: 0)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func nextButtonClicked() {
        //MARK: - 보내야 할 데이터: EssentialView에서 선택할 관심사 배열, 배열하나만 보내면 카운트 갯수만큼 컬렉션 뷰 Cell 생성, 배열의 원소(인덱스)를 통해 통신.
        rootView.nextStepButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.viewModel.input.pushDetailInterestViewTrigger.onNext(owner.selectedCellIndex)
            })
            .disposed(by: disposeBag)
    }
    
    private func navigationUI() {
        self.navigationController?.isNavigationBarHidden = false
        let leftBarButtonItem = UIBarButtonItem.init(image:  UIImage(named: "backBarButton"), style: .plain, target: self, action: #selector(backBarButtonClicked))
        leftBarButtonItem.tintColor = AppColor.joinText
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        let titleImage = UIImage(named: "JoinFlowInterest")
        navigationItem.titleView = UIImageView(image: titleImage)
    }
    
    @objc func backBarButtonClicked() {
        self.viewModel.input.popInterestsViewTrigger.onNext(())
    }
}
