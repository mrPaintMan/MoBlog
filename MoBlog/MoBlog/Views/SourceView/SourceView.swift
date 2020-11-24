//
//  SourceView.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-10-31.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import SwiftUI

struct SourceView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var source: Source
    @ObservedObject var postList = PostList()
    @State var pageIndex = 0
    @State var showWebView = false
    @State var showLoadButton = true
    @State var currentLink = ""
    
    init(source: Source) {
        self.source = source
        
        guard let posts: [Post] = PostRequest(page: self.pageIndex, sourceCode: self.source.sourceCode).response?.data else {
            
            return
        }
        
        self.postList.posts = posts
    }
    
    var body: some View {
        MoBlogView {
            ScrollView {
                VStack {
                    SourcePresentation(source: source, dismissFunc: {self.presentationMode.wrappedValue.dismiss()})
                    
                    ForEach(1..<postList.posts.count, id: \.self) { i in
                        if i % 2 == 1 {
                            HStack {
                                SourcePost(post: postList.posts[i - 1])
                                    .onTapGesture {
                                        self.currentLink = postList.posts[i - 1].link
                                        self.showWebView = true
                                    }
                                
                                SourcePost(post: postList.posts[i])
                                    .onTapGesture {
                                        self.currentLink = postList.posts[i].link
                                        self.showWebView = true
                                    }
                            }
                        }
                        
                        else if i == postList.posts.count - 1 {
                            SourcePost(post: postList.posts[i])
                                .onTapGesture {
                                    self.currentLink = postList.posts[i].link
                                    self.showWebView = true
                                }
                        }
                        
                    }
                    
                    if self.showLoadButton {
                        MoBlogButton(action: {
                            self.loadMorePosts()
                        }, label: "Load more!")
                            .buttonStyle(GradientButtonStyle())
                    }
                    
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.top)
            .sheet(isPresented: $showWebView, content: {
                WebView(url: self.currentLink)
            })
        }
        .navigationBarHidden(true)
    }
    
    func loadMorePosts() -> Void {
        self.pageIndex += 1
        
        guard let posts: [Post] = PostRequest(page: self.pageIndex, sourceCode: self.source.sourceCode).response?.data else {
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

struct SourceView_Previews: PreviewProvider {
    static var previews: some View {
        SourceView(source: SourceData[4])
    }
}
