//
//  SceneDelegate.swift
//  TripNN
//
//  Created by Pavel on 30.01.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        let rootController = HomeScreenViewController()
        let navigationController = UINavigationController(rootViewController: rootController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        window.overrideUserInterfaceStyle = UserDefaults.standard.theme.getUserInterfaceStyle()
        self.window = window
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}

}
