//
//  HomeView.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-04-16.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var postList: PostList
    @State var pageIndex = 0
    @State var showInternetAlert = false
    @State var showWebView = false
    @State var showLoadButton = true
    @State var currentLink = ""
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            Color.init(.systemGray6)
                .edgesIgnoringSafeArea(.all)

                    
            ScrollView {
                
                VStack {

                    Text("MoBlog")
                        .font(.largeTitle)

                    ForEach(postList.posts, content: { post in
                        HomePost(post: post)
                            .padding(.horizontal, 5)
                        .onTapGesture {
                            self.currentLink = post.link
                            self.showWebView = true
                        }
                    })
                    
                    if self.showLoadButton {
                        HomeButton(action: {
                            self.loadMorePosts()
                        }, label: "Load more!")
                            .padding(.bottom, 20)
                            .padding(.top, 10)
                    }
                }
                .sheet(isPresented: $showWebView, content: {
                    WebView(url: self.currentLink)
                })
            }
        }
        .alert(isPresented: $showInternetAlert) {
            Alert(title: Text("Something went wrong..."), message: Text("Something went wrong when talking to the MoBlog servers. Make sure you have a stable internet connection."), dismissButton: nil)
        }
    }
    
    func loadMorePosts() -> Void {
        self.pageIndex += 1
        
        guard let posts: [Post] = PostRequest(page: self.pageIndex, sourceCode: nil).response?.data else {
            self.showInternetAlert = true
            return
        }
        
        if posts.isEmpty {
            self.showLoadButton = false
        }
        else {
            self.postList.posts += posts
        }
        
        print("posts.count = \(self.postList.posts.count) number of posts")
    }
}

struct HomeView_Previews: PreviewProvider {
    
    static var previews: some View {
        HomeView()
            .environment(\.colorScheme, .dark)
            .environmentObject(PostList(posts: PostData))
            .environmentObject(SourceList(sources: SourceData))
    }
}
