//
//  Tag.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-04-19.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import SwiftUI

struct Tag: View {
    var label: String
    var color: Color
    var textColor: Color = .black
    var body: some View {
        Text(label)
            .foregroundColor(textColor)
            .padding(2)
            .padding(.horizontal, 15)
            .background(color)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white, lineWidth: 1)
            )
    }
}

struct Tag_Previews: PreviewProvider {
    static var previews: some View {
        Tag(label: "hello", color: .blue)
    }
}
