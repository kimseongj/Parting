//
//  CreatePartySetStackView.swift
//  Parting
//
//  Created by 박시현 on 2023/07/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

//MARK: - TitleLabel + BackgroundView
final class SetCreatePartyView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(titleLabel: UILabel, backGroundView: SetBackGroundView) {
        self.init()
        addSubview(titleLabel)
        addSubview(backGroundView)
        
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.width.equalTo(59)
            make.leading.equalToSuperview()
        }
        
        backGroundView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalTo(titleLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
        }
    }
    
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class SetTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(_ placeHolder: String) {
        self.init()
        self.placeholder = placeHolder
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class SetTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = AppleSDGothicNeoFont.Medium.of(size: 15)
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
        case .setPartyDate:
            text = type.title
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class SetUnderlineLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderColor = UIColor(hexcode: "E6E6E6").cgColor
        layer.borderWidth = 1
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

final class SetTextCountLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        text = "0/20"
        textAlignment = .center
        textColor = UIColor(hexcode: "D3D3D3")
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//
//MARK: - textField + textCount + underLineLabel
final class SetBackGroundView: UIView {
    private let disposeBag = DisposeBag()
    
    let textCnt = PublishRelay<Int>()
    var textField: UITextField?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(textCountLabel: SetTextCountLabel, underLineLabel: SetUnderlineLabel, placeHolder: String) {
        self.init()
        textField = SetTextField(placeHolder)
        textField?.delegate = self
        addSubview(textCountLabel)
        addSubview(underLineLabel)
        addSubview(textField!)
        
        textField?.rx.text
            .map { $0?.count }
            .bind { [weak self] cnt in
                guard let cnt else { return }
                textCountLabel.text = "\(cnt)/20"
            }
            .disposed(by: disposeBag)
        
        textField?.snp.makeConstraints { make in
            make.bottom.equalTo(underLineLabel.snp.top)
            make.trailing.equalTo(textCountLabel.snp.leading)
            make.leading.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.9)
        }
        
        underLineLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview()
        }
        
        textCountLabel.snp.makeConstraints { make in
            make.bottom.equalTo(underLineLabel.snp.top)
            make.width.equalTo(50)
            make.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SetBackGroundView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        guard textField.text!.count < 20 else { return false } // 20 글자로 제한
        return true
    }
}
