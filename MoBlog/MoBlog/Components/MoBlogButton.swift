//
//  HomeButton.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-08-22.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import SwiftUI

struct GradientButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(5)
            .foregroundColor(Color.white)
            .background(Color(.black).opacity(configuration.isPressed ? 0.2 : 0))
            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .animation(.easeIn(duration: 0.05))
    }
}

struct SourceButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
            .background(Color(.black).opacity(configuration.isPressed ? 0.2 : 0))
            .animation(.easeIn(duration: 0.05))
    }
}

struct MoBlogButton: View {
    var width: Double
    var height: Double = 40
    var action: () -> Void
    var label: String
    var body: some View {
        Button(action: action, label: {
            ZStack {
                Rectangle()
                    .foregroundColor(Color.white.opacity(0))
                    .frame(width: CGFloat(width), height: CGFloat(height))
                    .background(Color.blue.opacity(0.0000001))
                Text(label)
            }
        })
    }
}

struct MoBlogButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            MoBlogButton(width: 150, action: {
                print("hey")
            }, label: "Hello World")
            .buttonStyle(GradientButtonStyle())
            
            MoBlogButton(width: 170, action: {
                print("hey")
            }, label: "Hello World")
            .buttonStyle(SourceButtonStyle())
            .background(Color.moBlogRed)
        }
        
    }
}
