//
//  BaseView.swift
//  Parting
//
//  Created by 박시현 on 2023/04/17.
//

import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeConfigures()
        makeConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConfigures() {}
    func makeConstraints() {}
}
