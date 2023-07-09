//
//  MovieCardView.swift
//  TheMovieHubDB
//
//  Created by Atchibabu Chitri on 30/6/23.
//

import SwiftUI

struct MovieCardView: View {
    
    var model:MovieModel
    let imageUrl = "https://image.tmdb.org/t/p/w300"
    
    
    var body: some View {
        ZStack(alignment: .center){
            VStack {
               
                        MovieImage(urlString: imageUrl + (model.poster ?? ""))
                ZStack {
                    MovieRateView(progress: 0.40)
                    Text("\(0.50 * 100, specifier: "%.0f")")
                                       .font(.caption2)
                                       .bold()
                                       .foregroundColor(.white)
                }.frame(width: 30)
                    .padding(.top,-20)
                    .padding(.leading,-50)
              Spacer(minLength: 1)
                HStack {
                    VStack(alignment: .center,spacing: 1) {
                        Text(model.title ?? "")
                            .font(.subheadline)
                            .multilineTextAlignment(.center)
                            .bold()
                            .fontWeight(.light)
                        Text(model.releaseDate?.getDateString() ?? "")
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                }
            }.frame(width: 120, height: 260)
                .background(.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.2), radius: 5,x: 5,y: 5)

            
        }
            }
        
}

struct MovieCardView_Previews: PreviewProvider {
    
    static var previews: some View {
        MovieCardView(model: MovieModel(id: 385687, title: "Fast X", releaseDate: "2023-05-17", overview: "Over many missions and against impossible odds, Dom Toretto and his family have outsmarted, out-nerved and outdriven every foe in their path. Now, they confront the most lethal opponent they've ever faced: A terrifying threat emerging from the shadows of the past who's fueled by blood revenge, and who is determined to shatter this family and destroy everything—and everyone—that Dom loves, forever.", originalTitle: "Fast X", poster: "/fiVW06jE7z9YnO4trhaMEdclSiC.jpg", genreIds: [28,80,53], voteAverage: 7.3, voteCount: 2226))
    }
}
