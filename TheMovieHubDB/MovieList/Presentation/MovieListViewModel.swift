//
//  MovieListViewModel.swift
//  TheMovieHubDB
//
//  Created by Atchibabu Chitri on 16/7/23.
//

import Foundation
import Factory
import UIKit

typealias savedCache = UIImage

@MainActor
class MovieListViewModel:ObservableObject {
    @Injected(\.movieListInteractor) private var interactor
   @Published var dataSource = [MovieModel]()
    @Published var image: UIImage = UIImage()
    
    private var totalRecords: Int = 0
    private var currentPage = 1
    init() {
        Task {
            let res = try await self.interactor.fetchMovieList(currentPage)
            self.totalRecords = res.totalRecords
            if let results = res.results {
                self.dataSource = results
            }
        }
    }
    
    func isLoadMore(_ item: MovieModel) async  {
        if (item == self.dataSource.last && self.dataSource.count != totalRecords) {
            currentPage += 1
            Task {
                let res = try await self.interactor.fetchMovieList(currentPage)
                self.totalRecords = res.totalRecords
                if let results = res.results {
                    self.dataSource += results
                }
            }
        }
    }
    func fetchImage(_ url: String) {
        Task {
            self.image = try await self.interactor.fetchImage(url)
        }
    }
    
}
