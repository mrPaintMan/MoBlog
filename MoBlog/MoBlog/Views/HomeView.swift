//
//  HomeView.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-04-16.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    init(){
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            Color.init(.systemGray6)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("MoBlog")
                    .font(.largeTitle)
                
                List(PostData) { post in
                    HomePost(post: post)
                }
                
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environment(\.colorScheme, .dark)
    }
}
