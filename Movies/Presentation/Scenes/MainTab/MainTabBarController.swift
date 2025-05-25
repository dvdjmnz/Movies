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
        delegate = self
        setupTabs()
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}

extension MainTabBarController {
    private func setupTabs() {
        let movieListViewController = DIConfiguration.shared.container.resolve(MovieListViewController.self)!
        let tvShowListViewController = UIViewController()
        UITabBar.appearance().tintColor = .systemPurple
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

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let selectedViewController = tabBarController.selectedViewController, selectedViewController == viewController {
            scrollToTop(in: viewController)
            return false
        }
        return true
    }
    
    private func scrollToTop(in viewController: UIViewController) {
        if let navController = viewController as? UINavigationController {
            scrollToTop(in: navController.topViewController)
        } else if let scrollableVC = viewController as? ScrollableViewController {
            scrollableVC.scrollToTop()
        }
    }
    
    private func scrollToTop(in viewController: UIViewController?) {
        guard let viewController = viewController as? ScrollableViewController else { return }
        viewController.scrollToTop()
    }
}
