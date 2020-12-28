//
//  CoreDataApi.swift
//  MoBlog
//
//  Created by Filip Palmqvist on 2020-12-06.
//  Copyright © 2020 Filip Palmqvist. All rights reserved.
//

import Foundation
import CoreData

func getCoreData<T: NSManagedObject>(viewContext: NSManagedObjectContext) -> [T] {
    do {
        let result = try viewContext.fetch(T.fetchRequest()) as! [T]
        return result
    }
    catch {
        fatalError("Something went wrong with fetching data from CoreData in getCoreData(): \(error)")
    }
}

func getFollowingList(viewContext: NSManagedObjectContext) -> [String] {
    let result: [FollowingInfo] = getCoreData(viewContext: viewContext)
    
    return result.filter({ $0.following }).map({ $0.sourceCode! })
}

func updateFollowingPosts(viewContext: NSManagedObjectContext) -> [Post] {
    let followingList = getFollowingList(viewContext: viewContext)
   
    // Only fetch data if at least one source is being followed.
    if !followingList.isEmpty {
        guard let posts = PostRequest(page: 0, sourceCodes: followingList).response?.data else {
               return []
           }
              
        return posts
    }
    
    else {
        return []
    }
}

func getNotificationsList(viewContext: NSManagedObjectContext) -> [String] {
    let result: [FollowingInfo] = getCoreData(viewContext: viewContext)
    
    return result.filter({ $0.notification }).map({ $0.sourceCode! })
}

func getDeviceToken(viewContext: NSManagedObjectContext) -> String? {
    let result: [DeviceToken] = getCoreData(viewContext: viewContext)
    
    return result.isEmpty ? nil : result[0].hexToken
}

func saveDeviceToken(_ token: String, viewContext: NSManagedObjectContext) {
    let result: [DeviceToken] = getCoreData(viewContext: viewContext)
        
    if result.isEmpty {
        let newDeviceToken = DeviceToken(context: viewContext)
        newDeviceToken.hexToken = token
        saveViewContext(viewContext)
    }
    
    else if result.count == 1 {
        let oldDeviceToken = result[0]
        
        if oldDeviceToken.hexToken != token {
            oldDeviceToken.hexToken = token
            saveViewContext(viewContext)
        }
    }
    
    else {
        fatalError("Found multiple devicetokens in coreData")
    }
}

func saveViewContext(_ viewContext: NSManagedObjectContext) {
    do {
        try viewContext.save()
    }
    
    catch {
        fatalError("Could not save viewContext... \(error)")
    }
}
