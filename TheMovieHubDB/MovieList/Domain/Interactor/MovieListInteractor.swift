//
//  MovieListInteractor.swift
//  TheMovieHubDB
//
//  Created by Atchibabu Chitri on 16/7/23.
//

import Foundation
import Factory

struct MovieListInteractor: MovieListInteractorContract {
    @Injected(\.movieListRepository) private var repository

    func fetchMovieList(_ page: Int = 1) async throws -> moviesModel {
        return try await self.repository.fetchMovieList(page)
    }
    func fetchImage(_ url: String) async throws -> savedCache {
        return try await self.repository.fetchImage(url)
    }
}


protocol MovieListInteractorContract {
    
    func fetchMovieList(_ page: Int) async throws -> moviesModel
    func fetchImage(_ url: String) async throws -> savedCache
}
