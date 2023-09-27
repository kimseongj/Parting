//
//  CreatePartyViewController.swift
//  Parting
//
//  Created by 박시현 on 2023/07/22.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher
import Toast
import MultiSlider

class CreatePartyViewController: BaseViewController<CreatePartyView> {
    var currentSelectedIndex: Int?
    var selectedDetailCategoryLists = Set<Int>()
    var categoryDetailIDList: [Int] = []
    static var partyTitle: String = ""
    var hashTagNameList: [String] = []
    var selectedCategoryID: Int?
    var maxAge: Int?
    var minAge: Int?
    var latitude: Double?
    var longitude: Double?
   
    private var viewModel: CreatePartyViewModel
    private var setMapViewModel = SetMapViewModel(coordinator: HomeCoordinator(UINavigationController()))
    init(viewModel: CreatePartyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    deinit {
        print("CreatePartyVC 메모리해제")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUI()
        registerCell()
        bind()
        setDelegateTextField()
        setDelegateTextView()
        getSliderValues()
    }
    
    private func navigationUI() {
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.titleView = rootView.navigationLabel
        self.navigationItem.leftBarButtonItem = rootView.backBarButton
    }
    
    private func getSliderValues() {
        rootView.setAgeMultislider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
    }
    
    @objc
    private func sliderChanged() {
        maxAge = Int(rootView.setAgeMultislider.value[0])
        minAge = Int(rootView.setAgeMultislider.value[1])
        print(Int(rootView.setAgeMultislider.value[0]), Int(rootView.setAgeMultislider.value[1]))
    }
    
    private func setDelegateTextField() {
        rootView.setPartyTimeTextField.delegate = self
        rootView.setPartyYearAndMonthTextField.delegate = self
        rootView.numberOfPeopleTextField.delegate = self
    }
    
    private func setDelegateTextView() {
        rootView.aboutPartyContentsTextView.delegate = self
    }
    
    private func bind() {
        rootView.aboutPartyContentsTextView.rx.text
            .map { $0?.count }
            .bind { [weak self] textCount in
                guard let textCount else { return }
                self?.rootView.textViewTextCount.text = "\(textCount)/200"
            }
            .disposed(by: disposeBag)
        
        rootView.setLocationButton.rx.tap
            .bind(to: viewModel.input.setMapVCTrigger)
            .disposed(by: disposeBag)
        
        rootView.backBarButton.innerButton.rx.tap
            .bind(to: viewModel.input.popVCTrigger)
            .disposed(by: disposeBag)
        
        // MARK: - 모임 테마 설정 cellForItemAt(DataSource)
        viewModel.output.categories
            .bind(to: rootView.categoryCollectionView.rx.items(cellIdentifier: CategoryImageCollectionViewCell.identifier, cellType: CategoryImageCollectionViewCell.self)) { [weak self]
                row, category, cell in
                guard let localImage = category.localImgSrc else { return }
                let image = UIImage.loadImageFromDiskWith(fileName: localImage)
                cell.interestsImageView.image = image
                cell.interestsLabel.text = category.name
                
                if self?.viewModel.selectedIndex == row {
                    cell.configureCell(type: .normal, size: .md)
                } // selectedIndex가 cell의 index와 다르면 configure(.deselectable)
                else {
                    cell.configureCell(type: .deselectable, size: .md)
                }
            }
            .disposed(by: disposeBag)
        
        viewModel.selectedDetailCategoryCell
            .subscribe(onNext: { [weak self] data in
                self?.selectedDetailCategoryLists = data
            })
            .disposed(by: disposeBag)
        
        // MARK: - 세부 카테고리 CellForItemAt(DataSource)
        viewModel.output.categoryDetailLists
            .bind(to: rootView.detailCategoryCollectionView.rx
                .items(cellIdentifier: detailCategoryCollectionViewCell.identifier, cellType: detailCategoryCollectionViewCell.self)) { [weak self] row, element, cell in
                    cell.configure(self?.viewModel.categoryDetailListsData?[row].categoryDetailName ?? "")
                    cell.changeCellState(element.isClicked)
                }
            .disposed(by: disposeBag)
        
        // MARK: - DidSelectItem
        Observable
            .zip(rootView.detailCategoryCollectionView.rx.modelSelected(CategoryDetailResultContainisSelected.self), rootView.detailCategoryCollectionView.rx.itemSelected)
            .subscribe(onNext: { [weak self] (item, indexPath) in
                item.isClicked = !item.isClicked
                self?.categoryDetailIDList.append(item.categoryDetailID)
                self?.rootView.detailCategoryCollectionView.reloadData()

            })
            .disposed(by: disposeBag)
        
        rootView.setPartyBackgroundView.textField?.rx.text
            .bind{ [weak self] text in
                guard let text else { return }
                CreatePartyViewController.partyTitle = text
            }
            .disposed(by: disposeBag)
        
        rootView.setHashTagBackgroundView.textField?.rx.text
            .bind { [weak self] text in
                guard let text else { return }
                self?.hashTagNameList = text.replacingOccurrences(of: " ", with: "").split(separator: ",").map{String($0)}
            }
            .disposed(by: disposeBag)

        Observable
            .zip(rootView.categoryCollectionView.rx.modelSelected(CategoryModel.self), rootView.categoryCollectionView.rx.itemSelected)
            .subscribe(onNext: { [weak self] (item, indexPath) in
                self?.viewModel.isSeletedCellIdx.onNext(indexPath.item)
                self?.viewModel.partyCellClicked(categoryId: item.id)
                self?.viewModel.selectedIndex = indexPath.item
                self?.rootView.categoryCollectionView.reloadData()

                self?.viewModel.selectedDetailCategoryCell.accept([])
                self?.rootView.detailCategoryCollectionView.reloadData()

                self?.selectedCategoryID = item.id
            })
            .disposed(by: disposeBag)
        
        viewModel.output.categoryDetailLists
            .withUnretained(self)
            .subscribe(onNext: { owner, detaillists in
                owner.rootView.detailCategoryCollectionView.reloadData()
            })
            .disposed(by: disposeBag)
        
        viewModel.toastMessage
            .observe(on: MainScheduler.instance)
            .bind { [weak self] toastMessage in
                self?.rootView.makeToast(toastMessage)
            }
            .disposed(by: disposeBag)
        
        viewModel.selectedDetailCategoryCell
            .bind { [weak self] indexList in
                print(indexList)
                self?.selectedDetailCategoryLists = indexList
                self?.rootView.detailCategoryCollectionView.reloadData()
            }
            .disposed(by: disposeBag)
        
        
        rootView.completeCreatePartyButton.rx.tap
            .bind { [weak self] _ in
                guard let numberOfPeople = Int(self?.rootView.numberOfPeopleTextField.text ?? "0") else { return } // 토스트
                guard let categoryDetailIDList = self?.categoryDetailIDList else { return }
                guard let selectedCategoryID = self?.selectedCategoryID else { return }
                guard let hashTagNameList = self?.hashTagNameList else { return }
                guard let maxAge = self?.maxAge else { return }
                guard let minAge = self?.minAge else { return }
                guard let openChatURL = self?.rootView.openKakaoChatTextField.text else { return }
                guard let partyDescription = self?.rootView.aboutPartyContentsTextView.text else { return }
                guard let partyName = self?.rootView.setPartyBackgroundView.textField?.text else { return }
                guard let latitude = self?.latitude else { return }
                guard let longitude = self?.longitude else { return }
                
                self?.viewModel.createPartyAPICall(
                    CreatePartyMockData.address,
                    numberOfPeople,
                    categoryDetailIDList,
                    selectedCategoryID,
                    hashTagNameList,
                    maxAge,
                    minAge,
                    openChatURL,
                    partyDescription,
                    CreatePartyMockData.partyEndDateTime,
                    latitude,
                    longitude,
                    partyName,
                    CreatePartyMockData.partyStartDateTime,
                    CreatePartyMockData.storeName
                )
                
                print(latitude, longitude)
                
                self?.viewModel.input.popVCTrigger.onNext(())
            }
            .disposed(by: disposeBag)
    }
    
    private func registerCell() {
        rootView.categoryCollectionView.register(CategoryImageCollectionViewCell.self, forCellWithReuseIdentifier: CategoryImageCollectionViewCell.identifier)
        rootView.categoryCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        rootView.detailCategoryCollectionView.register(detailCategoryCollectionViewCell.self, forCellWithReuseIdentifier: detailCategoryCollectionViewCell.identifier)

        rootView.detailCategoryCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
}

extension CreatePartyViewController: SendCoordinate {
    func sendLatAndLng(_ lat: Double, _ lng: Double) {
        print(lat, lng, "🌟")
        latitude = lat
        longitude = lng
    }
}

extension CreatePartyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case rootView.categoryCollectionView:
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
        default:
            break
        }
        return CGSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24.0 // height
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 32.0 // horizontal spacing
    }
}

extension CreatePartyViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
extension CreatePartyViewController: UITextViewDelegate {
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let char = text.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        guard textView.text!.count < 200 else { return false }
        return true
    }
}
