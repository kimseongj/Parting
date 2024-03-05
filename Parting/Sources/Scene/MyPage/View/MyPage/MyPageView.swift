//
//  MyPageView.swift
//  Parting
//
//  Created by 박시현 on 2023/07/13.
//

import UIKit
import SnapKit
import Kingfisher

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
        imageView.backgroundColor = AppColor.brand
        imageView.image = UIImage(systemName: "person")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nickname: UILabel = {
        let name = UILabel()
        name.font = AppFont.Medium.of(size: 16)
        name.textColor = UIColor(hexcode: "363636")
        name.textAlignment = .left
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
        return button
    }()
    
    let tipView: TopTipView = {
        let view = TopTipView(viewColor: AppColor.lightPink, tipStartX: 12, tipWidth: 11, tipHeight: 6, text: "")
        return view
    }()
    
    lazy var categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: partyCellLayout())
    
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
        view.distribution = .fillProportionally
        return view
    }()
    
    let settingLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Medium.of(size: 16)
        label.textColor = UIColor(hexcode: "363636")
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
//        view.layer.borderColor = UIColor.black.cgColor
//        view.layer.borderWidth = 1
//        view.layer.cornerRadius = 8
        view.isScrollEnabled = false
        view.separatorStyle = .none
        return view
    }()
    
    let etcStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        return view
    }()
    
    let etcLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Medium.of(size: 16)
        label.textColor = UIColor(hexcode: "363636")
        label.text = "기타"
        return label
    }()
    
    let lineView: UIView = {
       let view = UIView()
        view.backgroundColor = AppColor.gray50
        return view
    }()
    
    let etcUnfoldButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: FoldButton.unfold.buttonImage), for: .normal)
        return button
    }()
    
    let setETCTableView: UITableView = {
        let view = UITableView()
//        view.layer.borderColor = UIColor.black.cgColor
//        view.layer.borderWidth = 1
//        view.layer.cornerRadius = 8
        view.isScrollEnabled = false
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
        
        [profileImageView, nickname, editProfileButton, tipView, categoryCollectionView, editButtonBackgroundView, aboutPartyTableView, settingStackView, setPartyTableView,  etcStackView, setETCTableView, lineView, bottomEmptyView].forEach {
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
        
        tipView.snp.makeConstraints { make in
            make.top.equalTo(nickname.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(36)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(tipView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(103)
        }
        
        editButtonBackgroundView.snp.makeConstraints { make in
            make.leading.verticalEdges.equalTo(profileImageView)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-20)
        }
        
        editButton.snp.makeConstraints { make in
            make.edges.equalTo(editButtonBackgroundView)
        }
        
        aboutPartyTableView.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(0)
        }
        
        settingStackView.snp.makeConstraints { make in
            make.top.equalTo(aboutPartyTableView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.lessThanOrEqualToSuperview()
        }

        setPartyTableView.snp.makeConstraints { make in
            make.top.equalTo(settingStackView.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(160)
        }
        
        etcStackView.snp.makeConstraints { make in
            make.top.equalTo(settingStackView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.lessThanOrEqualToSuperview()
        }
        
        setETCTableView.snp.makeConstraints { make in
            make.top.equalTo(etcStackView.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(150)
        }
        
        lineView.snp.makeConstraints { make in
            make.bottom.equalTo(etcLabel.snp.top).offset(-8)
            make.height.equalTo(1)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
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
    }
}

extension MyPageView {
    func configureMyPageUI(_ item: MyPageResponse) {
        nickname.text = item.result.nickName
        tipView.updateLabel(text: item.result.introduce)
        updateUI()
        guard let url = URL(string: item.result.profileImgUrl) else { return }
        profileImageView.kf.setImage(with: url)
    }
    
    private func updateUI() {
        tipView.snp.removeConstraints()
        tipView.snp.remakeConstraints { make in
            make.top.equalTo(nickname.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(36)
        }
    }
}

extension MyPageView {
    private func partyCellLayout() -> UICollectionViewLayout {
        let configuration = UICollectionViewCompositionalLayoutConfiguration()
        let collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider:
                { sectionIndex, layoutEnvironment in
                    return self.partyLayout()
                },
            configuration: configuration)
        return collectionViewLayout
    }
    
    
    private func partyLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(103),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        
        group.interItemSpacing = NSCollectionLayoutSpacing.flexible(8)
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .groupPaging /// Set Scroll Direction
        return section
    }
}
