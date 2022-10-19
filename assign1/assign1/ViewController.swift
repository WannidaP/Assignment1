import UIKit
import Alamofire

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    
    var listData: [Repository] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        table.dataSource = self
        table.delegate = self
        fetchRepositoryGH()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RepositoryTableViewCell
        let data = listData[indexPath.row]
        cell.fullnameLable.text = data.fullname
        cell.avatarImageView.loadFrom(URLAddress: data.owner.avatar)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension ViewController {
    func fetchRepositoryGH() {
        
        AF.request("https://api.github.com/search/repositories?q=ios&per_page=20&page=1")
            .validate()
            .responseDecodable(of: Repositorys.self) { (response) in
                guard let repositorys = response.value else {
                    return
                }
                self.listData = repositorys.all
                self.table.reloadData()
            }
    }
}

extension UIImageView {
    func loadFrom(URLAddress: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: URLAddress) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
