//
//  Post.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-04-16.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import Foundation
import SwiftUI

let PostData: [Post] = loadLocalData("PostData.json")

class Post: Codable, Identifiable, ObservableObject {
    var id: Int
    var extId: String
    var title: String
    var link: String
    var imageLink: String
    var altImageLink: String?
    var source: String
    var created: Double
    
    @Published var image = Image("loading")
    
    enum CodingKeys: String, CodingKey {
        case id = "post_id"
        case extId = "ext_id"
        case title
        case link
        case imageLink = "image"
        case altImageLink = "alt_image"
        case source = "source_code"
        case created
    }
    
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        extId = try values.decode(String.self, forKey: .extId)
        title = try values.decode(String.self, forKey: .title)
        link = try values.decode(String.self, forKey: .link)
        imageLink = try values.decode(String.self, forKey: .imageLink)
        altImageLink = try values.decodeIfPresent(String.self, forKey: .altImageLink)
        source = try values.decode(String.self, forKey: .source)
        created = try values.decode(Double.self, forKey: .created)
    }
}
