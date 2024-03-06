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
    
    let lineView1: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.gray50
        return view
    }()
    
    let partyListLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Medium.of(size: 16)
        label.textColor = UIColor(hexcode: "363636")
        label.text = "파티목록"
        return label
    }()
    
    lazy var categoryCollectionView = UICollectionView(frame: .zero, collectionViewLayout: partyCellLayout())
    
    let settingLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Medium.of(size: 16)
        label.textColor = UIColor(hexcode: "363636")
        label.text = "설정"
        return label
    }()
    
    let settingTableView: UITableView = {
        let view = UITableView()
        view.isScrollEnabled = false
        view.separatorStyle = .none
        return view
    }()

    let lineView2: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.gray50
        return view
    }()
    
    override func layoutSubviews() {
        makeCircleImageView()
    }
    
    override func makeConfigures() {
        super.makeConfigures()
        
        [editButton, lineView1, partyListLabel, categoryCollectionView, lineView2, settingLabel, settingTableView].forEach {
            contentView.addSubview($0)
        }
        
        [profileImageView, nickname, editProfileButton].forEach {
            editButton.addSubview($0)
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
        
        editButton.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
            make.size.equalTo(60)
        }
        
        nickname.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(profileImageView.snp.trailing).offset(20)
        }
        
        editProfileButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(nickname.snp.trailing).offset(5)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(profileImageView.snp.height)
        }
        
        lineView1.snp.makeConstraints { make in
            make.top.equalTo(editButton.snp.bottom).offset(20)
            make.height.equalTo(1)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        partyListLabel.snp.makeConstraints {
            $0.top.equalTo(lineView1.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(24)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalTo(partyListLabel.snp.bottom).offset(5)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(108)
        }
        
        lineView2.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(20)
            make.height.equalTo(1)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        settingLabel.snp.makeConstraints {
            $0.top.equalTo(lineView2.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(24)
        }
        
        settingTableView.snp.makeConstraints {
            $0.top.equalTo(settingLabel.snp.bottom).offset(10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(400)
        }
    }
    
    func makeCircleImageView() {
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
    }
    
    func configureMyPageUI(_ item: MyPageResponse) {
        nickname.text = item.result.nickName
        guard let url = URL(string: item.result.profileImgUrl) else { return }
        profileImageView.kf.setImage(with: url)
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
