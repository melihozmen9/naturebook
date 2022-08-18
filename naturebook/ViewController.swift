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
    var sourcename = ""
    var sourceid : UUID?
    
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
        getdata()
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getdata), name: NSNotification.Name("newdata"), object: nil)
    }
    @objc func getdata() {
        self.namearray.removeAll(keepingCapacity: true)
        self.idarray.removeAll(keepingCapacity: true)
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tosecondvc" {
            let destinationvc = segue.destination as! ViewController2
            destinationvc.targetname = sourcename
            destinationvc.targetid = sourceid
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sourcename = namearray[indexPath.row]
        sourceid = idarray[indexPath.row]
        
        performSegue(withIdentifier: "tosecondvc", sender: nil)
    }
}

