//
//  HomePageViewController.swift
//  HW2_Crypto_App
//
//  Created by Zeynep Nur Altın on 1.05.2024.
//

import UIKit

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tableViewHeaderLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var coins = [Coins]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appNameLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        descriptionLabel.font = UIFont.systemFont(ofSize: 14.0)
        tableViewHeaderLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        tableViewHeaderLabel.textColor = UIColor.purple
        
        tableView.delegate = self
        tableView.dataSource = self
        
        ParsingJson { data in
            self.coins = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        func ParsingJson(completion: @escaping ([Coins])->()){
            
            let urlString = "https://psp-merchantpanel-service-sandbox.ozanodeme.com.tr/api/v1/dummy/coins"
            
            let url = URL(string: urlString)
            
            guard url != nil else {
                print("url error")
                return
            }
                
            let session = URLSession.shared
            
            let task = session.dataTask(with: url!) { data, response, error in
                
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                guard let jsonData = data else {
                    print("No data received")
                    return
                }
                
                let decoder = JSONDecoder()
                
                do {
                    let parsingData = try decoder.decode(NewAPI.self, from: jsonData)
                    completion(parsingData.data!.coins!)
                }catch {
                    print("Parsing error")
                }
            }
            
            task.resume()
            
        }
    }
}

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell", for: indexPath)
        
        //bunu cell custom'a çevir
        cell.textLabel?.text = coins[indexPath.row].name
        
        return cell
    }
    
    
}
