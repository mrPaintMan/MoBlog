//
//  Post.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-04-16.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import Foundation
import SwiftUI

struct Post: Codable, Identifiable {
    var id: Int
    var extId: String
    var title: String
    var link: String
    var source: String
    var created: Double
    
    var color: Color
    
    enum CodingKeys: String, CodingKey {
        case id = "post_id"
        case extId = "ext_id"
        case title
        case link
        case source = "source_code"
        case created
    }
    
    
    init(from decoder: Decoder) throws {
        let colors: [Color] = [
            Color.init(.systemBlue),
            Color.init(.systemRed),
            Color.init(.systemGreen),
            Color.init(.systemOrange),
            Color.init(.systemYellow)
        ]
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        extId = try values.decode(String.self, forKey: .extId)
        title = try values.decode(String.self, forKey: .title)
        link = try values.decode(String.self, forKey: .link)
        source = try values.decode(String.self, forKey: .source)
        created = try values.decode(Double.self, forKey: .created)
        
        let i = Int.random(in: 0...4)
        color = colors[i]
    }
}


let PostData: [Post] = load("PostData.json")


func load<T: Decodable>(_ fileName: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: fileName, withExtension: nil)
        else {
            fatalError("Couldn't find \(fileName) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(fileName) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(fileName) as \(T.self):\n\(error)")
    }
}
