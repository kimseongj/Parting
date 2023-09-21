//
//  UILabel+Extension.swift
//  Parting
//
//  Created by 박시현 on 2023/04/17.
//

import UIKit

extension UILabel {
    func setLineSpacing() {
        guard let text = text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = 1
        attributeString.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
}
