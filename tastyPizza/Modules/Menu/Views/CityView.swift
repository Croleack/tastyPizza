//
//  CityView.swift
//  tastyPizza
//
//  Created by Enzhe Gaysina on 13.01.2024.
//

import UIKit

final class CityView : UIView {
    //MARK: - UI Components
    private lazy var cityLabel: UILabel = {
	   let label = UILabel()
	   label.text = Constants.cityName
	   label.textColor = Colors.moscowTextColor
	   label.font = UIFont.systemFont(ofSize: Constants.labelFont,
							    weight: .medium)
	   return label
    }()
    
    private lazy var arrowDownImage: UIImageView = {
	   let image = UIImageView()
	   image.image = UIImage(named: Constants.arrowDownImage)
	   return image
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
	   super.init(frame: .zero)
	   setupView()
    }
    
    required init?(coder: NSCoder) {
	   fatalError(.textFatal)
    }
    // MARK: - setupView
    private func setupView() {
	    
	   cityLabel.translatesAutoresizingMaskIntoConstraints = false
	   arrowDownImage.translatesAutoresizingMaskIntoConstraints = false
	   
	   addSubview(cityLabel)
	   addSubview(arrowDownImage)
	   
	   cityLabel.snp.makeConstraints { make in
		  make.leading.equalTo(self).offset(Constants.snpCityLabelLeading)
		  make.top.equalTo(self).offset(Constants.snpCityLabelTop)
	   }
	   
	   arrowDownImage.snp.makeConstraints { make in
		  make.left.equalTo(cityLabel.snp.right).offset(Constants.snpArrowDownLeading)
		  make.top.equalTo(self).offset(Constants.snpArrowDownTop)
	   }
    }
}

// MARK: - Constants

fileprivate extension CityView {
    enum Constants {
	   
	   static let arrowDownImage = "arrowDown"
	   static let cityName = "Москва"
	   
	   static let labelFont = 17.0
	   static let snpCityLabelLeading = 16.0
	   static let snpCityLabelTop = 16.0
	   static let snpArrowDownLeading = 8.0
	   static let snpArrowDownTop = 24.0
    }
}
