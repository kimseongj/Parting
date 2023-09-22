//
//  TestView.swift
//  Parting
//
//  Created by 박시현 on 2023/09/21.
//

import UIKit
import SnapKit
import FSCalendar

final class TestView: BaseView {
    let naviImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mainIcon")
        return imageView
    }()
    
    let naviCustomView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.brand
        
        return view
    }()
    
    let mainBackgroundView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        return view
    }()
    
    let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        return view
    }()
    
    let calendarLabel: UILabel = {
        let label = UILabel()
        label.text = "11월 팟팅 일정"
        label.font = AppFont.SemiBold.of(size: 16)
        label.textColor = AppColor.gray900
        return label
    }()
    
    lazy var calendarView: FSCalendar = {
        let calendar = FSCalendar()
        calendar.dataSource = self
        calendar.delegate = self
        
        calendar.firstWeekday = 1
        calendar.scope = .week
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.backgroundColor = .systemPink
        
        calendar.appearance.titleDefaultColor = AppColor.gray900
        calendar.appearance.titleFont = AppFont.Regular.of(size: 13)
        
        return calendar
    }()
    

    
    static func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/4),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(68)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 16
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    override func layoutSubviews() {
        
    }
    
    override func makeConfigures() {
        super.makeConfigures()
        calendarView.addSubview(calendarLabel)
        naviCustomView.addSubview(naviImageView)
        
        [categoryCollectionView, calendarView].forEach {
            mainBackgroundView.addSubview($0)
        }
        
        [naviCustomView, mainBackgroundView].forEach {
            addSubview($0)
        }
    }
    
    override func makeConstraints() {
        naviImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(15)
            make.width.equalToSuperview().multipliedBy(0.09)
            make.height.equalToSuperview().multipliedBy(0.272)
            make.centerX.equalToSuperview()
        }
        
        
        naviCustomView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(175)
        }
        
        mainBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(naviCustomView.snp.bottom).offset(-57)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaInsets)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(190)
        }
        
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(124)
        }
        
    }
}

extension TestView: FSCalendarDelegate {
    
}

extension TestView: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.fs_height = bounds.height + 10
        self.layoutIfNeeded()
    }
}
