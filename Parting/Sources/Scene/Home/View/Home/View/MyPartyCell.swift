//
//  MyPartyCell.swift
//  Parting
//
//  Created by kimseongjun on 2/5/24.
//

import UIKit

final class MyPartyCell: UICollectionViewCell {
    private let partyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.325, green: 0.325, blue: 0.325, alpha: 1)
        label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13)
        label.text = "zxcasdasfgasdzxc"
        return label
    }()
    
    private let ddayView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8.5
        view.layer.borderWidth = 0.8
        view.layer.borderColor = UIColor(red: 0.973, green: 0.322, blue: 0.463, alpha: 1).cgColor
        return view
    }()
    
    private let ddayLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.973, green: 0.322, blue: 0.463, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 10)
        label.text = "D-8"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeConfigures()
        makeConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConfigures() {
        [partyImageView, titleLabel, ddayView].forEach {
            contentView.addSubview($0)
        }
        
        ddayView.addSubview(ddayLabel)
    }
    
    private func makeConstraints() {
        partyImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(partyImageView.snp.bottom).offset(6)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        ddayView.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(5)
            $0.bottom.trailing.equalToSuperview()
            $0.height.equalTo(15)
        }
        
        ddayLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(7)
            $0.trailing.equalToSuperview().inset(7)
        }
    }
    
    func fill(with partyInfo: String) {
        titleLabel.text = partyInfo
    }
}
