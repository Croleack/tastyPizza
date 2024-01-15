//
//  BannerCollectionViewCell.swift
//  tastyPizza
//
//  Created by Enzhe Gaysina on 14.01.2024.
//

import UIKit

final class BannerCollectionViewCell : UICollectionViewCell {

    //MARK: - UI Components
    private lazy var image: UIImageView = {
	   let imageView = UIImageView()
	   imageView.image = UIImage(named: Constants.imageName)
	   imageView.contentMode = .center
	   
	   return imageView
    }()
    //MARK: - init
    override init(frame: CGRect) {
	   super.init(frame: frame)
	   
	   contentView.addSubview(image)
	   image.snp.makeConstraints { make in
		  make.left.top.equalTo(contentView)
		  make.width.equalTo(Constants.snpImageWidth)
		  make.height.equalTo(Constants.snpImageHeight)
	   }
	   
	   layer.cornerRadius = Constants.layerCornerRadius
    }
    
    required init?(coder: NSCoder) {
	   fatalError(.textFatal)
    }
}

// MARK: - Constants

fileprivate extension BannerCollectionViewCell {
    enum Constants {
	   
	   static let imageName = "banner"
	   static let layerCornerRadius = 10.0
	   static let snpImageWidth = 300.0
	   static let snpImageHeight = 112.0
    }
}
