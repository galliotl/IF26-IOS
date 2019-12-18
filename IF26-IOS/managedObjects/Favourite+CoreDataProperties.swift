//
//  Favourite+CoreDataProperties.swift
//  IF26-IOS
//
//  Created by Laura Haegel on 18/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//
//

import Foundation
import CoreData


extension Favourite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favourite> {
        return NSFetchRequest<Favourite>(entityName: "Favourite")
    }

    @NSManaged public var fid: UUID?
    @NSManaged public var mid: Music?
    @NSManaged public var uid: User?

}
