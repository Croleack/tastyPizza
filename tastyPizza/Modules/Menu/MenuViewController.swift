//
//  ViewController.swift
//  tastyPizza
//
//  Created by Enzhe Gaysina on 13.01.2024.
//

import UIKit
import SnapKit

final class MenuViewController : UIViewController {
    
    private let menuPresenter: MenuPresenter
    //MARK: - UI Components
    private lazy var citySelector: CityView = {
	   let citySelector = CityView()
	   return citySelector
    }()
    
    private lazy var tableView:UITableView = {
	   let tableView = UITableView()
	   tableView.delegate = self
	   tableView.dataSource = self
	   
	   tableView.register(BannersTableViewCell.self,
					  forCellReuseIdentifier: Constants.bannersIdentifier)
	   tableView.register(FoodTableViewCell.self,
					  forCellReuseIdentifier: Constants.foodIdentifier)
	   
	   tableView.separatorStyle = .none
	   tableView.backgroundColor = Colors.basicColor
	   
	   tableView.sectionHeaderTopPadding = .zero
	   tableView.sectionFooterHeight = .zero
	   tableView.sectionHeaderHeight = .zero
	   tableView.allowsSelection = false
	   
	   return tableView
    }()
    //MARK: - init
    init(menuPresenter: MenuPresenter) {
	   self.menuPresenter = menuPresenter
	   
	   super.init(nibName: nil, bundle: nil)
	   
	   self.menuPresenter.collectionChangedHandler = foodCollectionChanged(category:)
    }
    
    required init?(coder: NSCoder) {
	   fatalError()
    }
    //MARK: - LifeCycle
    override func viewDidLoad() {
	   super.viewDidLoad()
	   
	   setupUI()
    }
    //MARK: - functions
    private func setupUI() {
	   view.backgroundColor = Colors.basicColor
	   
	   view.addSubview(citySelector)
	   view.addSubview(tableView)
	   
	   citySelector.translatesAutoresizingMaskIntoConstraints = false
	   tableView.translatesAutoresizingMaskIntoConstraints = false
	   
	   citySelector.snp.makeConstraints { make in
		  make.left.top.right.equalTo(view.safeAreaLayoutGuide)
		  make.height.equalTo(Constants.snpCitySelectorHeight)
	   }
	   
	   tableView.snp.makeConstraints { make in
		  make.top.equalTo(citySelector.snp.bottom).offset(Constants.snpTableViewTop)
		  make.left.equalTo(Constants.snpTableViewLeft)
		  make.right.equalTo(Constants.snpTableViewRight)
		  make.bottom.equalTo(view.safeAreaLayoutGuide)
	   }
	   
	   tableView.reloadData()
	   menuPresenter.load()
    }
    
    private func foodCollectionChanged(category: FoodCategory) {
	   tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
    }
}
//MARK: - extension UITableViewDelegate
extension MenuViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
	   if (section == 1) {
		  let header = FoodTableHeader(menuPresenter: menuPresenter,
								 reuseIdentifier: nil)
		  header.update(categories: FoodCategory.allCases)
		  return header
	   }
	   
	   return nil
    }
}
//MARK: - extension UITableViewDataSource
extension MenuViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	   
	   if (indexPath.section == 0) {
		  guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.bannersIdentifier,
											    for: indexPath) as? BannersTableViewCell else {
			 return UITableViewCell()
		  }
		  return cell
	   }
	   
	   if (indexPath.section == 1) {
		  guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.foodIdentifier,
											    for: indexPath) as? FoodTableViewCell else {
			 return UITableViewCell()
		  }
		  let food = menuPresenter.foodCollection[indexPath.row]
		  cell.update(by: food)
		  return cell
	   }
	   
	   return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
	   return Constants.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
	   
	   switch section {
	   case 0:
		  return 1
	   case 1:
		  return menuPresenter.foodCollection.count
	   default:
		  return 0
	   }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
	   
	   if (indexPath.section == 0) {
		  return Constants.indexPathSectionZero
	   }
	   
	   if (indexPath.section == 1) {
		  return Constants.indexPathSectionOne
	   }
	   
	   return .zero
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
	   if (section == 1) {
		  return Constants.sectionOne
	   }
	   
	   return .zero
    }
}

// MARK: - Constants

fileprivate extension MenuViewController {
    enum Constants {
	   
	   static let bannersIdentifier = "BannersTableViewCell"
	   static let foodIdentifier = "FoodTableViewCell"
	   
	   static let numberOfSections = 3
	   static let snpCitySelectorHeight = 40.0
	   static let snpTableViewTop = 24.0
	   static let snpTableViewLeft = 16.0
	   static let snpTableViewRight = -16.0
	   static let indexPathSectionZero = 112.0
	   static let indexPathSectionOne = 172.0
	   static let sectionOne = 80.0

    }
}

