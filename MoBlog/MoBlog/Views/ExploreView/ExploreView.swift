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
    @EnvironmentObject var sourceList: SourceList
    @Environment(\.managedObjectContext) var viewContext
    @State var showInternetAlert = false
    @State var showWebView = false
    @State var currentLink = ""
    @State var newPosts = [Post]()
    
    let alert = Alert(title: Text("Something went wrong..."), message: Text("Something went wrong when talking to the MoBlog servers. Make sure you have a stable internet connection."), dismissButton: nil)
    
    init(){
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        
        MoBlogView {
            VStack {
                
                // MARK: Title
                
                ExploreTitle()
                Divider()
                
                // MARK: Featured
                
                Section(label: "Featured") {
                    ScrollView(.horizontal, showsIndicators: false, content: {
                        HStack(spacing: 10) {
                            ForEach(self.featuredPosts) { post in
                                ExploreFeaturedPost(text: post.title)
                                .onTapGesture {
                                    self.currentLink = post.link
                                    self.showWebView = true
                                }
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
                        .onTapGesture {
                            self.currentLink = post.link
                            self.showWebView = true
                        }
                    }
                    .frame(height: (CGFloat(self.newPosts.count) * 44))
                }
                Divider()
                
                Spacer()
            }
        }
        .sheet(isPresented: $showWebView) { WebView(url: self.$currentLink) }
        .alert(isPresented: $showInternetAlert) { self.alert }
        .onAppear { loadNewPosts() }
    }
    
    func loadNewPosts() {
        if self.newPosts.isEmpty {
            guard let posts: [Post] = PostRequest(page: 0, sourceCodes: nil).response?.data else {
                self.showInternetAlert = true
                return
           }
               
            self.newPosts = Array(posts[...3])
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
            .environment(\.colorScheme, .dark)
    }
}
