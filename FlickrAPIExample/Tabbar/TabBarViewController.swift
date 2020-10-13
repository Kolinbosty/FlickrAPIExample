//
//  TabBarViewController.swift
//  FlickrAPIExample
//
//  Created by  Alex Lin on 2020/10/12.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
    }

    func setupTabBar() {
        // Search Page
        let searchItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        searchItem.title = "Search"

        let searchVC = SearchViewController()
        let searchNavi = UINavigationController(rootViewController: searchVC)
        searchNavi.tabBarItem = searchItem

        // Favorite Page
        let favItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)

        favItem.title = "Favorite"

        let favVC = FavPageViewController()
        let favNavi = UINavigationController(rootViewController: favVC)
        favNavi.tabBarItem = favItem

        // Set Child
        setViewControllers([searchNavi, favNavi], animated: false)
    }
}
