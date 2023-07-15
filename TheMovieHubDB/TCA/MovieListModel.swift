//
//  MovieListModel.swift
//  TheMovieHubDB
//
//  Created by Atchibabu Chitri on 3/7/23.
//

import Foundation
import ComposableArchitecture

struct MovieListFeature: ReducerProtocol {

    struct State: Equatable  {
        var dataSource = IdentifiedArrayOf<MovieModel>()
        var currentPage = 1
        var isLoadMore = false
    }
    enum Action: Equatable {
        case fetchMovieList
        case movieResponse(Result<moviesModel, WebServiceError>)
        case movieList(TaskResult<moviesModel>)
        case loadMore(index: Int)
        case isLastIndex(_ model: MovieModel)
    }
    
    var allMovies: @Sendable (Int) async throws -> moviesModel

    static let live = Self(
        allMovies: APIClient.live.fetchMovies
    )
    
    
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .fetchMovieList:
            let page = state.currentPage
            return .task {
                await .movieList(
                    TaskResult{
                        try await allMovies(page)
                    })
            }
        case .movieResponse(.success(let model)):
            if let results = model.results {
                state.dataSource += results
            }
            return .none
        case .movieResponse(.failure(_)):
            return .none
        case .movieList(let model):
            switch model {
            case .success(let moviesModel):
                return EffectTask(value: .movieResponse(.success(moviesModel)))
            case .failure(_):
                return EffectTask(value: .movieResponse(.failure(WebServiceError.invalidRequest)))

            }
        case .loadMore(index: let page):
            return .task {
                await .movieList(
                TaskResult{
                     try await allMovies(page)
                }
                )
            }
        case .isLastIndex(let model):
            state.isLoadMore = model == state.dataSource.last
            if state.isLoadMore {
                state.currentPage  += 1
                return EffectTask(value: .loadMore(index: state.currentPage))
            }
            return .none
        }
    }
}
