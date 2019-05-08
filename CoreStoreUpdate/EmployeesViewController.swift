//
//  EmployeesViewController.swift
//  CoreStoreUpdate
//
//  Created by Alex Matrosov on 5/8/19.
//  Copyright © 2019 Alex Matrosov. All rights reserved.
//

import UIKit

class EmployeesViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var company: Company?
    var employeeService = EmployeeService()
    var companyService = CompanyService()
    var employees = [Employee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchEmployees()
    }
    
    @IBAction func onPressedAddEmployeeButton(_ sender: Any) {
        addEmployee()
    }
    
    func addEmployee() {
        
        guard let employeeName = textField.text else { return }
        
        employeeService.createEmployee(with: employeeName) { (result) in
            
            switch result {
            case let .success(employee):
                self.updateCompnay(with: employee)
                self.textField.text = nil
                self.employees.append(employee)
                self.tableView.reloadData()
                break
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func updateCompnay(with employee: Employee) {
        
        if let unwrappedCompany = company {
            unwrappedCompany.addToEmployees(employee)
            
            companyService.updateCompany(with: unwrappedCompany) { (result) in
                switch result {
                case let .success(updatedCompany):
                    print("Company was updated. Employees count: ", updatedCompany.employees?.count ?? -100)
                    break
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
    func fetchEmployees() {
        if let unwrappedEmployees = employeeService.fetchEmployees() {
            employees = unwrappedEmployees
            
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BaseCell", for: indexPath)
        let employee = employees[indexPath.row]
        cell.textLabel?.text = employee.name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}

