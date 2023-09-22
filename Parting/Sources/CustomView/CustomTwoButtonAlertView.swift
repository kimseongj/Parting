//
//  CustomTwoButtonAlertView.swift
//  Parting
//
//  Created by 이병현 on 2023/09/22.
//

import UIKit
import SnapKit

class CustomTwoButtonAlertView: BaseView {
    
    let bgView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexcode: "393939", alpha: 0.3)
        return view
    }()
    
    let alertContainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        return view
    }()
    
    let alertExplainLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Regular.of(size: 16)
        label.textAlignment = .center
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexcode: "E7ECF3")
        return view
    }()
    
    let verticalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexcode: "E7ECF3")
        return view
    }()
    
    let cancelExplainLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Regular.of(size: 15)
        label.textAlignment = .center
        label.text = "아니요"
        return label
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let okExplainLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Regular.of(size: 15)
        label.textAlignment = .center
        label.textColor = AppColor.brand
        label.text = "네"
        return label
    }()
    
    let okButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(title: String) {
        self.init()
        self.alertExplainLabel.text = title
    }
    
    override func makeConfigures() {
        super.makeConfigures()
        
        self.addSubview(bgView)
        self.addSubview(alertContainView)
        self.addSubview(alertExplainLabel)
        self.addSubview(cancelExplainLabel)
        self.addSubview(cancelButton)
        self.addSubview(okExplainLabel)
        self.addSubview(okButton)
        self.addSubview(lineView)
        self.addSubview(verticalLineView)
    }
    
    override func makeConstraints() {
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        alertContainView.snp.makeConstraints { make in
            make.width.equalTo(270)
            make.height.equalTo(149)
            make.centerX.centerY.equalTo(safeAreaLayoutGuide)
        }
        
        cancelExplainLabel.snp.makeConstraints { make in
            make.bottom.leading.equalTo(alertContainView)
            make.width.equalTo(135)
            make.height.equalTo(52)
        }
        
        cancelButton.snp.makeConstraints { make in
            make.edges.equalTo(cancelExplainLabel)
        }
        
        okExplainLabel.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(alertContainView)
            make.width.equalTo(135)
            make.height.equalTo(52)
        }
        
        okButton.snp.makeConstraints { make in
            make.edges.equalTo(okExplainLabel)
        }
        
        alertExplainLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(alertContainView)
            make.bottom.equalTo(cancelButton.snp.top)
        }
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(cancelButton.snp.top)
            make.horizontalEdges.equalTo(alertContainView)
        }
        
        verticalLineView.snp.makeConstraints { make in
            make.width.equalTo(1)
            make.top.equalTo(lineView)
            make.bottom.equalTo(alertContainView)
            make.leading.equalTo(cancelButton.snp.trailing)
        }
    }
}
