//
//  MovieImage.swift
//  SwiftHub
//
//  Created by Atchibabu Chitri on 25/6/23.
//

import SwiftUI
import ComposableArchitecture

struct MovieImage: View {
    let store: Store<MovieImageFeature.State, MovieImageFeature.Action>

    var urlString: String


    var body: some View {
        WithViewStore(self.store) { viewStore in
            Image(uiImage: viewStore.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top,0)
                .padding(.leading,0)
                .cornerRadius(5)
                .onAppear {
                        viewStore.send(.fetchImage(urlString))
                }
        }
       }
}


