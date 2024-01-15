//
//  FoodTableHeader.swift
//  tastyPizza
//
//  Created by Enzhe Gaysina on 14.01.2024.
//

import UIKit

final class FoodTableHeader : UITableViewHeaderFooterView {
    
    private var categories: [FoodCategory] = []
    
    private weak var menuPresenter: MenuPresenter?
    //MARK: - UI Components
    private lazy var collectionView: UICollectionView = {
	   let layout = UICollectionViewFlowLayout()
	   layout.scrollDirection = .horizontal
	   let collectionView = UICollectionView(frame: .zero,
									 collectionViewLayout: layout)
	   collectionView.register(FoodCollectionViewCell.self,
						  forCellWithReuseIdentifier: Constants.foodIdentifier)
	   collectionView.backgroundColor = .clear
	   collectionView.showsHorizontalScrollIndicator = false
	   
	   collectionView.delegate = self
	   collectionView.dataSource = self
	   
	   return collectionView
    }()
    
    //MARK: - init
    override init(reuseIdentifier: String?) {
	   super.init(reuseIdentifier: reuseIdentifier)
	   
	   contentView.addSubview(collectionView)
	   collectionView.translatesAutoresizingMaskIntoConstraints = false
	   
	   collectionView.snp.makeConstraints { make in
		  make.left.equalTo(contentView)
		  make.top.equalTo(contentView).offset(Constants.snpCollectionViewTop)
		  make.height.equalTo(Constants.snpCollectionViewHeight)
		  make.right.equalTo(contentView)
	   }
    }
    
    convenience init(menuPresenter: MenuPresenter, reuseIdentifier: String?) {
	   self.init(reuseIdentifier: reuseIdentifier)
	   self.menuPresenter = menuPresenter
    }
    
    required init?(coder: NSCoder) {
	   fatalError(.textFatal)
    }
    
    //MARK: - function
    func update(categories: [FoodCategory]) {
	   self.categories = categories
	   
	   collectionView.reloadData()
	   
	   DispatchQueue.main.asyncAfter(deadline: .now() + Constants.deadline) { [weak self] in
		  guard let self = self else { return }
		  
		  let selectedIndex = self.categories.firstIndex { $0 == self.menuPresenter?.selectedCategory } ?? .zero
		  let indexPath = IndexPath(row: selectedIndex, section: .zero)
		  
		  self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
		  self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
	   }
    }
}
//MARK: - extension FoodTableHeader
extension FoodTableHeader : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
				    layout collectionViewLayout: UICollectionViewLayout,
				    sizeForItemAt indexPath: IndexPath) -> CGSize {
	   return CGSize(width: Constants.snpCollectionViewWidth,
				  height: Constants.snpCollectionViewHeight)
    }
}

extension FoodTableHeader : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
				    numberOfItemsInSection section: Int) -> Int {
	   return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
				    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
	   guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.foodIdentifier,
												for: indexPath) as? FoodCollectionViewCell else {
		  return UICollectionViewCell()
	   }
	   cell.update(category: categories[indexPath.row])
	   return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
	   
	   guard let cell = collectionView.cellForItem(at: indexPath) as? FoodCollectionViewCell else {
		  return
	   }
	   cell.cellDidSelect()
	   
	   menuPresenter?.selectedCategory = cell.category
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
	   let cell = collectionView.cellForItem(at: indexPath) as? FoodCollectionViewCell
	   cell?.cellDidNotSelect()
    }
}

// MARK: - Constants

fileprivate extension FoodTableHeader {
    enum Constants {
	   
	   static let foodIdentifier = "FoodCollectionViewCell"
	   static let snpCollectionViewTop = 24.0
	   static let snpCollectionViewHeight = 32.0
	   static let snpCollectionViewWidth = 88.0
	   static let deadline = 0.1
    }
}
