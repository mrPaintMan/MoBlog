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
    @Environment(\.managedObjectContext) var viewContext
    @State var pageIndex = 0
    @State var showInternetAlert = false
    @State var showWebView = false
    @State var showLoadButton = true
    @State var currentLink = ""
    
    var body: some View {
        
        // MARK: No blogs to show
        
        if postList.posts.isEmpty {
            MoBlogView {
                VStack {
                    Text("MoBlog").font(.largeTitle)
                    
                    Spacer()
                    
                    Text("You are not following any blogs. Head over to the Explore page to find interesting blogs!")
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .foregroundColor(Color(.darkGray))
                        .padding(.horizontal, 40)
                    
                    Spacer()
                }
            }
        }
        
        // MARK: Blogs to show
        
        else {
            MoBlogView {
                ScrollView {
                    VStack {
                        HomeTitle(refreshFunc: {
                            postList.posts = updateFollowingPosts(viewContext: viewContext)
                            
                        }).transition(.slide)
                        
                        ForEach(postList.posts, content: { post in
                            HomePost(post: post)
                                .padding(5)
                                .onTapGesture {
                                    self.currentLink = post.link
                                    self.showWebView = true
                            }
                        })
                        
                        if self.showLoadButton {
                            MoBlogButton(width: 125, action: {
                                self.loadMorePosts()
                            }, label: "Load more!")
                                .buttonStyle(GradientButtonStyle())
                                .padding(.bottom)
                        }
                    }.sheet(isPresented: $showWebView, content: {
                        WebView(url: self.$currentLink)
                    })
                }
            }.transition(.move(edge: .top))
            .animation(.default)
            .alert(isPresented: $showInternetAlert) {
                Alert(title: Text("Something went wrong..."), message: Text("Something went wrong when talking to the MoBlog servers. Make sure you have a stable internet connection."), dismissButton: nil)
            }
        }
    }
    
    func loadMorePosts() -> Void {
        let followingList = getFollowingList(viewContext: self.viewContext)
        let sourceCodes = followingList.isEmpty ? nil : followingList
        self.pageIndex += 1
        
        guard let posts: [Post] = PostRequest(page: self.pageIndex, sourceCodes: sourceCodes).response?.data else {
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
