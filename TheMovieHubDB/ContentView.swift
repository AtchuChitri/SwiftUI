//
//  ContentView.swift
//  TheMovieHubDB
//
//  Created by Atchibabu Chitri on 30/6/23.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    let store: Store<MovieListFeature.State, MovieListFeature.Action>
    // 1. Number of items will be display in row
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10, content: {
                        ForEach(viewStore.dataSource) { item in
                            MovieCardView(model: item)
                        }
                    })
                    
                    .onAppear {
                        viewStore.send(.fetchMovieList)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: Store(initialState: MovieListFeature.State(), reducer: MovieListFeature()))
    }
}
