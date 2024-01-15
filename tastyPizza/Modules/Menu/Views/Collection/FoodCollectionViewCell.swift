//
//  FoodCollectionViewCell.swift
//  tastyPizza
//
//  Created by Enzhe Gaysina on 14.01.2024.
//

import UIKit

protocol FoodCollectionViewCellDelegate: AnyObject {
    func didSelect(cell: FoodCollectionViewCell)
}

final class FoodCollectionViewCell : UICollectionViewCell {
    
    weak var delegate: FoodCollectionViewCellDelegate?
    
    override var isSelected: Bool {
	   didSet {
		  isSelected(bool: oldValue)
	   }
    }
    //MARK: - UI Components
    private lazy var categoryLabel: UILabel = {
	   let label = UILabel()
	   label.textColor = Colors.categoryText
	   label.font = UIFont.systemFont(ofSize: Constants.categoryLabelFont)
	   return label
    }()
    //MARK: - init
    override init(frame: CGRect) {
	   super.init(frame: frame)
	   
	   contentView.addSubview(categoryLabel)
	   
	   categoryLabel.snp.makeConstraints { make in
		  make.center.equalTo(contentView)
	   }
	   
	   layer.cornerRadius = Constants.layerCornerRadius
	   layer.borderWidth = Constants.layerBorderWidth
	   layer.borderColor = Colors.categoryBorder.cgColor
    }
    
    required init?(coder: NSCoder) {
	   fatalError(.textFatal)
    }
    
    var category: FoodCategory = .all
    
    func update(category: FoodCategory) {
	   self.category = category
	   categoryLabel.text = self.category.toString()
    }
}
//MARK: - extension FoodCollectionViewCell
extension FoodCollectionViewCell {
    func isSelected(bool: Bool) {
	   switch isSelected {
	   case true:
		  cellDidSelect()
	   case false:
		  cellDidNotSelect()
	   }
    }
    func cellDidSelect() {
	   categoryLabel.textColor = Colors.tabBarTint
	   categoryLabel.font = UIFont.systemFont(ofSize: Constants.categoryLabelFont,
									  weight: UIFont.Weight(Constants.weightDidSelect))
	   
	   backgroundColor = Colors.selectedCategoryBackground
	   
	   layer.borderWidth = .zero
    }
    func cellDidNotSelect() {
	   backgroundColor = Colors.noSelectedCategoryBackground
	   
	   layer.borderWidth = Constants.layerBorderWidth
	   layer.borderColor = Colors.categoryBorder.cgColor
	   
	   categoryLabel.font =  UIFont.systemFont(ofSize: Constants.categoryLabelFont,
									   weight: UIFont.Weight(Constants.weightDidNotSelect))
	   categoryLabel.textColor = Colors.categoryText
    }
}

// MARK: - Constants

fileprivate extension FoodCollectionViewCell {
    enum Constants {
	   
	   static let categoryLabelFont = 13.0
	   static let layerCornerRadius = 18.0
	   static let layerBorderWidth = 1.0
	   static let weightDidSelect = 700.0
	   static let weightDidNotSelect = 400.0   
    }
}
