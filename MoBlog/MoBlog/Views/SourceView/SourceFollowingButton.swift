//
//  SourceFollowingButton.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-11-28.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import SwiftUI
import CoreData

struct SourceFollowingButton: View {
    @EnvironmentObject var followingInfo: FollowingInfo
    @Binding var shouldReloadPostList: Bool
    var viewContext: NSManagedObjectContext
    
    var body: some View {
        MoBlogButton(width: 150, action: {
            followingInfo.following.toggle() 
            saveViewContext(viewContext)
            shouldReloadPostList.toggle()
            
        }, label: followingInfo.following ? "Following" : "Follow")
        .buttonStyle(SourceButtonStyle())
        .background(followingInfo.following ? Color.blue : Color.moBlogRed)
        .cornerRadius(10, corners: .topLeft)
        .cornerRadius(10, corners: .bottomLeft)
    }
}

struct SourceFollowingButton_Previews: PreviewProvider {
    static let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static var previews: some View {
        SourceFollowingButton(shouldReloadPostList: .constant(false), viewContext: viewContext)
    }
}
