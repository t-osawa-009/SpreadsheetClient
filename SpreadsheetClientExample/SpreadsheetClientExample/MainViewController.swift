import UIKit
import SpreadsheetClient

final class MainViewController: UITableViewController {
    private let client = SpreadsheetClient()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing:  UITableViewCell.self))
        
        client.send(id: "1zVw1G2LvoJOnnaez3Tuf2Kxqt7S8-zATNazY14FgBwI", sheetNumber: 1) { (result) in
            switch result {
            case .success(let dic):
                print(dic)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:  UITableViewCell.self), for: indexPath)
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}
