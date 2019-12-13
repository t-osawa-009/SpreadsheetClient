import UIKit
import SpreadsheetClient

final class MainViewController: UITableViewController {
    private let client = SpreadsheetClient()
    private var keys = [String]()
    private var ja = [String]()
    private var en = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing:  UITableViewCell.self))
        
        client.send(id: "1zVw1G2LvoJOnnaez3Tuf2Kxqt7S8-zATNazY14FgBwI", sheetNumber: 1) { [weak self] (result) in
            switch result {
            case .success(let dic):
                self?.keys = dic.fetch(with: "key")
                self?.ja = dic.fetch(with: "ja")
                self?.en = dic.fetch(with: "en")
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing:  UITableViewCell.self), for: indexPath)
        let key = keys[indexPath.row]
        let _ja = ja[indexPath.row]
        let _en = en[indexPath.row]
        cell.textLabel?.text = "\(key): \(_ja), \(_en)"
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keys.count
    }
}
