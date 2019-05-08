//
//  CompaniesViewController.swift
//  CoreStoreUpdate
//
//  Created by Alex Matrosov on 5/8/19.
//  Copyright © 2019 Alex Matrosov. All rights reserved.
//

import UIKit

class CompaniesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var companyService = CompanyService()
    var companies = [Company]()
    var selectedCompany: Company?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCompanies()
    }
    
    @IBAction func onPressedAddCompanyButton(_ sender: Any) {
        addCompany()
    }
    
    func addCompany() {
        
        guard let companyName = textField.text else { return }
        
        companyService.createCompany(with: companyName) { (result) in
            
            switch result {
            case let .success(company):
                self.textField.text = nil
                self.companies.append(company)
                self.tableView.reloadData()
                break
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func fetchCompanies() {
        if let unwrappedCompanies = companyService.fetchCompanies() {
            companies = unwrappedCompanies
            
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BaseCell", for: indexPath)
        let company = companies[indexPath.row]
        cell.textLabel?.text = company.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCompany = companies[indexPath.row]
        performSegue(withIdentifier: "Show employees", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? EmployeesViewController {
            
            vc.company = selectedCompany
            
        }
    }
}

