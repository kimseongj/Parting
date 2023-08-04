//
//  CreatePartyView.swift
//  Parting
//
//  Created by 박시현 on 2023/07/22.
//

import UIKit
import SnapKit
import MultiSlider

enum SetPartyList {
    case setParty
    case setHashTag
    case setPartyDate
    
    var title: String {
        switch self {
        case .setParty:
            return "파티 제목"
        case .setHashTag:
            return "해시태그"
        case .setPartyDate:
            return "파티 일시"
        }
    }
    
    var placeHolder: String {
        switch self {
        case .setParty:
            return "  파티 제목을 입력해 주세요"
        case .setHashTag:
            return "  #해시태그"
        default:
            return ""
        }
    }
}

//MARK: - 수정 예정 => UICollectionView로 구현해서 Section별 Cell에 컴포넌트들 배치해야할 것 같음 
final class CreatePartyView: BaseView {
    let navigationLabel: BarTitleLabel = BarTitleLabel(text: "파티개설")
    let themeLabel = CreatePartyCommonLabel(text: "모임 테마 설정")
    let setPartyLabel: CreatePartyCommonLabel = CreatePartyCommonLabel(text: "파티 기본 설정")
    let introPartyLabel: CreatePartyCommonLabel = CreatePartyCommonLabel(text: "파티 소개")
    
    let backBarButton = BarImageButton(imageName: Images.icon.back)
    
    let setPartyTitleLabel =  SetTitleLabel(set: .setParty)
    let setHashTagLabel = SetTitleLabel(set: .setHashTag)
    let setPartyDateLabel = SetTitleLabel(set: .setPartyDate)
    
    let maxSelectLabelNotiLabel = IntroLabel(type: .maxSelectLabelNotiLabel)
    
    let detailCategoryLabel = CreatePartyCommonLabel(text: "세부 카테고리")
    
    let test1 = SetTextCountLabel() // 0xAA -> 힙영역의 주소값
    let test2 = SetTextCountLabel() // 0xFF
    
    lazy var setPartyBackgroundView = SetBackGroundView(
        textCountLabel: test1, // 0xAA 값 복사
        underLineLabel: SetUnderlineLabel(),
        placeHolder: SetPartyList.setParty.placeHolder
    )
    lazy var setHashTagBackgroundView = SetBackGroundView(
        textCountLabel: test2, // 0xFF
        underLineLabel: SetUnderlineLabel(),
        placeHolder: SetPartyList.setHashTag.placeHolder
    )
    
    lazy var setPartyCreateView = SetCreatePartyView(titleLabel: setPartyTitleLabel, backGroundView: setPartyBackgroundView)
    lazy var setHashCreateView = SetCreatePartyView(titleLabel: setHashTagLabel, backGroundView: setHashTagBackgroundView)
    
