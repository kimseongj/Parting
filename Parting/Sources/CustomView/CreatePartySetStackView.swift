//
//  CreatePartySetStackView.swift
//  Parting
//
//  Created by 박시현 on 2023/07/25.
//

import UIKit
import SnapKit

//MARK: - TitleLabel + BackgroundView
class SetCreatePartyView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(titleLabel: UILabel, backGroundView: SetBackGroundView) {
        self.init()
        addSubview(titleLabel)
        addSubview(backGroundView)
        
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        backGroundView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SetTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(_ placeHolder: String) {
        self.init()
        self.placeholder = placeHolder
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SetTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = notoSansFont.Black.of(size: 15)
        textAlignment = .center
        textColor = UIColor(hexcode: "676767")
    }
    
    convenience init(set type: SetPartyList) {
        self.init()
        switch type {
        case .setParty:
            text = type.title
        case .setHashTag:
            text = type.title
        default:
            break
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SetUnderlineLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderColor = UIColor(hexcode: "E6E6E6").cgColor
        layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SetTextCountLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        text = "0/20"
        textAlignment = .center
        textColor = UIColor(hexcode: "D3D3D3")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - textField + textCount + underLineLabel
class SetBackGroundView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(textCountLabel: SetTextCountLabel, underLineLabel: SetUnderlineLabel, placeHolder: String) {
        self.init()
        let textField = SetTextField(placeHolder)
        addSubview(textCountLabel)
        addSubview(underLineLabel)
        addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.9)
        }
        
        underLineLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
        
        textCountLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.15)
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
