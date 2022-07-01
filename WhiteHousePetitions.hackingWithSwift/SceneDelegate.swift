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
        let viewController = MainViewController()
        viewController.title = "Petitions"
        viewController.tabBarItem = UITabBarItem(title: "Petitions", image: UIImage(systemName: "list.bullet.rectangle"), tag: 0)
        return UINavigationController(rootViewController: viewController)
    }
    
    private func createFavoritelViewController() -> UINavigationController {
        let viewController = MainViewController()
        viewController.title = "Most favorite"
        viewController.tabBarItem = UITabBarItem(title: "Most favorite", image: UIImage(systemName: "doc.richtext"), tag: 1)
        return UINavigationController(rootViewController: viewController)
    }
    
    private func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        UITabBar.appearance().backgroundColor = .lightGray
        UITabBar.appearance().barTintColor = .white
        tabBarController.viewControllers = [createFeedViewController(), createFavoritelViewController()]
        return tabBarController
    }
    
    
}

