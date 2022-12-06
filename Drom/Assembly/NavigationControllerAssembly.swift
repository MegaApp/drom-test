//
//  NavigationControllerAssembly.swift
//  Drom
//
//  Created by Izzat on 05.12.2022.
//

import UIKit

enum NavigationControllerAssembly {
    static func createNavigationController(rootViewController viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }
}
