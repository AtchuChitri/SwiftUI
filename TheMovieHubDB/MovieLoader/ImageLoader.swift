//
//  ImageLoader.swift
//  SwiftHub
//
//  Created by Atchibabu Chitri on 25/6/23.
//

import Foundation
import UIKit
import Combine
import ComposableArchitecture

struct MovieImageFeature: ReducerProtocol {
    
    struct State: Equatable {
        var image: UIImage = UIImage()
    }
    
    enum Action: Equatable {
        case fetchImage(_ url: String)
        case saveImage(_ image: TaskResult<UIImage?>, key: String)
    }
    func getImage(_ url: String) async throws -> UIImage? {
        guard let urlStr = URL(string: url) else { return nil }
       let urlRequest = URLRequest(url: urlStr)
     let (data, _) = try await URLSession.shared.data(for: urlRequest)
        if  let image = UIImage(data: data) {
            return image
        }
        return nil
    }
    

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .fetchImage(let url):
             
            return .task {
                await .saveImage(
                    TaskResult {
                        return try await getImage(url)
                    }, key: url
                )
            }
        case .saveImage(.success(let image), let key):
            if let img = image {
                state.image =  img
                let imageCache:ImageCacheContract = ImageCache()
                imageCache.set(forKey: key, image: img)
            }
            return .none

        case .saveImage(.failure(_), _):
            return .none
        }
    }
    
    private static func imageAlreadySaved(_ url: String, state: inout State ) -> EffectTask<Action> {
        let imageCache:ImageCacheContract = ImageCache()
        if let cachedImage = imageCache.get(forKey: url) {
            state.image = cachedImage
        }
        return .none
    }
}



