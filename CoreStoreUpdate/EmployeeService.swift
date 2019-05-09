//
//  EmployeeService.swift
//  CoreStoreUpdate
//
//  Created by Alex Matrosov on 5/8/19.
//  Copyright © 2019 Alex Matrosov. All rights reserved.
//

import Foundation
import CoreStore

class EmployeeService {
    
    func createEmployee(with name: String, completion: @escaping (Result<Employee, Error>) -> Void) {
        CoreStore.perform(
            asynchronous: { (transaction) -> Employee in
                let employee = transaction.create(Into<Employee>())
                let managed_object_id = employee.objectID.description // just for test!
                employee.id = managed_object_id
                employee.name = name
                return employee
        },
            success: { (transactionEmployee) in
                
                guard let fetchedObject = CoreStore.fetchExisting(transactionEmployee) else {
                    return
                }
                
                completion(.success(fetchedObject))
        },
            failure: { (error) in
                completion(.failure(error))
        })
    }
}
