//
//  HomeView.swift
//  Parting
//
//  Created by 김민규 on 2023/05/09.
//
import UIKit
import SnapKit
import FSCalendar

class HomeView: BaseView {
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
        view.isScrollEnabled = false
        return view
    }()
    
    let calendarTotalView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.borderColor = AppColor.gray50.cgColor
        view.layer.borderWidth = 1
        view.makeBottomShadow()
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
    
    let pageButtonStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .equalSpacing
        view.spacing = 12.0
        return view
    }()
    
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
    
    let notYetParticipatePartyLabel: UILabel = {
        let label = UILabel()
        label.text = """
아직 참여한 파티가 없어요.
파티를 시작해볼까요?
"""
        label.font = AppFont.Medium.of(size: 14)
        label.textColor = AppColor.gray900
        label.sizeToFit()
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    let addPartyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addButton"), for: .normal)
        return button
    }()
    
    let myPartyListView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        
        return view
    }()
    
    private lazy var carouselFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = calculateItemSize()
        layout.minimumLineSpacing = 15
        
        return layout
    }()
    
    lazy var myPartyCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: carouselFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.clipsToBounds = true
        collectionView.contentInset = calculateContentInset()
        collectionView.isScrollEnabled = true
        collectionView.register(MyPartyCell.self, forCellWithReuseIdentifier: MyPartyCell.identifier)
        return collectionView
    }()
    
    static func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/4),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(72)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.interGroupSpacing = 16
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    override func makeConfigures() {
        super.makeConfigures()
        naviCustomView.addSubview(naviImageView)
        
        myPartyListView.addSubview(notYetParticipatePartyLabel)
        myPartyListView.addSubview(addPartyButton)
        
        [calendarLabel, defaultLine, calendarView].forEach {
            calendarTotalView.addSubview($0)
        }
        
        [categoryCollectionView, calendarTotalView, myPartyListLabel, myPartyListView, myPartyCollectionView].forEach {
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
            make.top.equalTo(safeAreaLayoutGuide)
            make.width.equalTo(30)
            make.height.equalTo(naviImageView.snp.width).multipliedBy(1.4)
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
        
        calendarTotalView.snp.makeConstraints { make in
            make.top.equalTo(categoryCollectionView.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.bottom.equalTo(calendarView.snp.bottom)
        }
        
        calendarLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.leading.equalToSuperview().inset(24)
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
            make.top.equalTo(calendarTotalView.snp.bottom).offset(24)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            make.height.equalTo(20)
        }
        
        notYetParticipatePartyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        
        addPartyButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(20)
            make.size.equalTo(29)
            make.centerX.equalToSuperview()
        }
        
        myPartyListView.snp.makeConstraints { make in
            make.top.equalTo(myPartyListLabel.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width * 0.8)
            make.height.equalTo(UIScreen.main.bounds.width * 0.4)
        }
        
        myPartyCollectionView.snp.makeConstraints { make in
            make.top.equalTo(myPartyListLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width * 0.4)
        }
    }
    
    func configureMyPartyListView() {
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = AppColor.brand.cgColor
        borderLayer.lineDashPattern = [4, 4]
        borderLayer.frame = myPartyListView.bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(roundedRect: myPartyListView.bounds, cornerRadius: 15).cgPath
        myPartyListView.layer.addSublayer(borderLayer)
    }
    
    func hideMypartyCollectionView() {
        myPartyCollectionView.isHidden = true
        myPartyListView.isHidden = false
    }
    
    func hideMyPartyListView() {
        myPartyCollectionView.isHidden = false
        myPartyListView.isHidden = true
    }
}

extension HomeView: FSCalendarDelegate {
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        let currentPage = calendarView.currentPage
        calendarLabel.text = headerDateFormatter.string(from: currentPage)
    }
}

extension HomeView: FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendar.snp.updateConstraints { make in
            make.height.equalTo(bounds.height)
        }
        
        self.layoutIfNeeded()
    }
}

extension HomeView {

    private func calculateItemSize() -> CGSize {
        let itemSize = CGSize(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.4)
        return itemSize
    }
    
    private func calculateContentInset() -> UIEdgeInsets {
        let collectionViewContentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        return collectionViewContentInset
    }
}
