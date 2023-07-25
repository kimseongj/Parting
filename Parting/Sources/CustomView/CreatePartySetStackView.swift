//
//  CreatePartySetStackView.swift
//  Parting
//
//  Created by 박시현 on 2023/07/25.
//

import UIKit
import SnapKit

//MARK: - TitleLabel + BackgroundView
class CreatePartySetStackView: UIStackView {
    //MARK: - 파티제목View + setPartyTitleLabel
    let setTitleStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeConstraints()
    }
    
    convenience init(titleLabel: UILabel, backGroundView: setBackGroundView) {
        self.init()
        addArrangedSubview(titleLabel)
        addArrangedSubview(backGroundView)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraints() {
        
    }
}

class setTextField: UITextField {
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

class setTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(set type: SetPartyList) {
        self.init()
        switch type {
        case .setParty:
            text = type.title
        case .setHashTag:
            text = type.title
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class setUnderlineLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderColor = UIColor(hexcode: "E6E6E6").cgColor
        layer.borderWidth = 1
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class setTextCountLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        text = "0/20"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - textField + textCount + underLineLabel
class setBackGroundView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(textCountLabel: setTextCountLabel, underLineLabel: setUnderlineLabel, placeHolder: String) {
        self.init()
        let textField = setTextField(placeHolder)
        addSubview(textCountLabel)
        addSubview(underLineLabel)
        addSubview(textField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeConstraints() {
        
    }
}
