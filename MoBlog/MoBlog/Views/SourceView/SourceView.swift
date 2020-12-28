//
//  SourceView.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-10-31.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import SwiftUI
import CoreData

struct SourceView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var source: Source
    @ObservedObject var postList = PostList()
    @State var pageIndex = 0
    @State var showWebView = false
    @State var showLoadButton = true
    @State var currentLink = ""
    @State var followingInfo: FollowingInfo?
    var viewContext: NSManagedObjectContext
    
    var body: some View {
        MoBlogView {
            ScrollView {
                VStack {
                    SourcePresentation(source: source, viewContext: viewContext, dismissFunc: {self.presentationMode.wrappedValue.dismiss()}).environmentObject(followingInfo ?? FollowingInfo(context: viewContext))
                    
                    
                    if self.postList.posts.count > 0 {
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
                    }
                    
                    if self.showLoadButton {
                        MoBlogButton(width: 125, action: {
                            self.loadMorePosts()
                        }, label: "Load more!")
                        .buttonStyle(GradientButtonStyle())
                        .padding(.bottom)
                    }
                    
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.top)
            .sheet(isPresented: $showWebView, content: {
                WebView(url: self.$currentLink)
            })
        }
        .navigationBarHidden(true)
        .onAppear {
            fetchData()
        }
    }
    
    func fetchData() {
        let request = FollowingInfo.fetchRequest() as NSFetchRequest<FollowingInfo>
        
        let pred = NSPredicate(format: "sourceCode == %@", self.source.sourceCode)
        request.predicate = pred
        
        do {
            let result = try viewContext.fetch(request)
            
            // Our Source exists in CoreData
            if result.count == 1 {
                self.followingInfo = result[0]
            }
            
            // Our Source does not exist in CoreData
            else if result.count == 0 {
                let followingInfo = FollowingInfo(context: viewContext)
                followingInfo.following = false
                followingInfo.notification = false
                followingInfo.sourceCode = source.sourceCode
                
                self.followingInfo = followingInfo
                
               saveViewContext(viewContext)
            }
            
            else {
                fatalError("Found multiple entries in CoreData for: " + source.sourceCode)
            }
        }
        
        catch {
            fatalError("Error for sourceCode: \(source.sourceCode), error : \(error)")
        }
        
        
        DispatchQueue.main.async {
            guard let posts: [Post] = PostRequest(page: self.pageIndex, sourceCodes: [self.source.sourceCode]).response?.data else {
                
                return
            }
            
            self.postList.posts = posts
        }
    }
    
    func loadMorePosts() -> Void {
        self.pageIndex += 1
        
        guard let posts: [Post] = PostRequest(page: self.pageIndex, sourceCodes: [self.source.sourceCode]).response?.data else {
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
        SourceView(source: SourceData[4], viewContext: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    }
}
