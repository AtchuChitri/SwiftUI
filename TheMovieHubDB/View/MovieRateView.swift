//
//  MovieRateView.swift
//  TheMovieHubDB
//
//  Created by Atchibabu Chitri on 2/7/23.
//

import SwiftUI

struct MovieRateView: View {
    let progress: Double
    var body: some View {
        ZStack {
                    Circle()
                        .stroke(
                            Color.green.opacity(0.5),
                            lineWidth: 5
                        )
                    Circle()
                        // 2
                .trim(from: 0, to: progress)
                        .stroke(
                            Color.green,
                            style: StrokeStyle(
                                lineWidth: 5,
                                lineCap: .round
                            )
                        )
                        .rotationEffect(.degrees(-90))
                        .background(Circle().foregroundColor(Color.black))

        }
    }
}

struct MovieRateView_Previews: PreviewProvider {
    static var previews: some View {
        MovieRateView(progress: 0.50)
    }
}
