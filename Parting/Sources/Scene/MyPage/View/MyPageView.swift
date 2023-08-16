//
//  MyPageView.swift
//  Parting
//
//  Created by 박시현 on 2023/07/13.
//

import UIKit
import SnapKit

enum FoldButton {
    case fold
    case unfold
    
    var buttonImage: String {
        switch self {
        case .fold:
            return "foldButton"
        case .unfold:
            return "unfoldButton"
        }
    }
}

final class MyPageView: BaseView {
    
    let navigationLabel: BarTitleLabel = BarTitleLabel(text: "마이페이지")
    
    let scrollview: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    let nickname: UILabel = {
        let name = UILabel()
        name.font = notoSansFont.Medium.of(size: 16)
        name.textColor = UIColor(hexcode: "363636")
        name.textAlignment = .center
        name.layer.borderColor = UIColor.black.cgColor
        name.layer.borderWidth = 1
        name.text = "닉네임"
        return name
    }()
    
    let editProfileButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "editProfileButtonImage"), for: .normal)
        return button
    }()
    
    let editButtonBackgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    let editButton: UIButton = {
        let button = UIButton()
        button.setTitle("편집", for: .normal)
        button.setTitleColor(UIColor(hexcode: "D9D9E2"), for: .normal)
        return button
    }()
    
    let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .systemPink
        return view
    }()
    
    let aboutPartyTableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .systemCyan
        return view
    }()
    
    let settingStackView: UIStackView = {
        let view = UIStackView()
        return view
    }()
    
    let settingLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let unfoldButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: FoldButton.unfold.buttonImage), for: .normal)
        return button
    }()
    
    let etcStackView: UIStackView = {
        let view = UIStackView()
        return view
    }()
    
    override func makeConfigures() {
        super.makeConfigures()
        editButtonBackgroundView.addSubview(editButton)
        
        [profileImageView, nickname, editProfileButton, categoryCollectionView, editButtonBackgroundView, aboutPartyTableView].forEach {
            addSubview($0)
        }
    }
    
    override func makeConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(20)
            make.width.equalToSuperview().multipliedBy(0.18)
            make.height.equalTo(profileImageView.snp.width)
        }
        
        nickname.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(profileImageView.snp.trailing).offset(5)
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalTo(profileImageView.snp.height)
        }
        
        editProfileButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.equalTo(nickname.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(profileImageView.snp.height)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(nickname.snp.bottom).offset(20)
            make.leading.equalToSuperview().inset(20)
            make.height.equalTo(profileImageView.snp.height)
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        
        editButtonBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(nickname.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.leading.equalTo(categoryCollectionView.snp.trailing).offset(10)
            make.height.equalTo(profileImageView.snp.height)
        }
        
        editButton.snp.makeConstraints { make in
            make.verticalEdges.horizontalEdges.equalToSuperview().inset(5)
        }
        
        aboutPartyTableView.snp.makeConstraints { make in
            make.top.equalTo(editButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(189)
        }
    }
}
