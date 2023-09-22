//
//  InterestCollectionViewCell.swift
//  Parting
//
//  Created by 이병현 on 2023/09/22.
//

import UIKit
import SnapKit

final class InterestCollectionViewCell: UICollectionViewCell {
    
    let bgView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(hexcode: "E7ECF3").cgColor

        view.layer.masksToBounds = false
        return view
    }()
    
    let imageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        self.addSubview(bgView)
        self.addSubview(imageView)
    }
    
    private func constraints() {
        bgView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(bgView.snp.width)
        }
        
        imageView.snp.makeConstraints { make in
            make.edges.equalTo(bgView).inset(8)
        }
    }
}
