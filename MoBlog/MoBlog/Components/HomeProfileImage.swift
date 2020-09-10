//
//  HomeProfileImage.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-08-21.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import SwiftUI

struct HomeProfileImage: View {
    @ObservedObject var source: Source
    
    var body: some View {
        self.source.getImage(size: CGSize(width: 50, height: 50))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 50, height: 50, alignment: .center)
            .background(Color(.darkGray))
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color(.white), lineWidth: 1)
        )
    }
}


struct HomeProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        HomeProfileImage(source: SourceData[0])
        .environment(\.colorScheme, .dark)
    }
}
