//
//  MovieImage.swift
//  SwiftHub
//
//  Created by Atchibabu Chitri on 25/6/23.
//

import SwiftUI
import Factory

struct MovieImage: View {
    var urlString: String
    @ObservedObject var viewModel = resolve(\.movieListViewModel)


    var body: some View {
            Image(uiImage: viewModel.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top,0)
                .padding(.leading,0)
                .cornerRadius(5)
                .onAppear {
                    viewModel.fetchImage(urlString)
                }
        }
}


