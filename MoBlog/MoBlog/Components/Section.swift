//
//  Section.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-04-18.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import SwiftUI

struct Section<Content: View>: View {
    var label: String
    var content: Content
    
    init(label: String, @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        self.label = label
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(label)
                    .font(.title)
                    .bold()
                    .padding(.bottom, -10)
                
                Spacer()
            }
            
            content
        }
    }
}

struct Section_Previews: PreviewProvider {
    static var previews: some View {
        Section(label: "Hello world") {
            ExploreFeaturedPost(text: "TJAA")
        }
    }
}
