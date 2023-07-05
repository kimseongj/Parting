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
    private let disposeBag = DisposeBag()
    private var checkedCategoryList: [Int] = [1,2,3,4,5,6,7,8]
    private var selectedCellIndex: [Int] = []
    
    init(viewModel: InterestsViewModel) {
		self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        viewModel.viewDidLoadAction()
//        self.viewModel.input.getCategoryImageTrigger.onNext(())
    }
    
    private func configureCell() {
        rootView.categoryCollectionView.register(categoryImageCollectionViewCell.self, forCellWithReuseIdentifier: categoryImageCollectionViewCell.identifier)
        
        rootView.categoryCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private func bindCategoryImage() {
        viewModel.output.categoryImage
            .bind(to: rootView.categoryCollectionView.rx.items(cellIdentifier: categoryImageCollectionViewCell.identifier, cellType: categoryImageCollectionViewCell.self)) {
                index, categoryImage, cell in
                print("\(categoryImage) ▶️▶️")
                cell.interestsImageView.kf.setImage(with: URL(string: categoryImage))
                cell.interestsLabel.text = InterestsCategory(rawValue: index)?.category
            }
            .disposed(by: disposeBag)
    }
    
    private func didSelectedCell() {
        rootView.categoryCollectionView.rx
            .itemSelected
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {[weak self] indexPath in
                print("\(indexPath[1]) 🚫🚫")
                guard let self else {return}
                guard let cell = self.rootView.categoryCollectionView.cellForItem(at: indexPath) as? categoryImageCollectionViewCell else { return }
                if cell.interestsImageView.alpha == 1 { // 선택이 이미 된 상태
                    if let firstIndex = selectedCellIndex.firstIndex(of: indexPath[1]+1) {
                        selectedCellIndex.remove(at: firstIndex)  // 1
                        print("\(selectedCellIndex) + 체크 안됐을 때")
                    }
                    cell.interestsImageView.alpha = 0.6
                    cell.interestsLabel.textColor = AppColor.gray400
                } else { // 선택이 안된 상태
                    selectedCellIndex.append(indexPath[1]+1)
                    print("\(selectedCellIndex) + 체크됐을 때")
                    cell.interestsImageView.alpha = 1
                    cell.interestsLabel.textColor = UIColor(hexcode: "65656D")
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func nextButtonClicked() {
        //MARK: - 보내야 할 데이터: EssentialView에서 선택할 관심사 배열, 배열하나만 보내면 카운트 갯수만큼 컬렉션 뷰 Cell 생성, 배열의 원소(인덱스)를 통해 통신.
        rootView.nextStepButton.rx.tap
            .subscribe(onNext: { _ in
                self.viewModel.input.pushDetailInterestViewTrigger.onNext(self.selectedCellIndex)
            })
            .disposed(by: disposeBag)
    }
    
    private func navigationUI() {
        self.navigationController?.isNavigationBarHidden = false
        let leftBarButtonItem = UIBarButtonItem.init(image:  UIImage(named: "backBarButton"), style: .plain, target: self, action: #selector(backBarButtonClicked))
        leftBarButtonItem.tintColor = AppColor.joinText
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        let titleLabel = UILabel()
        titleLabel.text = "관심사를 설정해주세요"
        titleLabel.textColor = AppColor.joinText
        titleLabel.textAlignment = .center
        titleLabel.font = notoSansFont.Regular.of(size: 20)
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
    }
    
    @objc func backBarButtonClicked() {
        self.viewModel.input.popInterestsViewTrigger.onNext(())
    }
}

extension InterestsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width / 4
        let height: CGFloat = collectionView.frame.height / 3.5
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return UIScreen.main.bounds.height * 0.0418
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return UIScreen.main.bounds.width * 0.098
    }
}
