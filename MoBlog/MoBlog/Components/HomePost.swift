//
//  HomePost.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-04-18.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import SwiftUI

struct HomePost: View {
    var age: String
    var post: Post
    var color: Color
    var colors: [Color] = [
        Color.init(.systemBlue),
        Color.init(.systemRed),
        Color.init(.systemGreen),
        Color.init(.systemOrange),
        Color.init(.systemYellow)
    ]
    
    init(post: Post) {
        let unixAge = NSDate().timeIntervalSince1970 - post.created
        let i = Int.random(in: 0...4)
        self.color = self.colors[i]
        self.post = post
        self.age = "\(Int(unixAge / (24 * 60 * 60))) days old"
    }
    
    var body: some View {
        Rectangle()
            .frame(height: 150)
            .foregroundColor(.clear)
            .background(LinearGradient(gradient: Gradient(colors: [color.opacity(0.5), color]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(20)
            //.shadow(color: Color.init(.systemGray4),radius: 10, x: 0, y: 10)
            .overlay(
                HStack {
                    VStack(alignment: .leading) {
                        Text(post.source)
                            .font(.system(size: 25))
                            .bold()
                            .padding(30)
                        
                        Text(post.title)
                            .padding(.leading, 30)
                        
                        Text(age)
                            .padding(.leading, 30)
                        
                        Spacer()
                    }
                
                    Spacer()
                }
            )
    }
}

struct HomePost_Previews: PreviewProvider {
    static var previews: some View {
        HomePost(post: PostData[0])
    }
}
