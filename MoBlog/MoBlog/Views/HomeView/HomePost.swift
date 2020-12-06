//
//  HomePost.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-04-18.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import SwiftUI

struct HomePost: View {
    @EnvironmentObject var sourceList: SourceList
    @Environment(\.managedObjectContext) var viewContext
    var age: String
    @ObservedObject var post: Post
    let postSize = CGSize(width: UIScreen.main.bounds.size.width - 20, height: 200)
    
    init(post: Post) {
        let unixAge = NSDate().timeIntervalSince1970 - post.created
        self.age = "\(Int(unixAge / (24 * 60 * 60))) days old"
        self.post = post
    }
    
    var body: some View {
        Rectangle()
            .frame(width: postSize.width, height: postSize.height, alignment: .center)
            .foregroundColor(.clear)
            .background(
                self.post.getImage(size: postSize)
                    .resizable()
                    .scaledToFill()
                    .frame(alignment: .center)
            )
            .overlay(
                    
                Rectangle()
                .foregroundColor(.clear)
                .background(
                    VStack {
                        Spacer()
                        
                        LinearGradient(gradient: Gradient(colors: [Color(.black).opacity(0), Color(.black)]), startPoint: .top, endPoint: .bottom)
                            .frame(height: 150)
                    }
                )
                .overlay(
                
                    VStack {
                        
                        HStack {
                            NavigationLink(
                                destination: SourceView(source: getSource(), viewContext: viewContext),
                                label: {
                                    ProfileImage(source: getSource(), width: 50, height: 50)
                                        .padding(5)
                                })
                            
                            Spacer()
                        }
                        
                        Spacer()
                        
                        Text(post.title)
                            .font(.system(size: 20))
                            .bold()
                            .padding(.horizontal, 10)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            
                        HStack {
                            
                            Spacer()

                            Text(age)
                                .font(.system(size: 15))
                                .padding(5)
                                .padding(.leading, 5)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(5)
                )
            )
            .cornerRadius(10)
    }
    
    fileprivate func getSource() -> Source {
        guard let source = sourceList.sources.first(where: { $0.sourceCode == self.post.source}) else {
            fatalError()
        }
        
        return source
    }
}

struct HomePost_Previews: PreviewProvider {
    static var previews: some View {
        HomePost(post: PostData[0])
            .environmentObject(SourceList(sources: SourceData))
    }
}
