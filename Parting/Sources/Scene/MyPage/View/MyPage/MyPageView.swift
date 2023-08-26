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
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    let contentView: UIView = {
        let view = UIView()
        return view
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
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        view.separatorStyle = .none
        return view
    }()
    
    let settingStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        return view
    }()
    
    let settingLabel: UILabel = {
        let label = UILabel()
        label.text = "설정"
        return label
    }()
    
    let settingUnfoldButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: FoldButton.unfold.buttonImage), for: .normal)
        return button
    }()
    
    let setPartyTableView: UITableView = {
        let view = UITableView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        view.separatorStyle = .none
        return view
    }()
    
    let etcStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        return view
    }()
    
    let etcLabel: UILabel = {
        let label = UILabel()
        label.text = "기타"
        return label
    }()
    
    let etcUnfoldButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: FoldButton.unfold.buttonImage), for: .normal)
        return button
    }()
    
    let setETCTableView: UITableView = {
        let view = UITableView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        view.separatorStyle = .none
        return view
    }()
    
    let bottomEmptyView: UIView = {
        let view = UIView()
        return view
    }()
    
    override func layoutSubviews() {
        // ViewImage Circle
        makeCircleImageView()
    }
    
    override func makeConfigures() {
        super.makeConfigures()
        
        [profileImageView, nickname, editProfileButton, categoryCollectionView, editButtonBackgroundView, aboutPartyTableView, settingStackView, setPartyTableView,  etcStackView, setETCTableView, bottomEmptyView].forEach {
            contentView.addSubview($0)
        }
        
        editButtonBackgroundView.addSubview(editButton)
        settingStackView.addArrangedSubview(settingLabel)
        settingStackView.addArrangedSubview(settingUnfoldButton)
        
        etcStackView.addArrangedSubview(etcLabel)
        etcStackView.addArrangedSubview(etcUnfoldButton)
        
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
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.width.equalToSuperview().multipliedBy(0.18)
            make.height.equalTo(profileImageView.snp.width)
        }
        
        nickname.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(profileImageView.snp.trailing).offset(5)
            make.width.equalToSuperview().multipliedBy(0.6)
            make.height.equalTo(profileImageView.snp.height)
        }
        
        editProfileButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
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
            make.height.equalTo(150)
        }
        
        settingStackView.snp.makeConstraints { make in
            make.top.equalTo(aboutPartyTableView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.lessThanOrEqualToSuperview()
        }

        setPartyTableView.snp.makeConstraints { make in
            make.top.equalTo(settingStackView.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(setPartyTableView.contentSize.height)
        }
        
        etcStackView.snp.makeConstraints { make in
            make.top.equalTo(settingStackView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.lessThanOrEqualToSuperview()
        }
        
        setETCTableView.snp.makeConstraints { make in
            make.top.equalTo(etcStackView.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(setETCTableView.contentSize.height)
        }
        
        bottomEmptyView.snp.makeConstraints { make in
            make.top.equalTo(setETCTableView.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(20)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: resizing
extension MyPageView {
    func removeSettingTableView() {
        setPartyTableView.snp.removeConstraints()
        setPartyTableView.snp.remakeConstraints { make in
            make.height.equalTo(0)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    func resizeSettingTableView() {
        setPartyTableView.snp.removeConstraints()
        setPartyTableView.snp.remakeConstraints { make in
            make.top.equalTo(settingStackView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(setPartyTableView.contentSize.height)
        }
    }
    
    func removeETCStackView() {
        etcStackView.snp.removeConstraints()
        etcStackView.snp.remakeConstraints { make in
            make.top.equalTo(settingStackView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.lessThanOrEqualToSuperview()
        }
    }
    
    func resizeETCStackView() {
        etcStackView.snp.removeConstraints()
        etcStackView.snp.remakeConstraints { make in
            make.top.equalTo(setPartyTableView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.lessThanOrEqualToSuperview()
        }
    }
    
    func removeETCTableView() {
        setETCTableView.snp.removeConstraints()
        setETCTableView.snp.remakeConstraints { make in
            make.height.equalTo(0)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    func resizeETCTableView() {
        setETCTableView.snp.removeConstraints()
        setETCTableView.snp.remakeConstraints { make in
            make.top.equalTo(etcStackView.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(setETCTableView.contentSize.height)
        }
    }
    
    func removeBottomView() {
        bottomEmptyView.snp.removeConstraints()
        bottomEmptyView.snp.remakeConstraints { make in
            make.height.equalTo(0)
            make.horizontalEdges.equalToSuperview()
        }
    }
    
    func resizeBottomView() {
        bottomEmptyView.snp.removeConstraints()
        bottomEmptyView.snp.remakeConstraints { make in
            make.top.equalTo(setETCTableView.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(20)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - UIUpdate
extension MyPageView {
    func setTableViewRowHeight(_ tableView: UITableView) {
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func setTableViewUIUpdate(state: Bool) {
        if !state {
            // 닫기
            self.removeSettingTableView()
            self.settingUnfoldButton.setImage(UIImage(named: FoldButton.unfold.buttonImage), for: .normal)
            self.removeETCStackView()
        } else if state {
            // 펼치기
            self.resizeSettingTableView()
            self.settingUnfoldButton.setImage(UIImage(named: FoldButton.fold.buttonImage), for: .normal)
            self.resizeETCStackView()
        }
    }
    
    func setETCTableViewUIUpdate(state: Bool) {
        if !state {
            // 닫기
            self.removeETCTableView()
            self.etcUnfoldButton.setImage(UIImage(named: FoldButton.unfold.buttonImage), for: .normal)
            self.removeBottomView()
        } else if state {
            // 펼치기
            self.resizeETCTableView()
            self.etcUnfoldButton.setImage(UIImage(named: FoldButton.fold.buttonImage), for: .normal)
            self.resizeBottomView()
        }
    }
    
    func makeCircleImageView() {
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.clipsToBounds = true
    }
}
