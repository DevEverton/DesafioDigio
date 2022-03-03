//
//  AppDelegate.swift
//  DesafioDigio
//
//  Created by Everton Carneiro on 25/02/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let productsVC = ProductsListViewController()
        let navigationController = UINavigationController(rootViewController: productsVC)
        
        NavigationController.shared = navigationController

        window?.rootViewController =  NavigationController.shared
        return true
    }

}


protocol NavigationControllerInjected {}

extension NavigationControllerInjected {
    var navController: UINavigationController { return NavigationController.shared }
}

class NavigationController {

    static var shared = UINavigationController()
}

