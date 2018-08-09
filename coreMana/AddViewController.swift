//
//  AddViewController.swift
//  coreMana
//
//  Created by popCorn on 2018/08/09.
//  Copyright © 2018 popCorn. All rights reserved.
//

import UIKit
import CoreData

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //to save data
    var pc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var imageField: UIImageView!
    //using this variable to send data with segue has name "edit"
    var item: Entity? = nil
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //check if item is nil . change the navigation title equal to add new data
        if item == nil {
            self.navigationItem.title = "Add new task"
        } else {
            self.navigationItem.title = item?.title
            
            titleField.text = item?.title
            descriptionField.text = item?.descriptionText
            imageField.image = UIImage(data: (item?.image)! as Data)
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //declare dismissKeyboard function
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.resignFirstResponder()
    }
    
    
    
    @IBAction func usingLibrary(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        pickerController.allowsEditing = true
        self.present(pickerController, animated: true, completion: nil)
    }
    
    
    @IBAction func usingCamera(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.camera
        pickerController.allowsEditing = true
        self.present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func saveData(_ sender: Any) {
        //if segue item is empty . function add new record, else then update existing record.
        if item == nil {
            //add new data
            let entityDes  = NSEntityDescription.entity(forEntityName: "Entity", in: pc)
            let item = Entity(entity: entityDes!, insertInto: pc)
            
            item.title = titleField.text
            item.descriptionText = descriptionField.text
            item.image = UIImagePNGRepresentation(imageField.image!) as NSData?
        } else {
            //edit data
            item?.title = titleField.text
            item?.descriptionText = descriptionField.text
            item?.image = UIImagePNGRepresentation(imageField.image!) as NSData?
        }
        // try do save data
        do {
            try pc.save()
        } catch {
            print(error)
            return
        }
        //back to tableview
        navigationController!.popViewController(animated: true)
    }
    //func after image was chosing
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let takenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageField.image = takenImage
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
       self.dismiss(animated: true, completion: nil)
    }
}
