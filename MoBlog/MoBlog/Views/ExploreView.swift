//
//  ExploreView.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-04-17.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import SwiftUI

struct ExploreView: View {
    let featuredData = [PostData[9], PostData[8], PostData[7], PostData[6]]
    
    let newData = [PostData[0], PostData[1], PostData[2], PostData[3], PostData[4]]
    
    init(){
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            Color.init(.systemGray6)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Explore")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 20)
                
                // MARK: Featured
                
                Section(label: "Featured") {
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack(spacing: 10) {
                            ForEach(self.featuredData) { post in
                                ExploreFeaturedPost(text: post.title)
                            }
                        }
                        .padding(.leading, 10)
                    })
                    .frame(height: 190)
                }
                Divider()
                
                // MARK: New Additions
                
                Section(label: "New Additions") {
                    List(self.newData) { post in
                        Text(post.title)
                    }
                    .frame(height: (CGFloat(self.newData.count) * 44))
                }
                Divider()
                
                
                Spacer()
            }
        }
        
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
            .environment(\.colorScheme, .dark)
    }
}
