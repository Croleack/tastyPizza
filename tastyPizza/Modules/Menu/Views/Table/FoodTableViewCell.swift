//
//  FoodTableViewCell.swift
//  tastyPizza
//
//  Created by Enzhe Gaysina on 14.01.2024.
//

import UIKit

final class FoodTableViewCell : UITableViewCell {
    //MARK: - UI Components
    private lazy var foodImageView: UIImageView = {
	   let imageView = UIImageView()
	   imageView.layer.cornerRadius = Constants.foodImageCornerRadius
	   imageView.clipsToBounds = true
	   return imageView
    }()
    
    private lazy var foodTitleLabel: UILabel = {
	   let label = UILabel()
	   label.font = UIFont.boldSystemFont(ofSize: Constants.foodTitleFont)
	   return label
    }()
    
    private lazy var foodDescriptionLabel: UILabel = {
	   let label = UILabel()
	   label.font = UIFont.systemFont(ofSize: Constants.foodDescriptionFont)
	   label.numberOfLines = Constants.foodDescriptionNumberOfLines
	   label.textColor = Colors.descriptionText
	   return label
    }()
    
    private lazy var foodButton: UIButton = {
	   let button = UIButton()
	   button.backgroundColor = .white
	   button.tintColor = Colors.tabBarTint
	   button.setTitleColor(Colors.tabBarTint, for: .normal)
	   button.layer.borderWidth = Constants.foodButtonBorderWidth
	   button.layer.cornerRadius = Constants.foodButtonCornerRadius
	   button.layer.borderColor = Colors.tabBarTint.cgColor
	   button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.foodButtonTitle)
	   return button
    }()
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
	   super.init(style: style, reuseIdentifier: reuseIdentifier)
	   
	   backgroundColor = .white
	   
	   contentView.addSubview(foodImageView)
	   contentView.addSubview(foodTitleLabel)
	   contentView.addSubview(foodDescriptionLabel)
	   contentView.addSubview(foodButton)
	   
	   foodImageView.translatesAutoresizingMaskIntoConstraints = false
	   foodTitleLabel.translatesAutoresizingMaskIntoConstraints = false
	   foodDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
	   foodButton.translatesAutoresizingMaskIntoConstraints = false
	   
	   foodImageView.snp.makeConstraints { make in
		  make.left.equalTo(contentView)
		  make.top.equalTo(contentView).offset(Constants.snpFoodImageTop)
		  make.width.equalTo(Constants.snpFoodImageWidth)
		  make.height.equalTo(Constants.snpFoodImageHeight)
	   }
	   
	   foodTitleLabel.snp.makeConstraints { make in
		  make.left.equalTo(foodImageView.snp.rightMargin).offset(Constants.snpFoodTitleLeft)
		  make.top.equalTo(contentView).offset(Constants.snpFoodTitleTop)
		  make.right.equalTo(contentView).offset(Constants.snpFoodTitleRight)
	   }
	   
	   foodDescriptionLabel.snp.makeConstraints { make in
		  make.left.equalTo(foodImageView.snp.rightMargin).offset(Constants.snpFoodDescriptionLeft)
		  make.top.equalTo(foodTitleLabel.snp.bottom).offset(Constants.snpFoodDescriptionTop)
		  make.right.equalTo(contentView).offset(Constants.snpFoodDescriptionRight)
	   }
	   
	   foodButton.snp.makeConstraints { make in
		  make.top.equalTo(foodDescriptionLabel.snp.bottom).offset(Constants.snpFoodButtonTop)
		  make.right.equalTo(contentView).offset(Constants.snpFoodButtonRight)
		  make.width.equalTo(Constants.snpFoodButtonWidth)
		  make.height.equalTo(Constants.snpFoodButtonHeight)
	   }
    }
    
    required init?(coder: NSCoder) {
	   fatalError(.textFatal)
    }
    
    func update(by food: FoodViewModel) {
	   foodImageView.downloaded(from: food.imageUrl)
	   foodTitleLabel.text = food.title
	   foodDescriptionLabel.text = food.description
	   foodButton.setTitle("от \(food.price) р", for: .normal)
    }
}

// MARK: - Constants

fileprivate extension FoodTableViewCell {
    enum Constants {
	   
	   static let foodImageCornerRadius = 20.0
	   static let foodTitleFont = 17.0
	   static let foodDescriptionFont = 13.0
	   static let foodDescriptionNumberOfLines = 5
	   static let foodButtonBorderWidth = 1.0
	   static let foodButtonCornerRadius = 6.0
	   static let foodButtonTitle = 13.0
	   
	   static let snpFoodImageTop = 16.0
	   static let snpFoodImageWidth = 132.0
	   static let snpFoodImageHeight = 127.0
	   static let snpFoodTitleTop = 16.0
	   static let snpFoodTitleLeft = 32.0
	   static let snpFoodTitleRight = -16.0
	   static let snpFoodDescriptionTop = 8.0
	   static let snpFoodDescriptionLeft = 32.0
	   static let snpFoodDescriptionRight = -16.0
	   static let snpFoodButtonTop = 16.0
	   static let snpFoodButtonRight = -8.0
	   static let snpFoodButtonWidth = 87.0
	   static let snpFoodButtonHeight = 32.0
	   
    }
}
