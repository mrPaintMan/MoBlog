//
//  ContentView.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-04-12.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 2
    
    var body: some View {
        ZStack {
            
            TabView(selection: $selection) {
                ExploreView()
                    .tabItem {
                        Image(systemName: "map.fill")
                        Text("Explore")
                    }
                    .tag(1)
                    
                HomeView()
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                    .tag(2)
                        
                SettingsView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                    .tag(3)
            }
            .accentColor(.moBlogRed)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       ContentView()
        .environment(\.colorScheme, .dark)
    }
}
