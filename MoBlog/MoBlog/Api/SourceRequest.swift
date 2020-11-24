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
            guard let imageUrl = URL(string: source.profileImageLink) else { return }
            guard let altUrl = URL(string: source.altImageLink) else { return }
            
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                guard let data = data else { return }
                
                DispatchQueue.main.async {
                    source.profileImageData = data
                }
                
            }.resume()
            
            URLSession.shared.dataTask(with: altUrl) { data, response, error in
                guard let data = data else { return }
                
                DispatchQueue.main.async {
                    source.altImageData = data
                }
                
            }.resume()
        }
        
        return sources
    }
}
