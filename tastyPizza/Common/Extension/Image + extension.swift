//
//  extension + Image.swift
//  tastyPizza
//
//  Created by Enzhe Gaysina on 14.01.2024.
//

import UIKit

extension UIImageView {
    
    func downloaded(from url: URL,
				contentMode mode: ContentMode = .center,
				completion: ((Error?) -> Void)? = nil) {
	   contentMode = mode
	   URLSession.shared.dataTask(with: url) { data, response, error in
		  guard
			 let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
			 let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
			 let data = data, error == nil,
			 let image = UIImage(data: data)
		  else {
			 DispatchQueue.main.async {
				completion?(error)
			 }
			 return
		  }
		  
		  DispatchQueue.main.async() { [weak self] in
			 self?.image = image
			 completion?(nil)
		  }
	   }.resume()
    }
    
    func downloaded(from link: String,
				contentMode mode: ContentMode = .scaleAspectFit,
				completion: ((Error?) -> Void)? = nil) {
	   guard let url = URL(string: link) else {
		  completion?(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
		  return
	   }
	   
	   downloaded(from: url, contentMode: mode, completion: completion)
    }
}
