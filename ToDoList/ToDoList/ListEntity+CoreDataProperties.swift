//
//  ListEntity+CoreDataProperties.swift
//  ToDoList
//
//  Created by Nguyễn Thịnh Tiến on 2/23/17.
//  Copyright © 2017 TienNguyen. All rights reserved.
//

import Foundation
import CoreData


extension ListEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ListEntity> {
        return NSFetchRequest<ListEntity>(entityName: "ListEntity");
    }

    @NSManaged public var name: String?
    @NSManaged public var createdAt: NSDate?

}
