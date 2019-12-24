//
//  UUIDToStringPolicy.swift
//  IF26-IOS
//
//  Created by Laura Haegel on 23/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//

import CoreData

@objc
open class UUIDToStringPolicy: NSEntityMigrationPolicy {
    
    @objc
    open func uuidToString(id: NSUUID) -> NSString {
        return NSString(string: id.uuidString)
    }
    
}
