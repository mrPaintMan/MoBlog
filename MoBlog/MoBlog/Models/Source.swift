//
//  Source.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-08-21.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import Foundation
import SwiftUI

let SourceData: [Source] = loadLocalData("SourceData.json")

class Source: Codable, ObservableObject {
    var sourceCode: String
    var description: String
    var profileImageLink: String
    var altImageLink: String?
    var created: Double
    
    @Published var profileImage = Image("loading")
    
    enum CodingKeys: String, CodingKey {
        case sourceCode = "source_code"
        case description
        case profileImageLink = "profile_image"
        case altImageLink = "alt_image"
        case created
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sourceCode = try values.decode(String.self, forKey: .sourceCode)
        description = try values.decode(String.self, forKey: .description)
        profileImageLink = try values.decode(String.self, forKey: .profileImageLink)
        altImageLink = try values.decodeIfPresent(String.self, forKey: .altImageLink)
        created = try values.decode(Double.self, forKey: .created)
    }
}
