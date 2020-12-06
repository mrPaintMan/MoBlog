//
//  SourceNotificationButton.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-11-29.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import SwiftUI
import CoreData

struct SourceNotificationButton: View {
    @EnvironmentObject var followingInfo: FollowingInfo
    var viewContext: NSManagedObjectContext
    
    var body: some View {
        MoBlogButton(width: 150, action: {
            followingInfo.notification.toggle()
            saveViewContext(viewContext)
            
        }, label: followingInfo.notification ? "Subscribed" : "Notifications")
        .buttonStyle(SourceButtonStyle())
        .background(followingInfo.notification ? Color.blue : Color.moBlogRed)
        .cornerRadius(10, corners: .topRight)
        .cornerRadius(10, corners: .bottomRight)
    }
}

struct SourceNotificationButton_Previews: PreviewProvider {
    static let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static var previews: some View {
        SourceNotificationButton(viewContext: viewContext)
    }
}
