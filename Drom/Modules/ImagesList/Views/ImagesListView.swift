//
//  ImagesListView.swift
//  Drom
//
//  Created by Izzat on 06.12.2022.
//

import UIKit

protocol IImagesListView: AnyObject {
    var cellSelectedAt: ((IndexPath) -> Void)? { get set }
    var refreshControlDidChangedValue: (() -> Void)? { get set }

    func setupView(stringURLs: [String])
    func removeCellAt(indexPath: IndexPath)
    func reloadCollectionView(stringURLs: [String])
}

final class ImagesListView: UIView {

    // MARK: - Views

    private lazy var imagesCollectionView: UICollectionView = {
        let myCollectionView:UICollectionView = UICollectionView(
            frame: CGRect.zero,
            collectionViewLayout: UICollectionViewFlowLayout.init())
        myCollectionView.register(
            ImagesListCollectionViewCell.self,
            forCellWithReuseIdentifier: ImagesListCollectionViewCell.reuseIdentifier)
        myCollectionView.accessibilityIdentifier = "imagesCollectionView"
        myCollectionView.refreshControl = self.refreshControl
        return myCollectionView
    }()

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let myActivityIndicatorView = UIActivityIndicatorView(style: .large)
        myActivityIndicatorView.startAnimating()
        myActivityIndicatorView.hidesWhenStopped = true
        myActivityIndicatorView.color = .black
        myActivityIndicatorView.accessibilityIdentifier = "mainScreenActivityIndicatorView"
        return myActivityIndicatorView
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let myRefreshControl = UIRefreshControl()
        myRefreshControl.addTarget(self,
                                   action: #selector(refreshAction),
                                   for: .valueChanged)
        myRefreshControl.accessibilityIdentifier = "mainScreenRefreshControl"
        return myRefreshControl
    }()

    // MARK: - Properties

    private var imagesCollectionViewDataSource = ImagesCollectionViewDataSource()
    private var imagesCollectionViewDelegate: ImagesCollectionViewDelegate?
    var cellSelectedAt: ((IndexPath) -> Void)?
    var refreshControlDidChangedValue: (() -> Void)?

    // MARK: - Init

    init() {
        super.init(frame: .zero)
        self.backgroundColor = .systemBackground
        self.prepareView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Обработка действия от refreshControl

    @objc private func refreshAction() {
        // Пол секунды задержки для того, чтобы увидеть обновление
        DispatchQueue.main.asyncAfter(deadline: .now() + AppConstants.DelayTime.refreshControlDelay) {
            self.refreshControlDidChangedValue?()
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        let layout = self.setupCollectionViewLayout()
        self.imagesCollectionView.setCollectionViewLayout(layout, animated: false)
    }
}

// MARK: - IImagesListView

extension ImagesListView: IImagesListView {
    func setupView(stringURLs: [String]) {
        self.activityIndicatorView.stopAnimating()
        self.setupImagesCollectionView()
        self.imagesCollectionViewDataSource.setData(stringURLs: stringURLs)
        self.imagesCollectionView.reloadData()
    }

    func removeCellAt(indexPath: IndexPath) {
        self.imagesCollectionViewDataSource.removeAt(indexPath: indexPath)
        self.imagesCollectionView.deleteItems(at: [indexPath])
    }

    func reloadCollectionView(stringURLs: [String]) {
        self.imagesCollectionViewDataSource.setData(stringURLs: stringURLs)
        self.imagesCollectionView.reloadData()
        self.imagesCollectionView.refreshControl?.endRefreshing()
    }
}

// MARK: - UI preparing

private extension ImagesListView {
    func prepareView() {
        self.setupActivityIndicatorView()
    }

    func setupActivityIndicatorView() {
        self.addSubview(self.activityIndicatorView)
        self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}

// MARK: - Настройка imagesCollectionView

private extension ImagesListView {
    private func setupImagesCollectionView() {
        let layout = self.setupCollectionViewLayout()
        self.imagesCollectionView.setCollectionViewLayout(layout, animated: true)
        self.imagesCollectionViewDelegate = ImagesCollectionViewDelegate(withDelegate: self)
        self.imagesCollectionView.delegate = self.imagesCollectionViewDelegate
        self.imagesCollectionView.dataSource = self.imagesCollectionViewDataSource
        self.imagesCollectionView.backgroundColor = .clear

        self.addSubview(self.imagesCollectionView)
        self.imagesCollectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.imagesCollectionView.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: AppConstants.Constraints.normalAnchor),
            self.imagesCollectionView.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            self.imagesCollectionView.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            self.imagesCollectionView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor)
        ])
    }

    func setupCollectionViewLayout() -> UICollectionViewFlowLayout {
        // Ширина ячейки равна ширине экрана с отступами по 10 px с каждого края
        let itemWidth = self.frame.width - 2 * AppConstants.Constraints.insets
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        // Высота ячейки равна ширине
        layout.itemSize = CGSize(width: itemWidth,
                                 height: itemWidth)
        layout.sectionInset = UIEdgeInsets(top: AppConstants.Constraints.insets,
                                           left: AppConstants.Constraints.insets,
                                           bottom: AppConstants.Constraints.insets,
                                           right: AppConstants.Constraints.insets)
        layout.minimumLineSpacing = AppConstants.Constraints.normalAnchor
        return layout
    }
}

// MARK: - IImagesCollectionViewDelegate

extension ImagesListView: IImagesCollectionViewDelegate {
    func selectedCell(indexPath: IndexPath) {
        self.cellSelectedAt?(indexPath)
    }
}
