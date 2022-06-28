//
//  SceneDelegate.swift
//  WhiteHousePetitions.hackingWithSwift
//
//  Created by Илья Шаповалов on 27.06.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let tabBarController = createTabBarController()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    //MARK: - Configurate Controllers
    private func createFeedViewController() -> UINavigationController {
        let feedViewController = FeedViewController()
        feedViewController.title = "Petitions"
        feedViewController.tabBarItem = UITabBarItem(title: "Petitions", image: UIImage(systemName: "list.bullet.rectangle"), tag: 0)
        return UINavigationController(rootViewController: feedViewController)
    }
    
    private func createDetailViewController() -> UINavigationController {
        let detailViewController = DetailViewController()
        detailViewController.title = "Detail"
        detailViewController.tabBarItem = UITabBarItem(title: "Details", image: UIImage(systemName: "doc.richtext"), tag: 1)
        return UINavigationController(rootViewController: detailViewController)
    }
    
    private func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        UITabBar.appearance().backgroundColor = .lightGray
        UITabBar.appearance().barTintColor = .white
        tabBarController.viewControllers = [createFeedViewController(), createDetailViewController()]
        return tabBarController
    }
    
    
}

