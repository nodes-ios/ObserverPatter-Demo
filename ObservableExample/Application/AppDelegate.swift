//
//  AppDelegate.swift
//  ObservableExample
//
//  Created by Andrei Hogea on 01/03/2019.
//  Copyright © 2019 Nodes. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var cartVC: SmallCartViewController!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        let navigation = UINavigationController()
        let main = ProductCategoriesViewController.instantiate()
        navigation.setViewControllers([main], animated: false)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()

        makeCartVC()
        
        return true
    }
    
    private func makeCartVC() {
        cartVC = SmallCartViewController.instantiate()
        window?.addSubview(cartVC.view)
        
        cartVC.view.translatesAutoresizingMaskIntoConstraints = false
        cartVC.view.trailingAnchor.constraint(equalTo: window!.trailingAnchor, constant: -25).isActive = true
        cartVC.view.bottomAnchor.constraint(equalTo: window!.bottomAnchor, constant: -50).isActive = true
        cartVC.view.heightAnchor.constraint(equalToConstant: 75).isActive = true
        cartVC.view.widthAnchor.constraint(equalToConstant: 75).isActive = true
    }
}

