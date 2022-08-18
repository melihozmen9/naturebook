//
//  ViewController2.swift
//  naturebook
//
//  Created by Kullanici on 9.08.2022.
//

import UIKit
import CoreData

class ViewController2: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var nametext: UITextField!
    @IBOutlet weak var placetext: UITextField!
    @IBOutlet weak var yeartext: UITextField!
    @IBOutlet weak var imageview: UIImageView!
    var targetname = ""
    var targetid : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if targetname != "" {
            // coredata verileri buraya gelecek. :)
            guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            let context = appdelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Galeri")
            // filtreleme
            let idstring = targetid?.uuidString // id aldık.
            fetchRequest.predicate = NSPredicate(format: "id = %@", idstring!)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
               let results =  try context.fetch(fetchRequest)
                for result in results as! [NSManagedObject]{
                    if let name = result.value(forKey: "name") as? String {
                        nametext.text = name
                        
                    }
                    if let place = result.value(forKey: "place") as? String{
                        placetext.text = place
                    }
                    if let year = result.value(forKeyPath: "year")  as? Int {
                        yeartext.text = String(year)
                        
                    }
                    if let imagedata = result.value(forKey: "image") as?  Data {
                        let image = UIImage(data: imagedata)
                        
                        imageview.image = image
                        
                    }
                    
                }
            } catch  {
                print("error")
            }
            
        }else{
            
        }
        imageview.isUserInteractionEnabled = true
        let gesturerecognizer = UITapGestureRecognizer(target: self, action: #selector(imagetap))
        imageview.addGestureRecognizer(gesturerecognizer)
        // Do any additional setup after loading the view.
    }
    
    @objc func imagetap() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageview.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    @IBAction func saveclickedbutton(_ sender: Any) {
        // veri kaydetme işlemi
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let savedata = NSEntityDescription.insertNewObject(forEntityName: "Galeri", into: context)
        
        savedata.setValue((nametext.text!), forKey: "name")
        savedata.setValue((placetext.text!),forKey : "place")
        
        if let year = Int(yeartext.text!) {
            savedata.setValue(year, forKey: "year")
        }
        let imagepress = imageview.image?.jpegData(compressionQuality: 0.5)
        savedata.setValue(imagepress, forKey: "image")
        savedata.setValue(UUID(), forKey: "id") // buradaki UUID bize unique bir id oluşturacak.
        do {
            try context.save()
            print("success ")
        } catch  {
            print("error")
        }
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "newdata"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
    commi
}
