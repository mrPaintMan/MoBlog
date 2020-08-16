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
    
    init(post: Post) {
        let unixAge = NSDate().timeIntervalSince1970 - post.created
        self.color = post.color
        self.post = post
        self.age = "\(Int(unixAge / (24 * 60 * 60))) days old"
    }
    
    var body: some View {
        Rectangle()
            .frame(height: 150)
            .foregroundColor(.clear)
            .background(LinearGradient(gradient: Gradient(colors: [color.opacity(0.5), color]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(20)
            .overlay(
                VStack() {
                    HStack {
                        Text(age)
                            .font(.system(size: 15))
                            .padding(5)
                            .padding(.leading, 10)
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    Text(post.title)
                        .font(.system(size: 20))
                        .bold()
                        .padding(.horizontal, 20)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    
                    Tag(label: post.source, color: Color.init(.lightText))
                }
                .padding(.vertical, 5)
            )
    }
}

struct HomePost_Previews: PreviewProvider {
    static var previews: some View {
        HomePost(post: PostData[0])
    }
}
