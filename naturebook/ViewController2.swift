//
//  ViewController2.swift
//  naturebook
//
//  Created by Kullanici on 9.08.2022.
//

import UIKit

class ViewController2: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var nametext: UITextField!
    @IBOutlet weak var placetext: UITextField!
    @IBOutlet weak var yeartext: UITextField!
    @IBOutlet weak var imageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        let savedata =
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
