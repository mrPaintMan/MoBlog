//
//  PostRequest.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-06-28.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import Foundation
import SwiftUI

struct PostResponse: Decodable {
    let status: String
    var data: [Post]
}

class PostRequest {
    let page: Int
    let sourceCodes: [String]?
    let resource: String
    var response: PostResponse?
    
    init(page: Int, sourceCodes: [String]?) {
        self.page = page
        self.sourceCodes = sourceCodes
        self.resource = "posts"
        let params = "?page=\(page)" + (sourceCodes != nil ? "&source=\(sourceCodes!.joined(separator: ","))" : "")
        
        let semaphore = DispatchSemaphore(value: 0)
        let moBlogResuest = MoBlogRequest(resource: self.resource, params: params)
        
        moBlogResuest.getData { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                
            case .success(let data):
                self?.response = parseData(data)
                let dataWithImages = self?.getImageData(posts: self?.response?.data ?? [Post]()) ?? [Post]()
                self?.response?.data = dataWithImages
            }
            
            semaphore.signal()
        }
        
        semaphore.wait()
    }
    
    func getImageData(posts: [Post]) -> [Post] {
        posts.forEach { post in
            guard let url = URL(string: post.imageLink) else { return }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                
                DispatchQueue.main.async {
                    post.imageData = data
                }
                
            }.resume()
        }
        
        return posts
    }
}
