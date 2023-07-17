//
//  ContentView.swift
//  TheMovieHubDB
//
//  Created by Atchibabu Chitri on 30/6/23.
//

import SwiftUI
import Factory

struct ContentView: View {
  //  @Injected(\.movieListViewModel) @ObservableObject var viewModel
    
    @ObservedObject var viewModel = resolve(\.movieListViewModel)

    
    // 1. Number of items will be display in row
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 10, content: {
                        ForEach(viewModel.dataSource) { item in
                            MovieCardView(model: item)
                                .onAppear{
                                    Task {
                                    await viewModel.isLoadMore(item)
                                    }
                            }
                              
                        }
                    })
                    .onAppear {
                    }
                .navigationBarTitle("The Movie Hub")

            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