    let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false // scroll 기능 막기
        return collectionView
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    // MARK: - 스크롤뷰 내부에 들어갈 Content View
    // UI 컴포넌트들이 contentView에 들어가야함
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var detailCategoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.layer.borderWidth = 1
        collectionView.layer.cornerRadius = 5
        collectionView.layer.borderColor = UIColor(hexcode: "EEEEEE").cgColor
        return collectionView
    }()
    
    let setPartyBirthAndMonthTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "  년,월,일"
        textField.layer.borderColor = UIColor(hexcode: "EEEEEE").cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let setPartyTimeTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "  시"
        textField.layer.borderColor = UIColor(hexcode: "EEEEEE").cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        return textField
    }()
    
    let partyTimeView: UIView = {
        let view = UIView()
        return view
    }()
    
    let setPartyDateBackgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    let setPartyView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor(hexcode: "EEEEEE").cgColor
        return view
    }()
    
    let setLocationButton: UIButton = {
        let button = UIButton()
        button.setTitle("지도에서 위치 설정", for: .normal)
        button.titleLabel?.font = notoSansFont.Black.of(size: 16)
        button.setTitleColor(UIColor(hexcode: "676767"), for: .normal)
        button.setImage(UIImage(named: Images.icon.compass), for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor(hexcode: "EEEEEE").cgColor
        button.layer.borderWidth = 1
        button.imageEdgeInsets.left = -8
        return button
    }()
    
    let numberOfPeopleTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "파티 인원수"
        label.textAlignment = .center
        label.font = notoSansFont.Black.of(size: 15)
        label.textColor = UIColor(hexcode: "676767")
        return label
    }()
    
    let numberOfPeopleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor(hexcode: "EEEEEE").cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let numberOfPeopleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        return stackView
    }()
    
    let minAndMaxPeople = IntroLabel(type: .minAndMaxPeople)
    
    let setAgeLabel: UILabel = {
        let label = UILabel()
        label.text = "연령대 설정"
        label.textAlignment = .center
        label.font = notoSansFont.Black.of(size: 15)
        label.textColor = UIColor(hexcode: "676767")
        return label
    }()
    
    let setAgeMultislider: MultiSlider = {
        let multislider = MultiSlider()
        multislider.minimumValue = 1
        multislider.maximumValue = 50
        multislider.value = [1, 50]
        multislider.orientation = .horizontal
        multislider.tintColor = AppColor.brand
        multislider.thumbTintColor = AppColor.brand
        multislider.thumbImage = UIImage(named: "sliderThumb")
        multislider.outerTrackColor = .lightGray
        multislider.valueLabelPosition = .bottom
        multislider.valueLabelColor = UIColor(hexcode: "D0D0D0")
        multislider.snapStepSize = 1.0 // value값 Int형
        multislider.valueLabelFont = notoSansFont.Black.of(size: 12)
        return multislider
    }()
    
    let setAgeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .horizontal
        return stackView
    }()
    
    let introContentsLabel = IntroLabel(type: .introContentsLabel)
    
    let openKakaoChatTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "카카오톡 오픈채팅방 링크"
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor(hexcode: "EEEEEE").cgColor
        textField.layer.borderWidth = 1
        return textField
    }()
    
    let aboutPartyContentsTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor(hexcode: "EEEEEE").cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 5
        return textView
    }()
    
    let completeCreatePartyButton = CompleteAndNextButton("파티 등록 완료")
    
    let textViewTextCount: UILabel = {
        let label = UILabel()
        label.text = "0/200"
        label.textAlignment = .center
        label.font = notoSansFont.Regular.of(size: 12)
        label.textColor = UIColor(hexcode: "D3D3D3")
        return label
    }()
    
    func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(77), heightDimension: .absolute(30))
        
        let titleItem = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(30))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [titleItem])
        
        group.interItemSpacing = .fixed(10) // 아이템간 간격(가로)
        
        let headersize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(25))
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headersize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 16, trailing: 8)
        section.interGroupSpacing = 8 // 그룹간 간격(세로)
        section.decorationItems = [
            NSCollectionLayoutDecorationItem.background(elementKind: CustomGroupView.reuseIdentifier)
        ]
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 33
        let layout = UICollectionViewCompositionalLayout(section: section, configuration: config)
        layout.register(CustomGroupView.self, forDecorationViewOfKind: CustomGroupView.reuseIdentifier)
        return layout
    }
    
    override func makeConfigures() {
        super.makeConfigures()
        [themeLabel, categoryCollectionView, detailCategoryLabel, maxSelectLabelNotiLabel, detailCategoryCollectionView, setPartyLabel, setPartyView, introPartyLabel, setLocationButton, numberOfPeopleStackView, minAndMaxPeople, setAgeStackView, introPartyLabel, introContentsLabel, openKakaoChatTextField,aboutPartyContentsTextView, completeCreatePartyButton, textViewTextCount].forEach {
            contentView.addSubview($0)
        }
        
        partyTimeView.addSubview(setPartyTimeTextField)
        partyTimeView.addSubview(setPartyBirthAndMonthTextField)
        
        setPartyDateBackgroundView.addSubview(setPartyDateLabel)
        setPartyDateBackgroundView.addSubview(partyTimeView)
        
        setPartyView.addSubview(setPartyCreateView)
        setPartyView.addSubview(setHashCreateView)
        setPartyView.addSubview(setPartyDateBackgroundView)
        
        numberOfPeopleStackView.addArrangedSubview(numberOfPeopleTitleLabel)
        numberOfPeopleStackView.addArrangedSubview(numberOfPeopleView)
        
        setAgeStackView.addArrangedSubview(setAgeLabel)
        setAgeStackView.addArrangedSubview(setAgeMultislider)
        
        scrollView.addSubview(contentView)
        addSubview(scrollView)
    }
    
    override func makeConstraints() {
        setPartyView.snp.makeConstraints { make in
            make.top.equalTo(setPartyLabel.snp.bottom).offset(9)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalToSuperview().multipliedBy(0.158)
        }
        
        setPartyDateLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.width.equalTo(setPartyTitleLabel.snp.width)
            make.leading.equalToSuperview()
        }
        
        partyTimeView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalTo(setPartyDateLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
        }
        
        setPartyBirthAndMonthTextField.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.9)
        }
        
        setPartyTimeTextField.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.15)
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.9)
        }
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.height.greaterThanOrEqualTo(self.snp.height).priority(.low)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        themeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.352)
            make.height.equalTo(24)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(themeLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(UIScreen.main.bounds.height * 0.25)
        }
        
        detailCategoryLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.352)
            make.height.equalTo(24)
        }
        
        maxSelectLabelNotiLabel.snp.makeConstraints { make in
            make.top.equalTo(detailCategoryLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(24)
        }
        
        detailCategoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(maxSelectLabelNotiLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(150)
        }
        
        setPartyLabel.snp.makeConstraints { make in
            make.top.equalTo(detailCategoryCollectionView.snp.bottom).offset(27)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.352)
            make.height.equalTo(24)
        }
        
        setPartyCreateView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(20)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        setHashCreateView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(setPartyCreateView.snp.bottom).offset(20)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        setPartyDateBackgroundView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(20)
            make.top.equalTo(setHashCreateView.snp.bottom).offset(20)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        setLocationButton.snp.makeConstraints { make in
            make.top.equalTo(setPartyView.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(43)
        }
        
        numberOfPeopleTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
        }

        numberOfPeopleView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.65)
        }
        
        numberOfPeopleStackView.snp.makeConstraints { make in
            make.top.equalTo(setLocationButton.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(43)
        }
        
        minAndMaxPeople.snp.makeConstraints { make in
            make.top.equalTo(numberOfPeopleView.snp.bottom).offset(7)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalToSuperview().multipliedBy(0.43)
            make.height.equalTo(24)
        }
        
        setAgeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        
        setAgeMultislider.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.65)
        }
        
        setAgeStackView.snp.makeConstraints { make in
            make.top.equalTo(minAndMaxPeople.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(43)
        }
        
        introPartyLabel.snp.makeConstraints { make in
            make.top.equalTo(setAgeLabel.snp.bottom).offset(49)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.352)
            make.height.equalTo(24)
        }
        
        introContentsLabel.snp.makeConstraints { make in
            make.top.equalTo(introPartyLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(26)
        }
        
        openKakaoChatTextField.snp.makeConstraints { make in
            make.top.equalTo(introContentsLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(42)
        }
        
        aboutPartyContentsTextView.snp.makeConstraints { make in
            make.top.equalTo(openKakaoChatTextField.snp.bottom).offset(13)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(138)
        }
        
        textViewTextCount.snp.makeConstraints { make in
            make.top.equalTo(aboutPartyContentsTextView.snp.bottom)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(48)
            make.height.equalTo(24)
        }
        
        completeCreatePartyButton.snp.makeConstraints { make in
            make.top.equalTo(aboutPartyContentsTextView.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(46)
        }
    }
    
}
