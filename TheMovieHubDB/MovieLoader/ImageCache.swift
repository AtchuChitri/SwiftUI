//
//  ImageCache.swift
//  SwiftHub
//
//  Created by Atchibabu Chitri on 25/6/23.
//

import Foundation
import UIKit
//db3f5d56b1bd4131068f8232dcba7d49
class ImageCache: ImageCacheContract {
    private let cache = NSCache<NSString, UIImage>()

    func get(forKey: String) -> UIImage? {
           print(forKey)
            return cache.object(forKey: NSString(string: forKey))
        }
    
    func set(forKey: String, image: UIImage) {
           cache.setObject(image, forKey: NSString(string: forKey))
       }
}


protocol ImageCacheContract {
    func set(forKey: String, image: UIImage)
    func get(forKey: String) -> UIImage?
}
