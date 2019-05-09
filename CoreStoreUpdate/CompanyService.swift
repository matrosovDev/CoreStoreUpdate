//
//  CompanyService.swift
//  CoreStoreUpdate
//
//  Created by Alex Matrosov on 5/9/19.
//  Copyright © 2019 Alex Matrosov. All rights reserved.
//

import Foundation
import CoreStore

class CompanyService {
    
    func createCompany(with name: String, completion: @escaping (Result<Company, Error>) -> Void) {
        CoreStore.perform(
            asynchronous: { (transaction) -> Company in
                let company = transaction.create(Into<Company>())
                let managed_object_id = company.objectID.description // just for test!
                company.id = managed_object_id
                company.name = name
                return company
        },
            success: { (transactionCompany) in
                
                guard let fetchedObject = CoreStore.fetchExisting(transactionCompany) else {
                    return
                }
                
                completion(.success(fetchedObject))
        },
            failure: { (error) in
                completion(.failure(error))
        })
    }
    
    func updateCompany(with company: Company, completion: @escaping (Result<Company, Error>) -> Void) {
        CoreStore.perform(
            asynchronous: { (transaction) -> Company in
               
                let editCompany = transaction.edit(company)!
                
                editCompany.name = company.name
                
                if let unwrappedEmployees = company.employees {
                    for employee in unwrappedEmployees {
                        if let castedEmployee = employee as? Employee {
                            let editEmployee = transaction.edit(castedEmployee)!
                            editCompany.addToEmployees(editEmployee)
                        }
                    }
                }
                
                return editCompany
        },
            success: { (transactionCompany) in
                
                guard let fetchedObject = CoreStore.fetchExisting(transactionCompany) else {
                    return
                }
                
                completion(.success(fetchedObject))
        },
            failure: { (error) in
                completion(.failure(error))
        })
    }
    
    func fetchCompanies() -> [Company]? {
        let company = try? CoreStore.fetchAll(From<Company>())
        return company
    }
    
    func fetchEmployees(with id: String) -> [Employee]? {
        let company = try? CoreStore.fetchOne(
            From<Company>()
                .where(\.id == id)
        )
        
        if let unwrappedEmployees = company?.employees?.allObjects as? [Employee] {
            return unwrappedEmployees
        } else {
            return nil
        }
    }
}
