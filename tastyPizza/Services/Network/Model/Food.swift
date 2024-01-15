//
//  Food.swift
//  tastyPizza
//
//  Created by Enzhe Gaysina on 14.01.2024.
//

import Foundation

struct Food: Codable {
    var name: String
    var imageUrl: String
    var price: String
    var category: String
    var description: String
    
    private enum CodingKeys: String, CodingKey {
	   case name
	   case imageUrl = "image"
	   case price
	   case category
	   case description
    }
}
