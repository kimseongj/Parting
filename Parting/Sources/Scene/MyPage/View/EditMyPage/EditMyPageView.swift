//
//  EditMyPageView.swift
//  Parting
//
//  Created by 이병현 on 2023/09/22.
//

import UIKit
import SnapKit
import Kingfisher

final class EditMyPageView: BaseView {
    
    var backBarButton = BarImageButton(imageName: Images.icon.back)
    let navigationLabel: BarTitleLabel = BarTitleLabel(text: "프로필 수정")
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    let contentsView: UIView = {
        let view = UIView()
        return view
    }()
    
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        return picker
    }()
    
    let regionPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    let profileImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = AppColor.brand
        view.clipsToBounds = true
        return view
    }()
    
    let profileEditButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "camera"), for: .normal)
        return button
    }()
    
    let nameTextFieldContainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexcode: "F8FAFD")
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor(hexcode: "E7ECF3").cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    let duplicatedNickNameCheckButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(hexcode: "F8FAFD")
        button.layer.borderColor = UIColor(hexcode: "E7ECF3").cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = AppFont.Regular.of(size: 13)
        button.setTitle("중복확인", for: .normal)
        button.setTitleColor(UIColor(hexcode: "A7B0C0"), for: .normal)
        return button
    }()
    
    let genderLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Regular.of(size: 16)
        label.textColor = UIColor(hexcode: "404040")
        label.text = "성별"
        return label
    }()
    
    let manButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 17
        button.backgroundColor = UIColor(hexcode: "F8FAFD")
        button.layer.borderColor = UIColor(hexcode: "E7ECF3").cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = AppFont.Regular.of(size: 13)
        button.setTitle("남", for: .normal)
        button.setTitleColor(UIColor(hexcode: "A7B0C0"), for: .normal)
        return button
    }()
    
    let womanButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 17
        button.backgroundColor = UIColor(hexcode: "F8FAFD")
        button.layer.borderColor = UIColor(hexcode: "E7ECF3").cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = AppFont.Regular.of(size: 13)
        button.setTitle("여", for: .normal)
        button.setTitleColor(UIColor(hexcode: "A7B0C0"), for: .normal)
        return button
    }()
    
    let birthLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Regular.of(size: 16)
        label.textColor = UIColor(hexcode: "404040")
        label.text = "생년월일"
        return label
    }()
    
    let birthTextField: UITextField = {
        let textField = UITextField()
        textField.font = AppFont.Regular.of(size: 13)
        textField.attributedPlaceholder = NSAttributedString(string: "yyyy-MM-dd", attributes: [.foregroundColor: AppColor.gray200, .font: AppFont.Regular.of(size: 13)])
        textField.backgroundColor = UIColor(hexcode: "F8FAFD")
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = UIColor(hexcode: "E7ECF3").cgColor
        textField.layer.borderWidth = 1
        textField.textAlignment = .center
        return textField
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Regular.of(size: 16)
        label.textColor = UIColor(hexcode: "404040")
        label.text = "주소"
        return label
    }()
    
    let sidoTextField: UITextField = {
        let textField = UITextField()
        textField.font = AppFont.Regular.of(size: 13)
        textField.attributedPlaceholder = NSAttributedString(string: "시/도 선택", attributes: [.foregroundColor: AppColor.gray200, .font: AppFont.Regular.of(size: 13)])
        textField.backgroundColor = UIColor(hexcode: "F8FAFD")
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = UIColor(hexcode: "E7ECF3").cgColor
        textField.layer.borderWidth = 1
        textField.textAlignment = .center
        return textField
    }()
    
    let sigugunTextField: UITextField = {
        let textField = UITextField()
        textField.font = AppFont.Regular.of(size: 13)
        textField.attributedPlaceholder = NSAttributedString(string: "시/군/구 선택", attributes: [.foregroundColor: AppColor.gray200, .font: AppFont.Regular.of(size: 13)])
        textField.backgroundColor = UIColor(hexcode: "F8FAFD")
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = UIColor(hexcode: "E7ECF3").cgColor
        textField.layer.borderWidth = 1
        textField.textAlignment = .center
        return textField
    }()
    
    let addressStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.distribution = .fillProportionally
        return view
    }()
    
    let introduceLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Regular.of(size: 16)
        label.textColor = UIColor(hexcode: "404040")
        label.text = "자기소개"
        return label
    }()
    
    let introduceExplainTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = UIColor(hexcode: "F8FAFD")
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor(hexcode: "E7ECF3").cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let introduceTextCountLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Regular.of(size: 14)
        label.textColor = AppColor.gray400
        label.textAlignment = .right
        label.text = "0/40"
        return label
    }()
    
    let myInterestLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Regular.of(size: 16)
        label.textColor = UIColor(hexcode: "404040")
        label.text = "나의 관심사"
        return label
    }()
    
    let myInterestButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrowRight"), for: .normal)
        return button
    }()
    
    lazy var myInterestCollectionView = UICollectionView(frame: .zero, collectionViewLayout: interestCellLayout())
    
    let finishButton = CompleteAndNextButton("완료")
    
    override func makeConfigures() {
        super.makeConfigures()
        
        addressStackView.addArrangedSubview(sidoTextField)
        addressStackView.addArrangedSubview(sigugunTextField)
        myInterestCollectionView.isScrollEnabled = false
        
        [profileImageView, profileEditButton, nameTextFieldContainView, nameTextField, duplicatedNickNameCheckButton, genderLabel, manButton, womanButton, birthLabel, birthTextField, addressLabel, addressStackView, introduceLabel, myInterestLabel, myInterestButton, myInterestCollectionView, finishButton, introduceExplainTextView, introduceTextCountLabel].forEach {
            contentsView.addSubview($0)
        }
        
        scrollView.addSubview(contentsView)
        addSubview(scrollView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = 65 / 2
    }
    
    override func makeConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentsView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
            make.height.greaterThanOrEqualTo(self.snp.height).priority(.low)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.leading.equalTo(safeAreaLayoutGuide).offset(24)
            make.height.width.equalTo(65)
        }
        
        profileEditButton.snp.makeConstraints { make in
            make.bottom.equalTo(profileImageView.snp.bottom).offset(1)
            make.trailing.equalTo(profileImageView.snp.trailing).offset(4)
            make.height.width.equalTo(24)
        }
        
        duplicatedNickNameCheckButton.snp.makeConstraints { make in
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-24)
            make.top.equalToSuperview().offset(43)
            make.width.equalTo(69)
            make.height.equalTo(37)
        }
        
        nameTextFieldContainView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(duplicatedNickNameCheckButton)
            make.leading.equalTo(profileImageView.snp.trailing).offset(12)
            make.trailing.equalTo(duplicatedNickNameCheckButton.snp.leading).offset(-12)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(nameTextFieldContainView).inset(8)
            make.verticalEdges.equalTo(nameTextFieldContainView)
        }
        
        genderLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(29)
            make.leading.equalTo(safeAreaLayoutGuide).offset(24)
            make.width.equalTo(56)
            make.height.equalTo(19)
        }
        
        manButton.snp.makeConstraints { make in
            make.leading.equalTo(genderLabel.snp.trailing).offset(25)
            make.centerY.equalTo(genderLabel)
            make.height.width.equalTo(34)
        }
        
        womanButton.snp.makeConstraints { make in
            make.leading.equalTo(manButton.snp.trailing).offset(6)
            make.centerY.equalTo(genderLabel)
            make.height.width.equalTo(34)
        }
        
        birthLabel.snp.makeConstraints { make in
            make.top.equalTo(genderLabel.snp.bottom).offset(41)
            make.leading.equalTo(safeAreaLayoutGuide).offset(24)
            make.width.equalTo(56)
            make.height.equalTo(19)
        }
        
        birthTextField.snp.makeConstraints { make in
            make.leading.equalTo(genderLabel.snp.trailing).offset(25)
            make.centerY.equalTo(birthLabel)
            make.height.equalTo(37)
            make.width.equalTo(103)
        }
        
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(birthLabel.snp.bottom).offset(33)
            make.leading.equalTo(safeAreaLayoutGuide).offset(24)
            make.width.equalTo(56)
            make.height.equalTo(19)
        }
        
        addressStackView.snp.makeConstraints { make in
            make.top.equalTo(addressLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(37)
        }
        
        introduceLabel.snp.makeConstraints { make in
            make.top.equalTo(addressStackView.snp.bottom).offset(24)
            make.leading.equalTo(safeAreaLayoutGuide).offset(24)
            make.width.equalTo(56)
            make.height.equalTo(19)
        }
        
        introduceExplainTextView.snp.makeConstraints { make in
            make.top.equalTo(introduceLabel.snp.bottom).offset(8)
            make.height.equalTo(76)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        introduceTextCountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(introduceExplainTextView.snp.bottom).inset(10)
            make.trailing.equalTo(introduceExplainTextView.snp.trailing).inset(13)
            make.height.equalTo(17)
            make.width.equalTo(48)
        }
        
        myInterestLabel.snp.makeConstraints { make in
            make.top.equalTo(introduceExplainTextView.snp.bottom).offset(24)
            make.leading.equalTo(safeAreaLayoutGuide).offset(24)
            make.height.equalTo(28)
            make.width.equalTo(74)
        }
        
        myInterestCollectionView.snp.makeConstraints { make in
            make.top.equalTo(myInterestLabel.snp.bottom).offset(4)
            make.height.equalTo(74)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
        }
        
        myInterestButton.snp.makeConstraints { make in
            make.leading.equalTo(myInterestLabel.snp.trailing).offset(4)
            make.centerY.equalTo(myInterestLabel)
            make.height.width.equalTo(24)
        }
        
        finishButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.top.equalTo(myInterestCollectionView.snp.bottom).offset(30)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-39)
        }
        
    }
}

