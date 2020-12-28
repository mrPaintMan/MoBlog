//
//  HomeTitle.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-12-28.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import SwiftUI

struct HomeTitle: View {
    @State var isLoading = false
    let refreshFunc: () -> Void
    
    var body: some View {
        VStack {
            if isLoading {
                ProgressView()
                    .transition(.move(edge: .top))
                    .animation(.default)
                    .padding()
            }
            
            HStack {
                Spacer()
                
                Spacer()
                
                Text("MoBlog").font(.largeTitle)
                
                Spacer()
                
                Button(action: {
                    isLoading = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        refreshFunc()
                        isLoading = false
                    }
                    
                }, label: {
                    Image(systemName: "arrow.clockwise")
                        .accentColor(.moBlogRed)
                        .font(.title2)
                        .padding(.trailing, 40)
                })
            }.transition(.move(edge: .top))
            .animation(.default)
        }.transition(.move(edge: .top))
        .animation(.default)
    }
}

struct HomeTitle_Previews: PreviewProvider {
    static var previews: some View {
        HomeTitle(refreshFunc: { print("hej") })
    }
}
