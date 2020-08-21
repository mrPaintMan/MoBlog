//
//  PostList.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-08-19.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import Foundation

class PostList: ObservableObject {
    @Published var posts = [Post]()
    
    init() {
        
    }
    
    init(posts: [Post]) {
        self.posts = posts
    }
}
