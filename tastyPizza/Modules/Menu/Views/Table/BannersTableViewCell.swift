//
//  BannersTableViewCell.swift
//  tastyPizza
//
//  Created by Enzhe Gaysina on 14.01.2024.
//

import UIKit

final class BannersTableViewCell : UITableViewCell {
    //MARK: - UI Components
    private lazy var collectionView: UICollectionView = {
	   let layout = UICollectionViewFlowLayout()
	   layout.scrollDirection = .horizontal
	   let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
	   collectionView.register(BannerCollectionViewCell.self,
						  forCellWithReuseIdentifier: Constants.bannerIdentifier)
	   collectionView.showsHorizontalScrollIndicator = false
	   collectionView.backgroundColor = Colors.basicColor
	   
	   collectionView.delegate = self
	   collectionView.dataSource = self
	   
	   return collectionView
    }()
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
	   super.init(style: style, reuseIdentifier: reuseIdentifier)
	   
	   contentView.addSubview(collectionView)
	   collectionView.translatesAutoresizingMaskIntoConstraints = false
	   
	   collectionView.snp.makeConstraints { make in
		  make.left.top.right.bottom.equalTo(contentView)
	   }
    }
    
    required init?(coder: NSCoder) {
	   fatalError(.textFatal)
    }
}
    //MARK: - extension BannersTableViewCell
extension BannersTableViewCell : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
				    layout collectionViewLayout: UICollectionViewLayout,
				    sizeForItemAt indexPath: IndexPath) -> CGSize {
	   return CGSize(width: Constants.snpCollectionViewWidth,
				  height: Constants.snpCollectionViewHeight
	   )
    }
}

extension BannersTableViewCell : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
	   return Constants.numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView,
				    cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
	   guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.bannerIdentifier,
												for: indexPath) as? BannerCollectionViewCell else {
		  return UICollectionViewCell()
	   }
	   return cell
    }
}

// MARK: - Constants

fileprivate extension BannersTableViewCell {
    enum Constants {
	   
	   static let bannerIdentifier = "BannerCollectionViewCell"
	   static let numberOfItemsInSection = 4
	   static let snpCollectionViewHeight = 112.0
	   static let snpCollectionViewWidth = 300.0
    }
}
