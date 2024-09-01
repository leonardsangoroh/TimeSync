import UIKit

class MainTableViewController: UITableViewController,  ContactTableViewCellDelegate {
    
    var contacts: [Contact] = []
    var contactLocalTime: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        configureTableView()
        fetchContacts()
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Contact", for: indexPath) as! ContactTableViewCell
        cell.delegate = self
        let contact = contacts[indexPath.row]
        cell.set(contact: contact)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailViewController()
        vc.userName.text = contacts[indexPath.row].givenName
        vc.phoneNumber.text = "    " + "\(contacts[indexPath.row].phoneNumbers.first!.number)"
        vc.time.text = "    " + contactLocalTime + " hrs"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func configureTableView() {
        tableView.rowHeight = 66
        tableView.register(ContactTableViewCell.self, forCellReuseIdentifier: "Contact")
        view.backgroundColor = UIColor(named: "background_color")
    }

    func fetchContacts() {
        NylasService.shared.getContacts() { [weak self] result in
            print("Fetching them contacts")
            DispatchQueue.main.async {
                switch result {
                case .success(let contacts):
                    print("DONE")
                    self?.contacts = contacts
                    self?.tableView.reloadData()
                case .failure(let error):
                    // Present an alert or handle the error
                    print("Error fetching contacts: \(error.localizedDescription)")
                }
            }
        }
    }
    
    
    func didFetchCurrentTime(_ time: String) {
        contactLocalTime = time
    }
}
