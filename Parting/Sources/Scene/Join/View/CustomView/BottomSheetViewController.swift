//
//  BottomSheetViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/07/19.
//

import UIKit
import RxSwift
import RxCocoa

final class BottomSheetViewController: BaseViewController<BottomSheetView> {
    
    private let viewModel: BottomSheetViewModel
    
    init(viewModel: BottomSheetViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [ .medium(), .large()]
            sheetPresentationController.largestUndimmedDetentIdentifier = .medium
            sheetPresentationController.preferredCornerRadius = 50
            sheetPresentationController.prefersGrabberVisible = true
            sheetPresentationController.delegate = self
        }
        
        updateUI()
        registerCell()
        setDelegateAndDataSource()
        bind()
    }
    
    private func setDelegateAndDataSource() {
        rootView.testCollectionView.delegate = self
        rootView.testCollectionView.dataSource = self
    }
    
    private func registerCell() {
        rootView.testCollectionView.register(HashTagCollectionViewCell.self, forCellWithReuseIdentifier: HashTagCollectionViewCell.identifier)
    }
    
    private func updateUI() {
        guard let partyInfoData = viewModel.partyInfoData else { return }
        rootView.configureView(model: partyInfoData)
    }
    
    private func bind() {
        rootView.closeButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, event in
                owner.viewModel.input.onNext(.closeButtonClicked)
            })
            .disposed(by: disposeBag)
    }
    
}

extension BottomSheetViewController: UISheetPresentationControllerDelegate {
    func sheetPresentationControllerDidChangeSelectedDetentIdentifier(_ sheetPresentationController: UISheetPresentationController) {
        print("sheet의 detent 변경!")
        print(sheetPresentationController.selectedDetentIdentifier)
    }
}


extension BottomSheetViewController: UICollectionViewDelegate {
    
}

extension BottomSheetViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let hashTagCount = viewModel.partyInfoData?.result.partyInfos[0].hashTagNameList.count else { return 0 }
        return hashTagCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HashTagCollectionViewCell.identifier, for: indexPath) as? HashTagCollectionViewCell else { return UICollectionViewCell() }
        guard let tagName = viewModel.partyInfoData?.result.partyInfos[0].hashTagNameList[indexPath.item] else { return UICollectionViewCell() }
        cell.configureCell(name: tagName)
        return cell
    }
    
    
}
