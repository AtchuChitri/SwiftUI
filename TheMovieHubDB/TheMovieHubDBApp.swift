//
//  TheMovieHubDBApp.swift
//  TheMovieHubDB
//
//  Created by Atchibabu Chitri on 30/6/23.
//

import SwiftUI
import ComposableArchitecture

@main
struct TheMovieHubDBApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: Store(initialState: MovieListFeature.State(), reducer: MovieListFeature.live))
        }
    }
}
