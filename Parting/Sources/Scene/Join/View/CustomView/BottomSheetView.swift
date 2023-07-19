//
//  BottomSheetView.swift
//  Parting
//
//  Created by 박시현 on 2023/07/19.
//

import UIKit

class BottomSheetView: BaseView {
    let testLabel: UILabel = {
        let label = UILabel()
        label.text = "bottomSheet Test 💜"
        return label
    }()
    
    override func makeConfigures() {
        super.makeConfigures()
        [testLabel].forEach {
            addSubview($0)
        }
    }
    
    override func makeConstraints() {
        testLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.1)
            make.width.equalToSuperview().multipliedBy(0.8)
        }
    }
}
