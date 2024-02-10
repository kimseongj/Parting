//
//  BarButtonImageView.swift
//  Parting
//
//  Created by 김민규 on 2023/07/01.
//

import UIKit
import SnapKit

class BarImageButton: UIBarButtonItem {
    let innerButton = UIButton()
    
    private var imageView: UIImageView
    
    init(imageName: String) {
        var image = UIImage(named: imageName)
        image = image?.resized(to: CGSize(width: 20, height: 22))
        imageView = UIImageView(image: image)

        super.init()
        
        setupView()
        addSubviews()
        makeConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BarImageButton: ProgrammaticallyInitializableViewProtocol {
    func setupView() {
        self.customView = innerButton
    }
    
    func addSubviews() {
        innerButton.addSubview(imageView)
    }
    
    func makeConstraints() {
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
