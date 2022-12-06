//
//  ImagesListVCAssembly.swift
//  Drom
//
//  Created by Izzat on 05.12.2022.
//

import UIKit

enum ImagesListVCAssembly {
    static func createVC() -> UIViewController {
        let interactor = ImagesListInteractor()
        let router = ImagesListRouter()
        let presenter = ImagesListPresenter(interactor: interactor,
                                            router: router)
        let viewController = ImagesListViewController(presenter: presenter)

        router.vc = viewController
        interactor.presenter = presenter

        return viewController
    }
}
