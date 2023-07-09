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
    }
    enum Action: Equatable {
        case fetchMovieList
        case movieResponse(Result<moviesModel, WebServiceError>)
        case movieList(TaskResult<moviesModel>)
    }
    var webRequest: WebServiceContract = WebService()
    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .fetchMovieList:
            return .task {
                await .movieList(
                TaskResult{
                    let apiEndPoint = ApiEndpoint.movie(.nowPlaying)
                    return try await webRequest.processWebService(request: WebServiceRequest(apiEndpoint: apiEndPoint), as: moviesModel.self)
                }
                )
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
        }
    }
}
