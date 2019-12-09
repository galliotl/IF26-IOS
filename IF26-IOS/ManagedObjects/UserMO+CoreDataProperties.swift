//
//  UserMO+CoreDataProperties.swift
//  IF26-IOS
//
//  Created by Laura Haegel on 09/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//
//

import Foundation
import CoreData


extension UserMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserMO> {
        return NSFetchRequest<UserMO>(entityName: "User")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var password: String?
    @NSManaged public var picPath: String?
    @NSManaged public var uid: String?
    @NSManaged public var fav: FavouriteMO?
    @NSManaged public var music: MusicMO?

}
