//
//  NetworkService.swift
//  tastyPizza
//
//  Created by Enzhe Gaysina on 14.01.2024.
//
import Foundation
import Reachability

private extension String {
    static let baseURL = "https://api.npoint.io/0daa423e9d0b4c2c4b54"
}

protocol INetworkService {
    func performFoodRequest(completion: @escaping (Result<[Food], Error>) -> Void)
}

enum ApiErrors: String, Error {
    case dataIsNil = "Data is nil"
    case jsonParseError = "JSON pars error"
}

final class NetworkService: INetworkService {
    
    func performFoodRequest(completion: @escaping (Result<[Food], Error>) -> Void) {
	   let reachability = try? Reachability()
	   
	   if reachability?.connection != .unavailable {
		  guard let url = URL(string: String.baseURL) else {
			 completion(.failure(ApiErrors.dataIsNil))
			 return
		  }
		  
		  var request = URLRequest(url: url)
		  request.httpMethod = "GET"
		  
		  let session = URLSession.shared
		  let dataTask = session.dataTask(with: request) { (data, response, error) in
			 if let error = error {
				completion(.failure(error))
				return
			 }
			 
			 guard let data = data else {
				completion(.failure(ApiErrors.dataIsNil))
				return
			 }
			 
			 do {
				let decoder = JSONDecoder()
				decoder.dateDecodingStrategy = .iso8601
				let foods = try decoder.decode([Food].self, from: data)
				
				StorageService.saveFoodCollection(foods)
				
				completion(.success(foods))
			 } catch {
				print(error)
				completion(.failure(error))
			 }
		  }
		  
		  dataTask.resume()
	   } else {
		  let savedData = StorageService.lastLoadedFoodCollection
		  completion(.success(savedData))
	   }
    }
}
