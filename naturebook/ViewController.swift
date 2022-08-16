//
//  ViewController.swift
//  naturebook
//
//  Created by Kullanici on 9.08.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    var namearray = [String]()
    var idarray = [UUID]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return namearray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = namearray[indexPath.row]
        return cell
        
    }
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addItem))
        tableview.delegate = self
        tableview.dataSource = self
        
    }
    func getdata() {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appdelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Galeri")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
           let results =  try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject]{
                if let name = result.value(forKey: "name") as? String{
                    self.namearray.append(name)
                }
                
                if let id = result.value(forKey: "id") as? UUID{
                    self.idarray.append(id)
                }
            }
        } catch  {
            
        }
    }
    @objc func addItem () {
        performSegue(withIdentifier: "tosecondvc", sender: nil)
    }

}

