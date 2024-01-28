//
//  ScheduleCalendarView.swift
//  Parting
//
//  Created by kimseongjun on 1/28/24.
//

import UIKit
import FSCalendar

final class ScheduleCalendarView: BaseView {
    let dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "xIcon"), for: .normal)
        return button
    }()
    
    let monthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 28)
        label.text = "11월"
        return label
    }()
    
    lazy var calendarView: FSCalendar = {
        let calendar = FSCalendar(frame: .zero)
        //        calendar.dataSource = self
        //        calendar.delegate = self
        
        calendar.weekdayHeight = 20
        calendar.rowHeight = 30
        calendar.firstWeekday = 1
        calendar.setScope(.month, animated: false)
        calendar.locale = Locale(identifier: "ko_KR")
        calendar.backgroundColor = .white
        calendar.headerHeight = 0
        calendar.appearance.headerTitleFont = AppFont.SemiBold.of(size: 16)
        calendar.appearance.headerMinimumDissolvedAlpha = 0.0
        calendar.appearance.headerTitleColor = AppColor.gray900
        calendar.appearance.titleDefaultColor = AppColor.gray900
        calendar.appearance.titleFont = AppFont.Regular.of(size: 13)
        
        calendar.appearance.weekdayFont = AppFont.Regular.of(size: 14)
        calendar.appearance.weekdayTextColor = AppColor.gray400
        
        calendar.layer.cornerRadius = 15
        calendar.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMaxXMaxYCorner, .layerMinXMaxYCorner)
        return calendar
    }()
    
    let scheduleCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize.height = 50
        layout.itemSize.width = UIScreen.main.bounds.width
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(white: 1, alpha: 0)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ScheduleCell.self, forCellWithReuseIdentifier: ScheduleCell.identifier)
        return collectionView
    }()
    
    let scheduleCollectionBackgroundView = UIView()
    
    func makeDotLine() {
        let dotLine = UIView(frame: CGRect(x: 0, y: 0,
                                           width: 80, height: scheduleCollectionBackgroundView.bounds.height))
        dotLine.backgroundColor = UIColor.black
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.lightGray.cgColor
        layer.lineDashPattern = [2, 5]
        
        let path = UIBezierPath()
        let point1 = CGPoint(x: dotLine.bounds.midX, y: dotLine.bounds.minY)
        let point2 = CGPoint(x: dotLine.bounds.midX, y: dotLine.bounds.maxY)
        
        path.move(to: point1)
        path.addLine(to: point2)
        
        layer.path = path.cgPath
        dotLine.layer.addSublayer(layer)
        
        scheduleCollectionBackgroundView.addSubview(dotLine)
        
        dotLine.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
    }

    func makeClendarViewShadow() {
        calendarView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        calendarView.layer.shadowOffset = CGSize(width: 0, height: 6)
        calendarView.layer.shadowRadius = 3
        calendarView.layer.shadowOpacity = 1
        calendarView.layer.shadowPath = UIBezierPath(roundedRect: calendarView.bounds, cornerRadius: 15).cgPath
    }
    override func makeConfigures() {
        self.backgroundColor = .white
        [dismissButton, monthLabel, calendarView, scheduleCollectionBackgroundView, scheduleCollectionView].forEach { self.addSubview($0) }
    }
    
    override func makeConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        dismissButton.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top).offset(14)
            $0.leading.equalToSuperview().offset(24)
        }
        
        monthLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea.snp.top).offset(16)
            $0.centerX.equalToSuperview()
        }
        
        calendarView.snp.makeConstraints {
            $0.top.equalTo(monthLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        scheduleCollectionBackgroundView.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeArea.snp.bottom)
        }
        
        scheduleCollectionView.snp.makeConstraints {
            $0.top.equalTo(calendarView.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeArea.snp.bottom)
        }
    }
}
