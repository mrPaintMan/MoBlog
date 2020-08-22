//
//  SourceRequest.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-08-21.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import Foundation
import SwiftUI

struct SourceResponse: Decodable {
    let status: String
    var data: [Source]
}

class SourceRequest {
    let page: Int
    let resource: String
    var response: SourceResponse?

    init(page: Int) {
        self.page = page
        resource = "sources"
        
        let params = "?page=" + String(page)
        let semaphore = DispatchSemaphore(value: 0)
        let moBlogResuest = MoBlogRequest(resource: self.resource, params: params)
        
        moBlogResuest.getData { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                
            case .success(let data):
                self?.response = parseData(data)
                let dataWithImages = self?.getImageData(sources: self?.response?.data ?? [Source]()) ?? [Source]()
                self?.response?.data = dataWithImages
            }
            
            semaphore.signal()
        }
        
        semaphore.wait()
    }
    
    func getImageData(sources: [Source]) -> [Source] {
        sources.forEach { source in
            guard let url = URL(string: source.profileImageLink) else { return }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                guard let image = UIImage(data: data) else {
                    print("Could not create image from resource: " + source.profileImageLink)
                    return
                    
                }
                
                DispatchQueue.main.async {
                    source.profileImage = Image(uiImage: image)
                }
                
            }.resume()
        }
        
        return sources
    }
}
