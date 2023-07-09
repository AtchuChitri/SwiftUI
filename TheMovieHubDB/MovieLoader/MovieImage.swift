//
//  MovieImage.swift
//  SwiftHub
//
//  Created by Atchibabu Chitri on 25/6/23.
//

import SwiftUI

struct MovieImage: View {
    @ObservedObject var imageLoader: ImageLoader = ImageLoader()
    @State var image: UIImage = UIImage()
    var urlString: String


    var body: some View {
        
        Image(uiImage: image)
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .padding(.top,0)
                   .padding(.leading,0)
                   .cornerRadius(5)
                   .onReceive(imageLoader.$image) { image in
                       if let img = image {
                           self.image = img
                       }
                   }
                   .onAppear {
                       Task {
                          try await imageLoader.loadImage(url: self.urlString)
                       }
                   }
                   
       }
}


