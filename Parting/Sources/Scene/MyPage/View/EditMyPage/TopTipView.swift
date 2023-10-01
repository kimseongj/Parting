//
//  TopTipView.swift
//  Parting
//
//  Created by 이병현 on 2023/09/25.
//

import UIKit
import SnapKit

class TopTipView: UIView {
let titleLabel = UILabel()
  init(
    viewColor: UIColor,
    tipStartX: CGFloat,
    tipWidth: CGFloat,
    tipHeight: CGFloat,
    text: String
  ) {
    super.init(frame: .zero)
    self.backgroundColor = viewColor
    
    let path = CGMutablePath()

    let tipWidthCenter = tipWidth / 2.0
    let endXWidth = tipStartX + tipWidth
    
    path.move(to: CGPoint(x: tipStartX, y: 0))
    path.addLine(to: CGPoint(x: tipStartX + tipWidthCenter, y: -tipHeight))
    path.addLine(to: CGPoint(x: endXWidth, y: 0))
    path.addLine(to: CGPoint(x: 0, y: 0))

    let shape = CAShapeLayer()
    shape.path = path
    shape.fillColor = viewColor.cgColor

    self.layer.insertSublayer(shape, at: 0)
    self.layer.masksToBounds = false
    self.layer.cornerRadius = 16
    self.addLabel(text: text)
  }
  
    private func addLabel(text: String) {
    let titleLabel = UILabel()
    titleLabel.textColor = .white
    titleLabel.text = text
    titleLabel.numberOfLines = 0
    titleLabel.lineBreakMode = .byCharWrapping // 글자 단위로 줄바꿈 (디폴트는 어절 단위)
    
    self.addSubview(titleLabel)
    titleLabel.snp.makeConstraints {
      $0.top.bottom.equalToSuperview().inset(10)
      $0.trailing.leading.equalToSuperview().inset(16)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
}

extension TopTipView {
    func updateLabel(text: String) {
        self.snp.removeConstraints()
        titleLabel.textColor = .white
        titleLabel.text = text
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byCharWrapping // 글자 단위로 줄바꿈 (디폴트는 어절 단위)
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
          $0.top.bottom.equalToSuperview().inset(10)
          $0.trailing.leading.equalToSuperview().inset(16)
        }
      }
}
