//
//  MovieListContainer.swift
//  TheMovieHubDB
//
//  Created by Atchibabu Chitri on 16/7/23.
//

import Foundation
import Factory

extension Container {
    var movieListInteractor: Factory<MovieListInteractorContract> {
        Factory(self) { MovieListInteractor() }
        }
    var movieListRepository: Factory<MovieListRepositoryContract> {
        Factory(self) { MovieListRepository() }
        }
    var webService: Factory<WebServiceContract> {
            Factory(self) { WebService() }
        }
    var imageCache: Factory<ImageCacheContract> {
            Factory(self) { ImageCache() }
        }
    @MainActor
    var movieListViewModel: Factory<MovieListViewModel> {
            Factory(self) { MovieListViewModel() }
        }
}
