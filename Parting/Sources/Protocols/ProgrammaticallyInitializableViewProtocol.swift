//
//  ProgrammaticallyInitializableViewProtocol.swift
//  Parting
//
//  Created by 김민규 on 2023/06/29.
//

import UIKit

protocol ProgrammaticallyInitializableViewProtocol: AnyObject {
	func setupView()
	func addSubviews()
	func makeConstraints()
}

extension ProgrammaticallyInitializableViewProtocol where Self: UIView {
	func setupView() {
		// Empty body to make method optional
	}

	func addSubviews() {
		// Empty body to make method optional
	}

	func makeConstraints() {
		// Empty body to make method optional
	}
}
