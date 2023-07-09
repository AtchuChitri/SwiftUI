//
//  ImageLoader.swift
//  SwiftHub
//
//  Created by Atchibabu Chitri on 25/6/23.
//

import Foundation
import UIKit
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?

     @MainActor
     func loadImage(url: String) async throws  {
         let imageCache:ImageCacheContract = ImageCache()
            if let cachedImage = imageCache.get(forKey: url) {
                    self.image = cachedImage
                   return 
            }
            guard let urlStr = URL(string: url) else { return  }
           let urlRequest = URLRequest(url: urlStr)
         
         let (data, _) = try await URLSession.shared.data(for: urlRequest)
         if  let image = UIImage(data: data) {
             self.image = image
             imageCache.set(forKey: url, image: image)
         }
    }
        
       
        

}
