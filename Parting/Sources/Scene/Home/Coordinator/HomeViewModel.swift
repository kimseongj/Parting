//
//  HomeViewModel.swift
//  Parting
//
//  Created by 김민규 on 2023/05/09.
//

import Foundation
import RxSwift
import RxCocoa
import Kingfisher
import CoreData
import UIKit

class HomeViewModel: BaseViewModel {
	
	enum LocalStorageError: Error {
		case noFileName
		case noImageInDisk
		case noContext
		case noEntity
		case fetchingError
	}
	
	struct Input {
		let pushScheduleVCTrigger = PublishSubject<Void>()
	}
	
	struct Output {
				let categories: BehaviorRelay<[CategoryModel]> = BehaviorRelay(value: [])
		let categoryImages: BehaviorRelay<[CategoryModel]> = BehaviorRelay(value: [])
	}
	
	private let disposeBag = DisposeBag()
	
	
	var input: Input
	var output: Output
	
	private weak var coordinator: HomeCoordinator?
	
	init(input: Input = Input(), output: Output = Output(), coordinator: HomeCoordinator?) {
		self.input = input
		self.output = output
		self.coordinator = coordinator
		setupBindings()
	}
	
	private func setupBindings() {
		input.pushScheduleVCTrigger
			.subscribe(onNext: { [weak self] in
				self?.coordinator?.pushScheduleVC()
			})
			.disposed(by: disposeBag)
		
		loadCategories()
		
		
	}
	
	private func loadCategories() {
		do {
			try fetchCategories()
		} catch {
			print("Failed to load Categories, Reason: \(error)")
			
		}
	}
	
	private func saveCategories(_ categories: [CategoryModel]) {
		
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
		
		
		do {
			try context.save()
		} catch let error as NSError {
			print("Could not save. \(error), \(error.userInfo)")
		}
		
	}
	
	private func fetchCategories() throws {
		
		var categoryList = [NSManagedObject]()
		
		guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { throw LocalStorageError.noContext}
		
		let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Entity.category.entityName)
		
		do {
			categoryList = try context.fetch(fetchRequest)
		} catch let error as NSError {
			print("Could not fetch. \(error), \(error.userInfo)")
			throw error
		}
		
		var categoryModelList = [CategoryModel]()
		
		/* Succeeded to fetch but NO ITEM */
		guard categoryList.count > 0 else {
			APIManager.shared.getCategoryImageAPI()
				.withUnretained(self)
				.subscribe(onNext: { owner, data in
					owner.output.categories.accept(data)
					self.saveCategories(data)
				})
				.disposed(by: disposeBag)
			
			
			return
		}
		
		categoryList.forEach { obj in
			if let id = obj.value(forKey: Entity.category.keys.id) as? Int,
			   let name = obj.value(forKey: Entity.category.keys.name) as? String,
			   let imgURL = obj.value(forKey: Entity.category.keys.imgURL) as? String,
			   let localImgSrc = obj.value(forKey: Entity.category.keys.localImgSrc) as? String {
				categoryModelList.append(CategoryModel(id: id, name: name, imgURL: imgURL, localImgSrc: localImgSrc))
			}
			
			
		} /* End categoryList.forEach */
		
		self.output.categories.accept(categoryModelList)
	} /* End fetchCategoriesFromLocalStorage() */
	
	
	
	func pushPartyListVC(title: String) {
		self.coordinator?.pushPartyListVC(title: title)
	}
	
}
