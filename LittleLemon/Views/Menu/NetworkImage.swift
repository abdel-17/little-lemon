//
//  NetworkImage.swift
//  LittleLemon
//
//  Created by Abdel on 31/03/2023.
//

import SwiftUI

struct NetworkImage: View {
    let imageUrl: URL?

    let width: Double

    let height: Double
    
    private let borderWidth = 2.0

    var body: some View {
        AsyncImage(url: imageUrl) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .frame(width: width, height: height)
            } else if phase.error != nil {
                Image(systemName: "xmark.icloud")
                    .frame(width: width, height: height)
                    .imageScale(.large)
                    .foregroundColor(.red)
                    .border(.red, width: borderWidth)
            } else {
                ProgressView()
                    .frame(width: width, height: height)
                    .border(.secondary, width: borderWidth)
            }
        }
    }
}

struct NetworkImage_Previews: PreviewProvider {
    static var previews: some View {
        NetworkImage(imageUrl: Dish.preview.imageUrl,
                     width: 160,
                     height: 100)
    }
}
