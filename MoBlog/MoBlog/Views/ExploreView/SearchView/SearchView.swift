//
//  ExploreSearchView.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-12-12.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import SwiftUI
import CoreData

struct SearchView: View {
    var viewContext: NSManagedObjectContext
    @ObservedObject var sourceList: SourceList
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var searchString = ""
    @State var isEditing = false
    
    var body: some View {
        MoBlogView {
            VStack {
                
                // MARK: Search bar
                
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left").font(.title2)
                    })
                    .padding(.leading, 20)
                    
                    SearchBar(text: $searchString)
                }.padding(.vertical)
                
                // MARK: Search result
                
                ForEach(self.sourceList.sources
                    .sorted { $0.name < $1.name }
                    .filter({
                        searchString.isEmpty ||
                        $0.name.localizedStandardContains(searchString)
                })) { source in
                    SearchRow(source: source, viewContext: viewContext)
                        .padding(5)
                        .padding(.horizontal, 20)
                }
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewContext: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext, sourceList: SourceList(sources: SourceData))
    }
}
