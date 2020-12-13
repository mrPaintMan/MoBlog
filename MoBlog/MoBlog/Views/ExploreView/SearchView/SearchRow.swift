//
//  SearchRow.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-12-13.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import SwiftUI
import CoreData

struct SearchRow: View {
    @State var subText: String = ""
    var source: Source
    var viewContext: NSManagedObjectContext
    
    var body: some View {
        NavigationLink(
            destination: SourceView(source: source, viewContext: viewContext),
            label: {
                ProfileImage(source: source, width: 50, height: 50)
                    .padding(.trailing)
                if !subText.isEmpty {
                    VStack(alignment: .leading){
                        Text(source.name).font(.title2).foregroundColor(.systemBlack)
                        Text(subText).foregroundColor(.gray).font(.system(size: 14))
                    }
                }
                
                else {
                    Text(source.name).font(.title2)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.accentColor)
            })
            .onAppear(perform: { getSubText() })
    }
    
    func getSubText() {
        let following = getFollowingList(viewContext: viewContext).contains(source.sourceCode)
        let notifications = getNotificationsList(viewContext: viewContext).contains(source.sourceCode)
        
        if following {
            self.subText = "Following"
            
            if notifications {
                self.subText += " | Notifications"
            }
        }
        
        else if notifications {
            self.subText = "Notifications"
        }
        
        else {
            self.subText = ""
        }
    }
}

struct SearchRow_Previews: PreviewProvider {
    static var previews: some View {
        SearchRow(source: SourceData[0], viewContext: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext).border(Color.black)
    }
}
