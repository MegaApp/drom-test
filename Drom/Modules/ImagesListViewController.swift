//
//  ImagesListViewController.swift
//  Drom
//
//  Created by Izzat on 06.12.2022.
//

import UIKit

class ImagesListViewController: UIViewController {

    // MARK: - Properties

    private let presenter: IImagesListPresenter
    private let ui = ImagesListView()

    // MARK: - Init

    init(presenter: IImagesListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - VC Lifecycle

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view = self.ui
        self.presenter.viewDidAppear(ui: self.ui)
    }
}

