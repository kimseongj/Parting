//
//  CustomGroupView.swift
//  Parting
//
//  Created by 박시현 on 2023/06/14.
//

import UIKit
import SnapKit

class CustomGroupView: UICollectionReusableView {
    let insetView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.backgroundColor = UIColor(hexcode: "FFFFFF")
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(insetView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        insetView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension CustomGroupView {
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}
