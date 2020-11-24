//
//  HomeProfileImage.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-08-21.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import SwiftUI

struct ProfileImage: View {
    @ObservedObject var source: Source
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        self.source.getImage(size: CGSize(width: width, height: height))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: width, height: height, alignment: .center)
            .background(Color(.darkGray))
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .leading, endPoint: .trailing), lineWidth: 1)
        )
    }
}


struct HomeProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImage(source: SourceData[0], width: 50, height: 50)
        .environment(\.colorScheme, .dark)
    }
}
