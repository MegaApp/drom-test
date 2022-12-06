//
//  ImagesListCollectionViewCell.swift
//  Drom
//
//  Created by Izzat on 06.12.2022.
//

import UIKit

final class ImagesListCollectionViewCell: UICollectionViewCell {

    // MARK: - Views

    private lazy var imageView: UIImageView = {
        let myImageView = UIImageView()
        myImageView.contentMode = .scaleAspectFill
        myImageView.accessibilityIdentifier = "collectionViewCellImageView"
        myImageView.clipsToBounds = true
        return myImageView
    }()

    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let myActivityIndicatorView = UIActivityIndicatorView(style: .medium)
        myActivityIndicatorView.startAnimating()
        myActivityIndicatorView.hidesWhenStopped = true
        myActivityIndicatorView.accessibilityIdentifier = "collectionViewCellActivityIndicatorView"
        myActivityIndicatorView.color = .black
        return myActivityIndicatorView
    }()

    // MARK: - Properties

    static var reuseIdentifier: String {
        return String(describing: ImagesListCollectionViewCell.self)
    }
    private let imageLoader = ImageLoader()
    private var stringImageURL: String? {
        didSet {
            self.updateUI()
        }
    }

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupElements()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public method

    func setupCell(stringURL: String) {
        self.stringImageURL = stringURL
    }

    private func updateUI() {
        self.imageView.image = nil
        self.activityIndicatorView.startAnimating()
        if let stringURL = self.stringImageURL {
            self.imageLoader.imageFor(stringURL: stringURL) { (stringURL, image) in
                if stringURL == self.stringImageURL {
                    self.imageView.image = image
                    self.activityIndicatorView.stopAnimating()
                }
            }
        } else {
            self.imageView.image = AppConstants.Images.errorLoadingImages
        }
    }
}

// MARK: - UISetup

private extension ImagesListCollectionViewCell {
    func setupElements() {
        self.setupImageView()
    }

    func setupImageView() {
        self.contentView.addSubview(self.imageView)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
        self.setupActivityIndicatorView()
    }

    func setupActivityIndicatorView() {
        self.contentView.addSubview(self.activityIndicatorView)
        self.activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor),
            self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor)
        ])
    }
}

