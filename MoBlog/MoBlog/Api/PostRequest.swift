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
    var status: String
    var data: [Post]
}

class PostRequest {
    let page: Int
    let sourceCode: String?
    let resource: String
    var response: PostResponse?
    
    init(page: Int, sourceCode: String?) {
        self.page = page
        self.sourceCode = sourceCode
        self.resource = "posts"
        var params: String
        
        if (sourceCode != nil) {
            params = "?page=\(page)&source=\(sourceCode!)"
        } else {
            params = "?page=\(page)"
        }
        let semaphore = DispatchSemaphore(value: 0)
        let moBlogResuest = MoBlogRequest(resource: self.resource, params: params)
        
        moBlogResuest.getData { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                
            case .success(let data):
                self?.response = self?.parseData(data: data)
            }
            
            semaphore.signal()
        }
        
        semaphore.wait()
    }
    
    func parseData(data: Data) -> PostResponse {
        let decoder = JSONDecoder()
        
        do {
            let parsedResult = try decoder.decode(PostResponse.self, from: data)
            let realResponse = PostResponse(status: parsedResult.status, data: getImageData(posts: parsedResult.data))
            
            return realResponse
        } catch {
            fatalError()
        }
    }
    
    func getImageData(posts: [Post]) -> [Post] {
        posts.forEach { post in
            guard let url = URL(string: post.imageLink) else { return }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                guard let image = UIImage(data: data) else {
                    print("Could not create image from resource: " + post.imageLink)
                    return
                    
                }
                
                DispatchQueue.main.async {
                    post.image = Image(uiImage: image)
                }
                
            }.resume()
        }
        
        return posts
    }
}
