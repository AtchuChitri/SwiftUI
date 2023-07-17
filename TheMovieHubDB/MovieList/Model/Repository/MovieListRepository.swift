//
//  MovieListRepository.swift
//  TheMovieHubDB
//
//  Created by Atchibabu Chitri on 16/7/23.
//

import Foundation
import Factory

struct MovieListRepository: MovieListRepositoryContract {
    @Injected(\.webService) private var webService
    @Injected(\.imageCache) private var imageCache

    func fetchMovieList(_ page: Int = 1) async throws -> moviesModel {
        let apiEndPoint = ApiEndpoint.movie(.nowPlaying)
        let webRequest = WebServiceRequest(apiEndpoint: apiEndPoint)
        return try await webService.processWebService(request: webRequest, as: moviesModel.self)
    }
    func fetchImage(_ url: String) async throws -> savedCache {
        if let cachedImage = imageCache.get(forKey: url) {
            return cachedImage
        }
        guard let urlStr = URL(string: url) else { throw WebServiceError.invalidRequest}
       let urlRequest = URLRequest(url: urlStr)
        var (data, _) = try await URLSession.shared.data(for: urlRequest)
        if let image = savedCache(data: data) {
            imageCache.set(forKey: url, image: image)
            return image
        }
        throw WebServiceError.invalidRequest
    }
    
}

protocol MovieListRepositoryContract {
    func fetchMovieList(_ page: Int) async throws -> moviesModel
    func fetchImage(_ url: String) async throws -> savedCache
}
