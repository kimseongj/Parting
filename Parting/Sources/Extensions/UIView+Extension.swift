//
//  UIView+Extension.swift
//  Parting
//
//  Created by 박시현 on 2023/04/17.
//

import UIKit

extension UIView {
    func setGradient(_ color1: UIColor, _ color2: UIColor) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.75, y: 0.5)
        gradient.frame = bounds
        gradient.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0.95, b: 0.91, c: -0.91, d: 0.22, tx: 0.46, ty: -0.11))
        gradient.bounds = bounds.insetBy(dx: -0.7*bounds.size.width, dy: -0.7*bounds.size.height)
//        gradient.position = center
        layer.insertSublayer(gradient, at: 0)
    }
}
