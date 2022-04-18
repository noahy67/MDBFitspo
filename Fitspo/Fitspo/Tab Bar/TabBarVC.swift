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
        homeVC.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        homeVC.title = "Home"
        
        return UINavigationController(rootViewController: homeVC)
    }
    
    func createDiscoverVC() -> UINavigationController {
        let discoverVC = DiscoverVC()
        discoverVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        discoverVC.title = "Discover"
        
        return UINavigationController(rootViewController: discoverVC)
    }
    
    func createProfileVC() -> UINavigationController {
        let profileVC = ProfileVC()
        profileVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        profileVC.title = "Profile"
        
        return UINavigationController(rootViewController: profileVC)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .fitOrange
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().backgroundColor = .white
        
        viewControllers = [createHomeVC(), createDiscoverVC(), createProfileVC()]
    }
    
}
