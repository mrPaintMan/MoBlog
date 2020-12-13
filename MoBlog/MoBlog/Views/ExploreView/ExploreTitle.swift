//
//  ExploreTitle.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-12-13.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import SwiftUI

struct ExploreTitle: View {
    @EnvironmentObject var sourceList: SourceList
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        HStack {
            
            Spacer()
            Spacer()
            
            Text("Explore")
                .font(.largeTitle)
                .bold()
                .padding(.vertical ,20)
                .padding(.leading, 10)
            
            Spacer()
            
            NavigationLink(
                destination: SearchView(viewContext: viewContext, sourceList: sourceList),
                label: {
                    Image(systemName: "magnifyingglass").accentColor(.moBlogRed).font(.title2)
                })
                .padding()
                .padding(.trailing)
        }
    }
}

struct ExploreTitle_Previews: PreviewProvider {
    static var previews: some View {
        ExploreTitle()
    }
}
