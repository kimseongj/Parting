//
//  NotificationSettingView.swift
//  Parting
//
//  Created by 이병현 on 2023/09/21.
//

import UIKit
import SnapKit

final class NotificationSettingView: BaseView {
    
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
    
    let alertTitleLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Regular.of(size: 16)
        label.textAlignment = .center
        label.text = "알림 설정"
        return label
    }()
    
    let pushExplainLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Regular.of(size: 15)
        label.text = "푸시 알림"
        return label
    }()
    
    let pushSwitch: UISwitch = {
        let switchView = UISwitch()
        switchView.backgroundColor = .white
        switchView.tintColor = UIColor.init(hexcode: "DADEE3")
        switchView.onTintColor = AppColor.brand
        switchView.layer.cornerRadius = 16
        return switchView
    }()
    
    
    let newGroupExplainLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Regular.of(size: 15)
        label.text = "관심사의 새로운 모임 알림"
        return label
    }()
    
    let newGroupSwitch: UISwitch = {
        let switchView = UISwitch()
        switchView.backgroundColor = .white
        switchView.tintColor = UIColor.init(hexcode: "DADEE3")
        switchView.onTintColor = AppColor.brand
        switchView.layer.cornerRadius = 16
        return switchView
    }()
    
    let acceptAndRejectExplainLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Regular.of(size: 15)
        label.text = "승인 및 거절 알림"
        return label
    }()
    
    let acceptAndRejectSwitch: UISwitch = {
        let switchView = UISwitch()
        switchView.backgroundColor = .white
        switchView.tintColor = UIColor.init(hexcode: "DADEE3")
        switchView.onTintColor = AppColor.brand
        switchView.layer.cornerRadius = 16
        return switchView
    }()
    
    let partyStartAndEndExplainLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Regular.of(size: 15)
        label.text = "파티 시작/종료 알림"
        return label
    }()
    
    let partyStartAndEndSwitch: UISwitch = {
        let switchView = UISwitch()
        switchView.backgroundColor = .white
        switchView.tintColor = UIColor.init(hexcode: "DADEE3")
        switchView.onTintColor = AppColor.brand
        switchView.layer.cornerRadius = 16
        return switchView
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexcode: "E7ECF3")
        return view
    }()
    
    let okExplainLabel: UILabel = {
        let label = UILabel()
        label.font = AppFont.Regular.of(size: 15)
        label.textAlignment = .center
        label.text = "확인"
        return label
    }()
    
    let okButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    let explainLabelStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        return view
    }()
    
    let switchStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        return view
    }()

    override func makeConfigures() {
        super.makeConfigures()
        
        explainLabelStackView.addArrangedSubview(pushExplainLabel)
        explainLabelStackView.addArrangedSubview(newGroupExplainLabel)
        explainLabelStackView.addArrangedSubview(acceptAndRejectExplainLabel)
        explainLabelStackView.addArrangedSubview(partyStartAndEndExplainLabel)
        
        switchStackView.addArrangedSubview(pushSwitch)
        switchStackView.addArrangedSubview(newGroupSwitch)
        switchStackView.addArrangedSubview(acceptAndRejectSwitch)
        switchStackView.addArrangedSubview(partyStartAndEndSwitch)
        
        self.addSubview(bgView)
        self.addSubview(alertContainView)
        self.addSubview(alertTitleLabel)
        self.addSubview(switchStackView)
        self.addSubview(explainLabelStackView)
        self.addSubview(lineView)
        self.addSubview(okExplainLabel)
        self.addSubview(okButton)
    }
    
    override func makeConstraints() {
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        alertContainView.snp.makeConstraints { make in
            make.width.equalTo(270)
            make.height.equalTo(293)
            make.centerX.centerY.equalTo(safeAreaLayoutGuide)
        }
        
        alertTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(alertContainView.snp.top).offset(24)
            make.horizontalEdges.equalTo(alertContainView)
            make.height.equalTo(19)
        }
        
        switchStackView.snp.makeConstraints { make in
            make.trailing.equalTo(alertContainView.snp.trailing).offset(-16)
            make.top.equalTo(alertTitleLabel.snp.bottom).offset(24)
            make.height.equalTo(174)
            make.width.equalTo(38)
        }
        
        explainLabelStackView.snp.makeConstraints { make in
            make.leading.equalTo(alertContainView.snp.leading).offset(24)
            make.top.equalTo(alertTitleLabel.snp.bottom).offset(24)
            make.height.equalTo(174)
            make.trailing.equalTo(switchStackView.snp.leading)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(explainLabelStackView.snp.bottom)
            make.height.equalTo(1)
            make.horizontalEdges.equalTo(alertContainView)
        }
        
        okExplainLabel.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(alertContainView)
        }
        
        okButton.snp.makeConstraints { make in
            make.edges.equalTo(okExplainLabel)
        }
    }
}
