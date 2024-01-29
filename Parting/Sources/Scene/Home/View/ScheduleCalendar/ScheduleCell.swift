//
//  ScheduleCell.swift
//  Parting
//
//  Created by kimseongjun on 1/28/24.
//

import UIKit

final class ScheduleCell: UICollectionViewCell {
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 16)
        label.textColor = UIColor(red: 0.969, green: 0.325, blue: 0.463, alpha: 1)
        label.backgroundColor = .white
        label.text = "25일"
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)
        label.text = "함께 운동합시다잉"
        return label
    }()
    
    private let locationLabelImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "locationIcon")
        return imageView
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.459, green: 0.459, blue: 0.459, alpha: 1)
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 11)
        label.text = "강서구 마곡동 빌딩"
        return label
    }()
    
    private let ddayLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.567, green: 0.567, blue: 0.567, alpha: 1)
        label.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)
        label.text = "D-23"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeConfigures()
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConfigures() {
        contentView.backgroundColor = UIColor(white: 1, alpha: 0)
        
        [dayLabel, titleLabel, locationLabelImageView, locationLabel, ddayLabel].forEach { contentView.addSubview($0) }
    }
    
    private func makeConstraints() {
        dayLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(dayLabel.snp.top)
            $0.leading.equalToSuperview().offset(90)
        }
        
        locationLabelImageView.snp.makeConstraints {
            $0.centerY.equalTo(locationLabel)
            $0.leading.equalToSuperview().offset(90)
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(locationLabelImageView.snp.trailing).offset(5)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        ddayLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(25)
            $0.trailing.equalToSuperview().inset(25)
        }
    }
    
    func fill(with data: String) {
        
    }
}
