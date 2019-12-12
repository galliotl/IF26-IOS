//
//  MusicMO+CoreDataProperties.swift
//  IF26-IOS
//
//  Created by Laura Haegel on 12/12/2019.
//  Copyright © 2019 if26. All rights reserved.
//
//

import Foundation
import CoreData


extension MusicMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MusicMO> {
        return NSFetchRequest<MusicMO>(entityName: "Music")
    }

    @NSManaged public var id: Int16
    @NSManaged public var path: String?
    @NSManaged public var picPath: String?
    @NSManaged public var title: String?
    @NSManaged public var artistId: UserMO?
    @NSManaged public var fav: FavouriteMO?

}
