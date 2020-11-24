//
//  ExploreFeaturedPost.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-04-17.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import SwiftUI

struct ExploreFeaturedPost: View {
    var text: String
    var body: some View {
        
        Rectangle()
            .frame(width: 240, height: 160)
            .overlay(
                Text(text)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            )
            .foregroundColor(Color.moBlogRed.opacity(0.8))
            .cornerRadius(15)
    }
}

struct ExploreFeaturedPost_Previews: PreviewProvider {
    static var previews: some View {
        ExploreFeaturedPost(text: "Hello")
    }
}
