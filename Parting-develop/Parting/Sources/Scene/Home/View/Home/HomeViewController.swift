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



class HomeViewController: BaseViewController<HomeView> {
	
	private var viewModel: HomeViewModel
    init(viewModel: HomeViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    
    deinit {
        print("HomeVC 메모리해제 🌟")
    }
	
	override func viewDidLoad() {
		super.viewDidLoad()
        viewModel.input.viewDidLoadTrigger.onNext(())
		navigationUI()
		bindViewModel()
		configureCell()
	}
	
	
	private func navigationUI() {
		navigationController?.isNavigationBarHidden = false
		self.navigationItem.rightBarButtonItem = rootView.bellBarButton
		self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: rootView.navigationLabel)
	}
	
	private func configureCell() {
		rootView.categoryCollectionView.register(CategoryImageCollectionViewCell.self, forCellWithReuseIdentifier: CategoryImageCollectionViewCell.identifier)
		
		rootView.categoryCollectionView.rx.setDelegate(self)
			.disposed(by: disposeBag)
		
		rootView.categoryCollectionView.rx.itemSelected
            .withUnretained(self)
			.subscribe { owner, indexPath in
				let index = indexPath[1]
                let categories = owner.viewModel.output.categories.value
				owner.viewModel.pushPartyListVC(category: categories[index])
			}
			.disposed(by: disposeBag)
	}
	
	
	private func bindViewModel() {
		rootView.calendarWidget.rx.tap
			.bind(to: viewModel.input.pushScheduleVCTrigger)
			.disposed(by: disposeBag)
		
		viewModel.output.categories
			.bind(to: rootView.categoryCollectionView.rx.items(cellIdentifier: CategoryImageCollectionViewCell.identifier, cellType: CategoryImageCollectionViewCell.self)) { index, category, cell in
                print("\(category.localImgSrc)")
                guard let localImage = category.localImgSrc else { return }
				let image = UIImage.loadImageFromDiskWith(fileName: localImage)
				cell.interestsImageView.image = image
				cell.interestsLabel.text = category.name
				cell.configureCell(type: .normal, size: .md)
			}.disposed(by: disposeBag)
        
        viewModel.output.widgetData
            .filter { $0 != nil}
            .withUnretained(self)
            .subscribe(onNext: { owner, widget in
                guard let widget else { return }
                owner.rootView.configureView(widgetData: widget)
            })
            .disposed(by: disposeBag)
        
        viewModel.output.calendarData
            .filter { $0 != nil}
            .withUnretained(self)
            .subscribe(onNext: { owner, day in
                guard let day else { return }
                owner.rootView.receiveData(calendarDays: day)
            })
            .disposed(by: disposeBag)
	}
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
	
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let width: CGFloat = collectionView.frame.width
		let height: CGFloat = collectionView.frame.height
		let columns: CGFloat = 4.0
		let rows: CGFloat = 2.0
		let horizontalSpacing: CGFloat = 32.0
		let verticalSpacing: CGFloat = 24.0
		
		let totalHorizontalSpacing = (columns - 1) * horizontalSpacing
		let totalVerticalSpacing = (rows - 1) * verticalSpacing
		let itemWidth = (width - totalHorizontalSpacing) / columns
		let itemHeight = (height - totalVerticalSpacing) / rows
		let itemSize = CGSize(width: itemWidth, height: itemHeight)
		
		return itemSize
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 24.0 // height
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 32.0 // horizontal spacing
		
	}
}


