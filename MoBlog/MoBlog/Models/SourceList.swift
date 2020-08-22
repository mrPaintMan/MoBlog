//
//  SourceList.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-08-21.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import Foundation

class SourceList: ObservableObject {
    @Published var sources = [Source]()
    
    init() {
        
    }
    
    init(sources: [Source]) {
        self.sources = sources
    }
}
