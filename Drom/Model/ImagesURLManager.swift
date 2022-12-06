//
//  ImagesURLManager.swift
//  Drom
//
//  Created by Izzat on 05.12.2022.
//

import Foundation

final class ImagesURLManager {
    // Смоделируем получение URL-ов из интернета,
    // поэтому вернем их блоком completion,
    // а не просто return
    func getImagesStringURL(completion: ([String]) -> Void) {
        let imagesURL: [String] = [
            "https://www.avtovzglyad.ru/media/article/slider0.jpg.740x555_q85_box-83%2C0%2C1262%2C883_crop_detail_upscale.jpg",
            "https://imageio.forbes.com/specials-images/imageserve/5f962df3991e5636a2f68758/0x0.jpg?format=jpg&crop=812,457,x89,y103,safe&width=1200",
            "https://cdn5.vedomosti.ru/image/2020/8/14dh54/original-1gbq.jpg",
            "https://stimg.cardekho.com/images/carexteriorimages/930x620/Jaguar/F-TYPE/7810/1643799635985/front-left-side-47.jpg",
            "https://mclaren.scene7.com/is/image/mclaren/McLarenArtura-16:crop-16x9?wid=1980&hei=1114",
            "https://rg.ru/uploads/images/208/07/82/1111111.jpg"
        ]

        completion(imagesURL)
    }
}
