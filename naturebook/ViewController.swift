//
//  ViewController.swift
//  naturebook
//
//  Created by Kullanici on 9.08.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "HiCoreData"
        return cell
        
    }
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addItem))
        tableview.delegate = self
        tableview.dataSource = self
        
    }
    @objc func addItem () {
        performSegue(withIdentifier: "tosecondvc", sender: nil)
    }

}

