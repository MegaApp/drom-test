//
//  AppConstants.swift
//  Drom
//
//  Created by Izzat on 05.12.2022.
//

import UIKit

enum AppConstants {

    // MARK: - Images

    enum Images {
        static let errorLoadingImages = UIImage(named: "ErorrImage")
    }

    // MARK: - Constants

    enum Constraints {
        static let normalAnchor: CGFloat = 16
        static let insets: CGFloat = 10
    }

    // MARK: - AnimationTime

    enum AnimationTime {
        static let collectionViewCellSlideAnimation: Double = 0.3
    }

    // MARK: - DelayTime

    enum DelayTime {
        static let refreshControlDelay: Double = 0.5
    }
}
