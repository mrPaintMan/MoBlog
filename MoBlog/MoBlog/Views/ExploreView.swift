//
//  ExploreView.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-04-17.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import SwiftUI

struct ExploreView: View {
    let featuredPosts = [PostData[9], PostData[8], PostData[7], PostData[6]]
    @State var showInternetAlert = false
    @State var newPosts = [Post]()
    
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
                            ForEach(self.featuredPosts) { post in
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
                    List(self.newPosts) { post in
                        Text(post.title)
                    }
                    .frame(height: (CGFloat(self.newPosts.count) * 44))
                }
                Divider()
                
                
                Spacer()
            }
        }
        .onAppear {
            if self.newPosts.isEmpty {
                guard let posts: [Post] = PostRequest(page: 0, sourceCode: nil).response?.data else {
                    self.showInternetAlert = true
                    return
               }
                   
                self.newPosts = Array(posts[...3])
            }
        }
        .alert(isPresented: $showInternetAlert) {
            Alert(title: Text("Something went wrong..."), message: Text("Something went wrong when talking to the MoBlog servers. Make sure you have a stable internet connection."), dismissButton: nil)
        }
        
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
            .environment(\.colorScheme, .dark)
    }
}
