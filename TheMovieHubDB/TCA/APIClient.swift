//
//  APIClient.swift
//  TheMovieHubDB
//
//  Created by Atchibabu Chitri on 14/7/23.
//

import Foundation
import ComposableArchitecture

struct APIClient {
    var fetchMovies: @Sendable(Int) async throws -> moviesModel
}

extension APIClient {
    static let live = Self { page in
        let apiEndPoint = ApiEndpoint.movie(.nowPlaying)
        var webRequest: WebServiceContract = WebService()
        return try await webRequest.processWebService(request: WebServiceRequest(apiEndpoint: apiEndPoint,page: page), as: moviesModel.self)
    }

}
