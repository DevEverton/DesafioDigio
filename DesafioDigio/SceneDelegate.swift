//
//  SceneDelegate.swift
//  DesafioDigio
//
//  Created by Everton Carneiro on 25/02/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let productsVC = ProductsListViewController()
        let navigationController = UINavigationController(rootViewController: productsVC)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
}

