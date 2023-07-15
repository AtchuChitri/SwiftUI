//
//  MovieList.swift
//  MovieHub
//
//  Created by Atchu on 5/2/23.
//

import Foundation

struct moviesModel: Codable, Equatable {
    let page: Int
    let results: [MovieModel]?
    let totalRecords: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalRecords = "total_results"
    }
}

struct MovieModel: Codable,Identifiable, Equatable {
    let id: Int
    let title: String?
    let releaseDate: String?
    let overview: String?
    let originalTitle: String?
    let poster: String?
    let genreIds: [Int]?
    let voteAverage : Float?
    let voteCount: Float?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case releaseDate = "release_date"
        case originalTitle = "original_title"
        case poster = "poster_path"
        case genreIds = "genre_ids"
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
    }
}

extension moviesModel {
    static var sample: moviesModel {
        .init(
            page: 1, results: [
                .init(id: 667538, title: "Transformers", releaseDate: "2023-06-06", overview: "When a new threat capable of destroying the entire planet emerges, Optimus Prime and the Autobots must team up with a powerful faction known as the Maximals. With the fate of humanity hanging in the balance, humans Noah and Elena will do whatever it takes to help the Transformers as they engage in the ultimate battle to save Earth", originalTitle: "Knights of the Zodiac", poster: "/gPbM0MK8CP8A174rmUwGsADNYKD.jpg", genreIds: [1,2], voteAverage: 7.3, voteCount: 719)
            ], totalRecords: 20
        )
    }
}

