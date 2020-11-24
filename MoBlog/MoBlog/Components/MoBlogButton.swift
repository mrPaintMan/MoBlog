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
            .padding(.horizontal)
            .padding()
            .foregroundColor(Color.white)
            .background(Color(.black).opacity(configuration.isPressed ? 0.2 : 0))
            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .animation(.easeIn(duration: 0.05))
            .padding(.bottom, 20)
            .padding(.top, 10)
    }
}

struct SourceButtonStyle: ButtonStyle {
    private let width = UIScreen.main.bounds.size.width / 2 - 75
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .frame(width: width)
            .padding(15)
            .foregroundColor(Color.white)
            .background(Color(.black).opacity(configuration.isPressed ? 0.2 : 0))
            .background(Color.moBlogRed)
            .animation(.easeIn(duration: 0.05))
    }
}

struct MoBlogButton: View {
    var action: () -> Void
    var label: String
    var body: some View {
        Button(action: action, label: { Text(label) })
    }
}

struct MoBlogButton_Previews: PreviewProvider {
    static var previews: some View {
        MoBlogButton(action: {
            print("hey")
        }, label: "Hello World")
        .buttonStyle(GradientButtonStyle())
    }
}
