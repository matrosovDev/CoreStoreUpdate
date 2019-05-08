//
//  Company+CoreDataProperties.swift
//  CoreStoreUpdate
//
//  Created by Alex Matrosov on 5/8/19.
//  Copyright © 2019 Alex Matrosov. All rights reserved.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var employees: NSSet?

}

// MARK: Generated accessors for employees
extension Company {

    @objc(addEmployeesObject:)
    @NSManaged public func addToEmployees(_ value: Employee)

    @objc(removeEmployeesObject:)
    @NSManaged public func removeFromEmployees(_ value: Employee)

    @objc(addEmployees:)
    @NSManaged public func addToEmployees(_ values: NSSet)

    @objc(removeEmployees:)
    @NSManaged public func removeFromEmployees(_ values: NSSet)

}
