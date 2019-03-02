//
//  HomeViewController.swift
//  Instagram
//
//  Created by admin on 19/02/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        // Do any additional setup after loading the view.
    }
  

}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "postCell", for: indexPath)
        
        cell.backgroundColor = UIColor.red
        return cell
    }
}
