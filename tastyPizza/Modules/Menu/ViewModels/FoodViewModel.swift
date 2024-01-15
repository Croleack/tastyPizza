//
//  FoodViewModel.swift
//  tastyPizza
//
//  Created by Enzhe Gaysina on 14.01.2024.
//

import Foundation

enum FoodCategory: Int, CaseIterable {
    case all = 0
    case first = 1
    case second = 2
    case third = 3
    case fourth = 4
    case fifth = 5
    
    func toString() -> String {
	   switch self {
	   case .all:
		  return "Вся"
	   case .first:
		  return "Русская"
	   case .second:
		  return "Отборная"
	   case .third:
		  return "Острая"
	   case .fourth:
		  return "Татарская"
	   case .fifth:
		  return "Хит"
	   }
    }
}

final class FoodViewModel {
    
    let title: String
    let description: String
    let category: FoodCategory
    let imageUrl: String
    let price: Int
    
    init(_ food: Food) {
	   self.title = food.name
	   self.description = food.description
	   
	   self.category = FoodCategory.allCases.filter { category in
		  return category.rawValue > 0
	   }.randomElement() ?? .all
	   self.imageUrl = food.imageUrl
	   self.price = (Int.random(in: 599...1499) / 100) * 100 + 99
    }
}
