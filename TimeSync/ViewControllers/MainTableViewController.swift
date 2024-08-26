//
//  MainTableViewController.swift
//  TimeSync
//
//  Created by Lee Sangoroh on 25/08/2024.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var contacts: [Contact] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        contacts = fetchData()
        print(contacts.count)
        navigationController?.navigationBar.prefersLargeTitles = true
        configureTableView()
    }

    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contact", for: indexPath) as! ContactTableViewCell
        let contact = contacts[indexPath.row]
        cell.set(contact: contact)
        return cell
    }
    
    
    
    func configureTableView(){
        tableView.rowHeight = 66
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: "Contact")
    }
    
    
    func fetchData() -> [Contact] {
        let contactOne = Contact(profilePhoto: UIImage(named: "Lee")!, name: "Lee Leonard", localTime: "2300", country: "KENYA")
        let contactTwo = Contact(profilePhoto: UIImage(named: "Lee")!, name: "Lee Leonard", localTime: "2300" , country: "KENYA")
        let contactThree = Contact(profilePhoto: UIImage(named: "Lee")!, name: "Lee Leonard", localTime: "2300" , country: "KENYA")
        
        return [contactOne, contactTwo, contactThree]
    }

}
