//
//  SettingsView.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-04-18.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        ZStack {
            Color.init(.systemGray6)
                .edgesIgnoringSafeArea(.all)
            
            HStack {
                Text("Subscriptions")
                    .font(.title)
                    .bold()
                
                Spacer()
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
