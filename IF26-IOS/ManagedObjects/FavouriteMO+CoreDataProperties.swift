//
//  FavouriteMO+CoreDataProperties.swift
//  IF26-IOS
//
//  Created by Laura Haegel on 12/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//
//

import Foundation
import CoreData


extension FavouriteMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteMO> {
        return NSFetchRequest<FavouriteMO>(entityName: "Favourite")
    }

    @NSManaged public var fid: String?
    @NSManaged public var mid: MusicMO?
    @NSManaged public var uid: UserMO?

}
