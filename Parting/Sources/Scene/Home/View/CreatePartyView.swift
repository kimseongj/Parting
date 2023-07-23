//
//  CreatePartyView.swift
//  Parting
//
//  Created by 박시현 on 2023/07/22.
//

import UIKit
import SnapKit


//MARK: - 수정 예정 => UICollectionView로 구현해서 Section별 Cell에 컴포넌트들 배치해야할 것 같음 
final class CreatePartyView: BaseView {
    let navigationLabel: BarTitleLabel = BarTitleLabel(text: "파티개설")
    let themeLabel = CreatePartyCommonLabel(text: "모임 테마 설정")
    let setPartyLabel: CreatePartyCommonLabel = CreatePartyCommonLabel(text: "파티 기본 설정")
    
    let introPartyLabel: CreatePartyCommonLabel = CreatePartyCommonLabel(text: "파티 소개")
    let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false // scroll 기능 막기
        return collectionView
    }()
    
    let detailCategoryLabel = CreatePartyCommonLabel(text: "세부 카테고리")
    
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
    
    let maxSelectLabelNotiLabel: UILabel = {
        let label = UILabel()
        label.text = "최대 2개까지 중복 선택이 가능합니다."
        label.font = notoSansFont.Black.of(size: 12)
        label.textAlignment = .center
        label.textColor = UIColor(hexcode: "D0D0D0")
        return label
    }()
    
    let detailCategoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    let setPartyView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    let setLocationButton: UIButton = {
        let button = UIButton()
        button.setTitle("지도에서 위치 설정", for: .normal)
        button.setTitleColor(UIColor(hexcode: "676767"), for: .normal)
        button.setImage(UIImage(named: Images.icon.compass), for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor(hexcode: "EEEEEE").cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    let numberOfPeopleTitleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let numberOfPeopleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor(hexcode: "EEEEEE").cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
//    let numberOfPeopleTextField: UITextField = {
//        let textField = UITextField
//    }()
    
//    let numberOfPeopleStackView: UIStackView = {
//
//    }()
    
    let minAndMaxPeople: UILabel = {
        let label = UILabel()
        label.text = "본인 포함 최소3명, 최대 20명"
        return label
    }()
    
    let setAgeLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let introContentsLabel: UILabel = {
        let label = UILabel()
        label.text = "파티에서 어떤 활동을 하는지 소개해 주세요."
        label.textAlignment = .center
        label.textColor = UIColor(hexcode: "D0D0D0")
        label.font = notoSansFont.Black.of(size: 12)
        return label
    }()
    
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
    
    let completeCreatePartyButton: UIButton = {
        let button = UIButton()
        button.setTitle("파티 등록 완료", for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = AppColor.brand
        button.titleLabel?.font = notoSansFont.Bold.of(size: 20)
        button.setTitleColor(AppColor.white, for: .normal)
        return button
    }()
    
    override func makeConfigures() {
        super.makeConfigures()
        [themeLabel, categoryCollectionView, detailCategoryLabel, maxSelectLabelNotiLabel, detailCategoryCollectionView, setPartyLabel, setPartyView, introPartyLabel, setLocationButton, numberOfPeopleTitleLabel, numberOfPeopleView, minAndMaxPeople, setAgeLabel, introPartyLabel, introContentsLabel, openKakaoChatTextField,aboutPartyContentsTextView, completeCreatePartyButton].forEach {
            contentView.addSubview($0)
        }
        scrollView.addSubview(contentView)
        addSubview(scrollView)
    }
    
    override func makeConstraints() {
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
            make.height.equalTo(UIScreen.main.bounds.height * 0.25)
        }
        
        setPartyLabel.snp.makeConstraints { make in
            make.top.equalTo(detailCategoryCollectionView.snp.bottom).offset(27)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.352)
            make.height.equalTo(24)
        }
        
        setPartyView.snp.makeConstraints { make in
            make.top.equalTo(setPartyLabel.snp.bottom).offset(9)
            make.horizontalEdges.equalToSuperview().inset(16)
        }
        
        setLocationButton.snp.makeConstraints { make in
            make.top.equalTo(setPartyView.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(43)
        }
        
        numberOfPeopleView.snp.makeConstraints { make in
            make.top.equalTo(setLocationButton.snp.bottom).offset(15)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(43)
        }
        
        minAndMaxPeople.snp.makeConstraints { make in
            make.top.equalTo(numberOfPeopleView.snp.bottom).offset(7)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(24)
        }
        
        setAgeLabel.snp.makeConstraints { make in
            make.top.equalTo(minAndMaxPeople.snp.bottom).offset(41)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(24)
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
        
        completeCreatePartyButton.snp.makeConstraints { make in
            make.top.equalTo(aboutPartyContentsTextView.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(46)
        }
    }
    
}
