//
//  MainTabBarController.swift
//  Movies
//
//  Created by David Jiménez Guinaldo on 24/5/25.
//


import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}

extension MainTabBarController {
    private func setupTabs() {
        let movieListViewController = UINavigationController(rootViewController: ListViewController())
        let tvShowListViewController = UINavigationController(rootViewController: ListViewController())
        movieListViewController.tabBarItem.title = "Movies"
        movieListViewController.tabBarItem.image = UIImage(systemName: "film")
        tvShowListViewController.tabBarItem.title = "TV Shows"
        tvShowListViewController.tabBarItem.image = UIImage(systemName: "tv")
        viewControllers = [
            movieListViewController,
            tvShowListViewController
        ]
    }
}
