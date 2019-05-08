//
//  Employee+CoreDataProperties.swift
//  CoreStoreUpdate
//
//  Created by Alex Matrosov on 5/8/19.
//  Copyright © 2019 Alex Matrosov. All rights reserved.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var company: Company?

}
