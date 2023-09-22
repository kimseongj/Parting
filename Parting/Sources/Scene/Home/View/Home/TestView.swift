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
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    let contentView: UIView = {
        let view = UIView()
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
    
    let calendarTotalView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.borderColor = AppColor.gray50.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    lazy var calendarLabel: UILabel = {
        let label = UILabel()
        label.text = headerDateFormatter.string(from: Date())
        label.font = AppFont.SemiBold.of(size: 16)
        label.textColor = AppColor.gray900
        return label
    }()
    
    let defaultLine: UILabel = {
        let label = UILabel()
        label.layer.borderColor = AppColor.gray50.cgColor
        label.layer.borderWidth = 1
        return label
    }()
    
    let headerDateFormatter: DateFormatter = {
        let dateformat = DateFormatter()
        dateformat.dateFormat = "MM월 팟팅 일정"
        dateformat.locale = Locale(identifier: "ko_KR")
        dateformat.timeZone = TimeZone(identifier: "KST")
        return dateformat
    }()
    
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = AppColor.gray900
        button.addTarget(self, action: #selector(nextWeek), for: .touchUpInside)
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = AppColor.gray900
        button.addTarget(self, action: #selector(prevWeek), for: .touchUpInside)
        return button
    }()
    
    let pageButtonStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.spacing = 12.0
        return view
    }()
    
    @objc func prevWeek() {
        guard let currentPage = Calendar.current.date(byAdding: .weekOfMonth, value: 1, to: calendarView.currentPage) else { return }
        self.calendarView.setCurrentPage(currentPage, animated: true)
    }
    
    @objc func nextWeek() {
        guard let currentPage = Calendar.current.date(byAdding: .weekOfMonth, value: -1, to: calendarView.currentPage) else { return }
        self.calendarView.setCurrentPage(currentPage, animated: true)
    }
    
    lazy var calendarView: FSCalendar = {
        let calendar = FSCalendar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 48, height: 124))
        calendar.dataSource = self
        calendar.delegate = self
        
        calendar.weekdayHeight = 20
        calendar.rowHeight = 30
        calendar.firstWeekday = 1
        calendar.setScope(.week, animated: false)
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.backgroundColor = .white
        calendar.headerHeight = 0
        calendar.appearance.headerTitleFont = AppFont.SemiBold.of(size: 16)
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerTitleColor = AppColor.gray900
        calendar.appearance.titleDefaultColor = AppColor.gray900
        calendar.appearance.titleFont = AppFont.Regular.of(size: 13)
        
        calendar.appearance.weekdayFont = AppFont.Regular.of(size: 12)
        calendar.appearance.weekdayTextColor = AppColor.gray400
        
        return calendar
    }()
    
    let myPartyListLabel: UILabel = {
        let label = UILabel()
        label.text = "내가 참여한 파티"
        label.font = AppFont.SemiBold.of(size: 16)
        label.textColor = AppColor.gray900
        label.sizeToFit()
        return label
    }()
    
    let myPartyListView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.layer.borderColor = AppColor.brand.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let testCollectionView: UIView = {
        let view = UIView()
        view.layer.borderColor = AppColor.brand.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 15
        return view
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
        naviCustomView.addSubview(naviImageView)
        
        [leftButton, rightButton].forEach {
            pageButtonStackView.addArrangedSubview($0)
        }
        
        [calendarLabel, defaultLine, calendarView, pageButtonStackView].forEach {
            calendarTotalView.addSubview($0)
        }
        
        [categoryCollectionView, calendarTotalView, myPartyListLabel, myPartyListView, testCollectionView].forEach {
            contentView.addSubview($0)
        }
        
        [naviCustomView, mainBackgroundView].forEach {
            addSubview($0)
        }
        
        scrollView.addSubview(contentView)
        mainBackgroundView.addSubview(scrollView)
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
        
        naviImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(15)
            make.width.equalToSuperview().multipliedBy(0.09)
            make.height.equalToSuperview().multipliedBy(0.272)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(0.468 * 175)
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
        
        calendarTotalView.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.bottom.equalTo(calendarView.snp.bottom)
        }
        
        calendarLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.leading.equalToSuperview().inset(24)
        }
        
        pageButtonStackView.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.trailing.equalToSuperview().inset(24)
        }
        
        defaultLine.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(calendarLabel.snp.bottom).offset(9)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(defaultLine.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(300)
        }
        
        myPartyListLabel.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(20)
        }
        
        myPartyListView.snp.makeConstraints { make in
            make.top.equalTo(myPartyListLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(126)
        }
        
        testCollectionView.snp.makeConstraints { make in
            make.top.equalTo(myPartyListView.snp.bottom).offset(32)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(136)
            make.bottom.equalToSuperview().inset(20)
        }
    }
}

extension TestView: FSCalendarDelegate {
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let currentPage = calendarView.currentPage
        calendarLabel.text = headerDateFormatter.string(from: currentPage)
    }
}

extension TestView: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints { make in
            make.height.equalTo(bounds.height)
        }
        
        self.layoutIfNeeded()
    }
}
