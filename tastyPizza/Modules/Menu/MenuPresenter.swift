//
//  MenuPresenter.swift
//  tastyPizza
//
//  Created by Enzhe Gaysina on 14.01.2024.
//

import Foundation

final class MenuPresenter {
    
    private var sourceCollection: [FoodViewModel] = []
    var foodCollection: [FoodViewModel] = []
    private let foodProvider: INetworkService
    
    init(foodProvider: INetworkService){
	   self.foodProvider = foodProvider
    }
    
    var selectedCategory = FoodCategory.all {
	   didSet {
		  foodCollection = sourceCollection.filter({ foodViewModel in
			 if (selectedCategory == .all) {
				return true
			 }
			 
			 return foodViewModel.category == selectedCategory
		  })
		  
		  collectionChangedHandler?(selectedCategory)
	   }
    }
    
    var collectionChangedHandler: ((FoodCategory) -> Void)?
    
    func load() {
	   foodProvider.performFoodRequest { result in
		  
		  DispatchQueue.main.async { [weak self] in
			 guard let self = self else {return}
			 
			 switch result {
			 case .failure(let error):
				print(error)
				
			 case .success(let foodCollection):
				self.sourceCollection = foodCollection.map { food in
				    return FoodViewModel(food)
				}
				
				self.selectedCategory = .all
			 }
		  }
	   }
    }
}
