//
//  User+CoreDataClass.swift
//  IF26-IOS
//
//  Created by Laura Haegel on 25/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {

    func hasFaved(music: Music) -> Bool {
        
        guard favs != nil else {
            return false
        }
        
        return favs!.contains { fav in
            // true if a fav has the given music as a param
            return (fav as! Favourite).containsMusic(music: music)
        }
        
    }
    
}
