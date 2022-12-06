//
//  ImageLoader.swift
//  Drom
//
//  Created by Izzat on 05.12.2022.
//

import UIKit

final class ImageLoader {

    private let globalQueue = DispatchQueue.global(qos: .userInitiated)
    private let mainQueue = DispatchQueue.main
    private let errorImage = AppConstants.Images.errorLoadingImages

    private let cache = NSCache<NSString, UIImage>()

    // MARK: - Public method

    func imageFor(stringURL: String,
                  completionHandler: @escaping (String, UIImage?) -> Void) {
        self.globalQueue.async {
            guard let url = URL(string: stringURL) else {
                return
            }
            if let imageInCache = self.cache.object(forKey: stringURL as NSString)  {
                self.mainQueue.async {
                    completionHandler(stringURL, imageInCache)
                }
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let _ = error {
                    self.mainQueue.async {
                        completionHandler(stringURL, self.errorImage)
                    }
                    return
                }
                guard let data = data,
                      let image = UIImage(data: data) else {
                    self.mainQueue.async {
                        completionHandler(stringURL, self.errorImage)
                    }
                    return
                }
                self.cache.setObject(image, forKey: stringURL as NSString)
                self.mainQueue.async {
                    completionHandler(stringURL, image)
                }
            }
            task.resume()
        }
    }
}

