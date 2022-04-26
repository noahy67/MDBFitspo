//
//  TabBarVC.swift
//  Fitspo
//
//  Created by Noah Yin on 4/17/22.
//

import UIKit

class TabBarVC: UITabBarController {
    
    func createHomeVC() -> UINavigationController {
        let homeVC = HomeVC()
//        homeVC.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
//        homeVC.title = "Home"
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage.init(systemName: "house.fill"), tag: 0)
        
        return UINavigationController(rootViewController: homeVC)
    }
    
    func createDiscoverVC() -> UINavigationController {
        let discoverVC = DiscoverVC()
        discoverVC.tabBarItem = UITabBarItem(title: "Discover", image: UIImage.init(systemName: "magnifyingglass"), tag: 1)
//        discoverVC.title = "Discover"
        discoverVC.navigationController?.setNavigationBarHidden(true, animated: false)
        return UINavigationController(rootViewController: discoverVC)
    }
    
    func createProfileVC() -> UINavigationController {
        let profileVC = ProfileVC()
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage.init(systemName: "person.fill"), tag: 2)
//        profileVC.title = "Profile"
        profileVC.navigationController?.setNavigationBarHidden(true, animated: false)
        return UINavigationController(rootViewController: profileVC)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .fitOrange
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().backgroundColor = .systemBackground
        UITabBar.appearance().layer.shadowRadius = 2
        UITabBar.appearance().layer.shadowColor = UIColor.black.cgColor
        UITabBar.appearance().layer.shadowOpacity = 0.3
        UITabBar.appearance().layer.shadowOffset = CGSize(width: 0, height: 0)
        
        viewControllers = [createHomeVC(), createDiscoverVC(), createProfileVC()]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
}
