//
//  StorageService.swift
//  tastyPizza
//
//  Created by Enzhe Gaysina on 15.01.2024.
//

import Foundation

final class StorageService {
    
    private static let lastLoadedFoodKey = "lastLoadedFood"
    
    static var lastLoadedFoodCollection: [Food] {
	   get {
		  if let storedData = UserDefaults.standard.data(forKey: lastLoadedFoodKey),
			let foodCollection = try? JSONDecoder().decode([Food].self, from: storedData) {
			 return foodCollection
		  } else {
			 return []
		  }
	   }
	   set {
		  if let encodedData = try? JSONEncoder().encode(newValue) {
			 UserDefaults.standard.set(encodedData, forKey: lastLoadedFoodKey)
		  }
	   }
    }
    
    static func saveFoodCollection(_ foodCollection: [Food]) {
	   self.lastLoadedFoodCollection = foodCollection
    }
}
