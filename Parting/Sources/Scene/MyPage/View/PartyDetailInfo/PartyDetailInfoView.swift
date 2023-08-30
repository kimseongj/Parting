//
//  PartyDetailInfoView.swift
//  Parting
//
//  Created by 박시현 on 2023/08/30.
//

import UIKit
import SnapKit

class PartyDetailInfoView: BaseView {
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    let bellBarButton = BarImageButton(imageName: Images.sfSymbol.bell)
    let navigationLabel = BarTitleLabel(text: "상세 정보")
    let backBarButton = BarImageButton(imageName: Images.icon.back)
    
    let partyTitle: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let partyPersonnel: UILabel = {
        let label = UILabel()
        label.text = "2/5"
        label.backgroundColor = AppColor.brand
        return label
    }()
    
    let reportOrshareButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let categoryImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    // MARK: - Cell 생성해주어야 함
    let partyTypeCollectionView: UICollectionView = {
        let view = UICollectionView()
        return view
    }()
    
    // MARK: - Cell 생성해주어야 함
    let detailCategoryCollectionView: UICollectionView = {
        let view = UICollectionView()
        return view
    }()
    
    let deadLineLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let partyPersonnelBackgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    // MARK: - Cell 생성해주어야 함
    let partyPersonnelCollectionView: UICollectionView = {
        let view = UICollectionView()
        return view
    }()
    
    let partyInfoBackgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    let partyInfoLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let ageGroupLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let partyPeriodLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let descriptionPartyBackgroundView: UIView = {
        let view = UIView()
        return view
    }()
    
    let descriptionPartyLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let descriptionPartyContentsLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let leavePartyButton = CompleteAndNextButton("파티 나가기")
    
    override func makeConfigures() {
        [partyInfoLabel, ageGroupLabel, partyPeriodLabel, locationLabel].forEach {
            partyInfoBackgroundView.addSubview($0)
        }
        
        [descriptionPartyLabel, descriptionPartyContentsLabel].forEach {
            descriptionPartyBackgroundView.addSubview($0)
        }
        
        [partyTitle, partyPersonnel, reportOrshareButton, categoryImage, partyTypeCollectionView, detailCategoryCollectionView, deadLineLabel, partyPersonnelBackgroundView, partyInfoBackgroundView, descriptionPartyBackgroundView, leavePartyButton].forEach {
            addSubview($0)
        }
    }
    
    override func makeConstraints() {
        
    }
}