extension EditMyPageView {
    
    private func interestCellLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider:
                { sectionIndex, layoutEnvironment in
                    return self.interestLayout()
                },
            configuration: configuration)
        return collectionViewLayout
    }
    
    
    private func interestLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.2),
            heightDimension: .absolute(70)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .groupPaging /// Set Scroll Direction
        return section
    }
}

extension EditMyPageView {
    func genderButtonTap(genderCase: GenderCase) {
        switch genderCase {
            
        case .man:
            manButtonTapped()
        case .woman:
            womanButtonTapped()
        }
    }
}

extension EditMyPageView {
    private func manButtonTapped() {
        womanButton.backgroundColor = UIColor(hexcode: "F8FAFD")
        womanButton.setTitleColor(UIColor(hexcode: "A7B0C0"), for: .normal)
        manButton.backgroundColor = AppColor.brand
        manButton.setTitleColor(AppColor.white, for: .normal)
    }
    
    private func womanButtonTapped() {
        manButton.backgroundColor = UIColor(hexcode: "F8FAFD")
        manButton.setTitleColor(UIColor(hexcode: "A7B0C0"), for: .normal)
        womanButton.backgroundColor = AppColor.brand
        womanButton.setTitleColor(AppColor.white, for: .normal)
    }
}

extension EditMyPageView {
    func updateDupricatedButton(text: String) {
        if text.count >= 2 {
            duplicatedNickNameCheckButton.layer.borderColor = AppColor.brand.cgColor
            duplicatedNickNameCheckButton.setTitleColor(AppColor.brand, for: .normal)
        } else {
            duplicatedNickNameCheckButton.layer.borderColor = UIColor(hexcode: "E7ECF3").cgColor
            duplicatedNickNameCheckButton.setTitleColor(UIColor(hexcode: "A7B0C0"), for: .normal)
        }
    }
}

extension EditMyPageView {
    func updateTextCountLabel(text: String) {
        introduceTextCountLabel.text = "\(text.count)/40"
    }
}

extension EditMyPageView {
    func configureEditMyPageUI(_ item: MyPageResponse) {
        introduceExplainTextView.text = item.result.introduce
        birthTextField.text = item.result.birth
        nameTextField.text = item.result.nickName

        if item.result.sex == "M" {
            self.genderButtonTap(genderCase: .man)
        } else {
            self.genderButtonTap(genderCase: .woman)
        }
        guard let url = URL(string: item.result.profileImgUrl) else { return }
        profileImageView.kf.setImage(with: url)
    }
}

extension EditMyPageView {
    func updateProfileImage(image: UIImage) {
        self.profileImageView.contentMode = .scaleToFill
        let resizeImage = image.resizeImageTo(size: CGSize(width: self.profileImageView.frame.width, height: self.profileImageView.frame.height))
        self.profileImageView.image = resizeImage
    }
}
