//
//  CategoryImageModel.swift
//  Parting
//
//  Created by 김민규 on 2023/07/20.
//

import Foundation
import RxSwift

class CategoryModel {
	let id: Int
	let name: String
	let imgURL: String
	var localImgSrc: String?
    
	init(id: Int, name: String, imgURL: String, localImgSrc: String?) {
		self.id = id
		self.name = name
		self.imgURL = imgURL
		self.localImgSrc = localImgSrc
	}
}

