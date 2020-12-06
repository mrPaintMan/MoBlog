//
//  CoreDataApi.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-12-06.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import Foundation
import CoreData

func getFollowingInfo(viewContext: NSManagedObjectContext) -> [FollowingInfo] {
    do {
        let result = try viewContext.fetch(FollowingInfo.fetchRequest()) as [FollowingInfo]
        return result
    }
    catch {
        fatalError("Something went wrong with fetching FollowingInfo from CoreData in getFollowingList()")
    }
}

func getFollowingList(viewContext: NSManagedObjectContext) -> [String] {
    var sourceCodes: [String] = []
    let result = getFollowingInfo(viewContext: viewContext)
    
    result.forEach({ source in
        if source.following {
            sourceCodes.append(source.sourceCode!)
        }
    })
    
    return sourceCodes
}

func getNotificationsList(viewContext: NSManagedObjectContext) -> [String] {
    var sourceCodes: [String] = []
    let result = getFollowingInfo(viewContext: viewContext)
    
    result.forEach({ source in
        if source.notification {
            sourceCodes.append(source.sourceCode!)
        }
    })
    
    return sourceCodes
}

func saveViewContext(_ viewContext: NSManagedObjectContext) {
    do {
        try viewContext.save()
    }
    
    catch {
        fatalError("Could not save followingInfo... \(error)")
    }
}
