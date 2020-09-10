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
            .foregroundColor(Color.white)
            .padding()
            .background(Color(.black).opacity(configuration.isPressed ? 0.2 : 0))
            .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .leading, endPoint: .trailing))
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .animation(.easeIn(duration: 0.05))
    }
}

struct HomeButton: View {
    var action: () -> Void
    var label: String
    var body: some View {
        Button(action: action, label: { Text(label) })
            .buttonStyle(GradientButtonStyle())
        
    }
}

struct HomeButton_Previews: PreviewProvider {
    static var previews: some View {
        HomeButton(action: {
            print("hey")
        }, label: "Hello World")
    }
}
