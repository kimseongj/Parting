//
//  PartySortingTableViewCell.swift
//  Parting
//
//  Created by kimseongjun on 2/13/24.
//

import UIKit

final class PartySortingTableViewCell: UITableViewCell {
    override var isSelected: Bool {
        didSet {
            if isSelected {
                presentSelected()
            } else {
                presentDeselected()
            }
        }
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.325, green: 0.325, blue: 0.325, alpha: 1)
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 16)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        contentView.addSubview(titleLabel)
 
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(24)
            $0.bottom.equalToSuperview().offset(-15)
        }
    }
    
    func fill(with option: SortingOption) {
        titleLabel.text = option.description
    }
    
    private func presentSelected() {
        titleLabel.textColor = AppColor.brand
    }
    
    private func presentDeselected() {
        titleLabel.textColor = .black
    }
}
