//
//  TabViewController.swift
//  tastyPizza
//
//  Created by Enzhe Gaysina on 13.01.2024.
//

import UIKit

final class TabViewController: UITabBarController {
    
    private let menuPresenter: MenuPresenter
    
    init() {
	   self.menuPresenter = MenuPresenter(foodProvider: NetworkService())
	   super.init(nibName: nil, bundle: nil)
	   setupTab()
    }
    
    required init?(coder: NSCoder) {
	   fatalError(.textFatal)
    }
    
    override func viewDidLoad() {
	   super.viewDidLoad()
	   setupTab()
    }
    
    private func setupTab() {
	   
	   let menuController = MenuViewController(menuPresenter: menuPresenter)
	   let contactsController = ContactsViewController()
	   let profileController = ProfileViewController()
	   let basketController = BasketViewController()
	   
	   menuController.tabBarItem = UITabBarItem(title: Constants.titleTagOne,
									    image: UIImage(named: Constants.imageTagOne),
									    tag: 1
	   )
	   contactsController.tabBarItem = UITabBarItem(title: Constants.titleTagTwo,
										   image: UIImage(named: Constants.imageTagTwo),
										   tag: 2
	   )
	   profileController.tabBarItem = UITabBarItem(title: Constants.titleTagThree,
										  image: UIImage(named: Constants.imageTagThree),
										  tag: 3
	   )
	   basketController.tabBarItem = UITabBarItem(title: Constants.titleTagFour,
										 image: UIImage(named: Constants.imageTagFour),
										 tag: 4
	   )
	   
	   let controllers = [menuController,
					  contactsController,
					  profileController,
					  basketController
	   ]
	   
	   UITabBar.appearance().tintColor = Colors.tabBarTint
	   
	   UITabBarItem.appearance().setTitleTextAttributes(
		  [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Constants.setTitleFont,
												weight: .regular)], for: .normal)
	   
	   let lineView = UIView(frame: CGRect(x: .zero,
								    y: .zero,
								    width: tabBar.frame.size.width,
								    height: Constants.heightLineView)
	   )
	   lineView.backgroundColor = .gray
	   tabBar.addSubview(lineView)
	   
	   setViewControllers(controllers, animated: false)
	   tabBar.backgroundColor = .white
    }
}

// MARK: - Constants

fileprivate extension TabViewController {
    enum Constants {
	   
	   static let titleTagOne = "Меню"
	   static let imageTagOne = "ic-menu"
	   static let titleTagTwo = "Контакты"
	   static let imageTagTwo = "ic-contacts"
	   static let titleTagThree = "Профиль"
	   static let imageTagThree = "ic-profile"
	   static let titleTagFour = "Корзина"
	   static let imageTagFour = "ic-basket"
	   
	   static let setTitleFont = 13.0
	   static let heightLineView = 0.5
    }
}
