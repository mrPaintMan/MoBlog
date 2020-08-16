//
//  HomeView.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-04-16.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @State var pageIndex = 0
    @State var showInternetAlert = false
    @State var showWebView = false
    @State var currentLink = ""
    @State var posts = [Post]()
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            Color.init(.systemGray6)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("MoBlog")
                    .font(.largeTitle)
                    
                
                List(posts) { post in
                    HomePost(post: post)
                    .onTapGesture {
                        self.currentLink = post.link
                        self.showWebView = true
                    }
                    .onAppear {
                        if self.posts.last?.id == post.id {
                            self.pageIndex += 1
                            guard let posts: [Post] = PostRequest(page: self.pageIndex, sourceCode: nil).response?.data else {
                                self.showInternetAlert = true
                                return
                            }

                            self.posts += posts
                            print("fetched \(posts.count) number of posts")
                            print("posts.count = \(self.posts.count) number of posts")
                        }
                    }
                }
                .sheet(isPresented: $showWebView, content: {
                    WebView(url: self.currentLink)
                })
            }
        }
        .onAppear {
            if self.posts.isEmpty {
                guard let posts: [Post] = PostRequest(page: self.pageIndex, sourceCode: nil).response?.data else {
                    self.showInternetAlert = true
                           return
                       }
                       
                    self.posts = posts
                    print("fetched \(posts.count) number of posts")
            }
        }
        .alert(isPresented: $showInternetAlert) {
            Alert(title: Text("Something went wrong..."), message: Text("Something went wrong when talking to the MoBlog servers. Make sure you have a stable internet connection."), dismissButton: nil)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(\.colorScheme, .dark)
    }
}
