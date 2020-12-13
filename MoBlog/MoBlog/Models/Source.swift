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

class Source: Codable, Identifiable, ObservableObject {
    var sourceCode: String
    var name: String
    var description: String
    var profileImageLink: String
    var altImageLink: String
    var created: Double
    
    @Published var profileImageData = Data()
    @Published var altImageData = Data()
    
    enum CodingKeys: String, CodingKey {
        case sourceCode = "source_code"
        case name
        case description
        case profileImageLink = "profile_image"
        case altImageLink = "alt_image"
        case created
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sourceCode = try values.decode(String.self, forKey: .sourceCode)
        name = try values.decode(String.self, forKey: .name)
        description = try values.decode(String.self, forKey: .description)
        profileImageLink = try values.decode(String.self, forKey: .profileImageLink)
        altImageLink = try values.decode(String.self, forKey: .altImageLink)
        created = try values.decode(Double.self, forKey: .created)
    }
    
    func getImage(size: CGSize, alternative: Bool = false) -> Image {
        let imageData = alternative ? self.altImageData : self.profileImageData
        let imageLink = (alternative ? self.altImageLink : self.profileImageLink)
        
        if imageData.isEmpty {
            return Image("loading")
        }
        
        else {
            do {
                let uiimage = try UIImage().downsample(imageData: imageData, to: size, scale: 1)
                
                return Image(uiImage: uiimage)
            }
            catch {
                fatalError("Could not downsample image with url: \(imageLink)")
            }
        }
    }
}
