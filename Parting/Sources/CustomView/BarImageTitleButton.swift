//
//  BarImageTitleButton.swift
//  Parting
//
//  Created by kimseongjun on 2/9/24.
//

import UIKit

final class BarImageTitleButton: UIBarButtonItem {
    let containerView = UIView()
    let innerButton = UIButton()
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.font = AppFont.SemiBold.of(size: 20)
        label.textAlignment = .left
        label.textColor = AppColor.gray900
        return label
    }()
    
    private var imageView: UIImageView
    
    init(imageName: String, title: String) {
        var image = UIImage(named: imageName)
        image = image?.resized(to: CGSize(width: 20, height: 22))
        imageView = UIImageView(image: image)
        titleLabel.text = title

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

extension BarImageTitleButton: ProgrammaticallyInitializableViewProtocol {
    func setupView() {
        self.customView = containerView
    }
    
    func addSubviews() {
        containerView.addSubview(innerButton)
        containerView.addSubview(titleLabel)
        innerButton.addSubview(imageView)
    }
    
    func makeConstraints() {
        innerButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalTo(innerButton.snp.trailing).offset(8)
            $0.trailing.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
