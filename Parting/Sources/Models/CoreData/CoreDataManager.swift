//
//  CoreDataManager.swift
//  Parting
//
//  Created by 김민규 on 2023/07/22.
//

import Foundation
import CoreData
import UIKit
import Kingfisher
import RxSwift

class CoreDataManager {
	
	
	
	enum LocalStorageError: Error {
		case noFileName
		case noImageInDisk
		case noContext
		case noEntity
		case fetchingError
	}
	
	static func saveCategories(_ categories: [CategoryModel]) {
		
		var categoryList = [NSManagedObject]()
		
		guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
		
		guard let entity = NSEntityDescription.entity(forEntityName: Entity.category.entityName, in: context) else { return }
		
		for categoryItem in categories {
			
			let category = NSManagedObject(entity: entity, insertInto: context)
			let imgFileName = categoryItem.name + ".png"
			
			category.setValue(categoryItem.id, forKey: Entity.category.keys.id)
			category.setValue(categoryItem.name, forKey: Entity.category.keys.name)
			category.setValue(categoryItem.imgURL, forKey: Entity.category.keys.imgURL)
			category.setValue(imgFileName, forKey: Entity.category.keys.localImgSrc)
			categoryList.append(category)
			
			KF.saveOnlineImageAtLocalStorage(urlString: categoryItem.imgURL, fileName: imgFileName)
			
		}
	}
	
	static func fetchCategories() -> Observable<[CategoryModel]> {
		
		let disposeBag = DisposeBag()
		
		return Observable.create { observer in
			
			var categoryList = [NSManagedObject]()
			
			guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return Disposables.create() }
			
			let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Entity.category.entityName)
			
			do {
				categoryList = try context.fetch(fetchRequest)
			} catch let error as NSError {
				print("Could not fetch. \(error), \(error.userInfo)")
				return Disposables.create()
			}
			
			var categoryModelList = [CategoryModel]()
			
			/* Succeeded to fetch but NO ITEM */
			guard categoryList.count > 0 else {
				APIManager.shared.getCategoryImageAPI()
					.subscribe(onNext: { data in
						CoreDataManager.saveCategories(data)
						observer.onNext(data)
					})
					.disposed(by: disposeBag)
				
				return Disposables.create()
			}
			
			categoryList.forEach { obj in
				if let id = obj.value(forKey: Entity.category.keys.id) as? Int,
				   let name = obj.value(forKey: Entity.category.keys.name) as? String,
				   let imgURL = obj.value(forKey: Entity.category.keys.imgURL) as? String,
				   let localImgSrc = obj.value(forKey: Entity.category.keys.localImgSrc) as? String {
					categoryModelList.append(CategoryModel(id: id, name: name, imgURL: imgURL, localImgSrc: localImgSrc))
				}
				
				
			} /* End categoryList.forEach */
			
			observer.onNext(categoryModelList)
			
			return Disposables.create()
		}
		
		
		
	}
}
