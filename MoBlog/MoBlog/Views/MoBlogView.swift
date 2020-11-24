//
//  MoBlogView.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-11-01.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import SwiftUI

struct MoBlogView<view: View>: View {
    let buildView: () -> view
    var body: some View {
        NavigationView {
            ZStack {
                Color.init(.systemGray6)
                    .edgesIgnoringSafeArea(.all)
                
                buildView()
            }.navigationBarHidden(true)
        }
    }
}

struct MoBlogView_Previews: PreviewProvider {
    static var previews: some View {
        MoBlogView {
            Text("test")
        }
    }
}
