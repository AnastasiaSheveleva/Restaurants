//
//  AddRestaurantTableViewController.swift
//  RestTV
//
//  Created by Анастасия Шевелева on 02.10.16.
//  Copyright © 2016 Anastasia. All rights reserved.
//

import UIKit
import CoreData
import CloudKit

class AddRestaurantTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet var nameTextField:UITextField!
    @IBOutlet var phoneTextField:UITextField!
    @IBOutlet var adressTextField:UITextField!
    @IBOutlet var yesButton:UIButton!
    @IBOutlet var noButton:UIButton!
    
    var isVisited = true
    var imageFlag = false
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Настройка Navigation Bar
        title = NSLocalizedString("New restaurant", comment: "Add restaurant table name")
        
        // Настройка полей для добавления
        nameTextField.placeholder = NSLocalizedString("Enter restaurant name", comment: "Name place holder")
        phoneTextField.placeholder = NSLocalizedString("Enter phone number in format +7 (812) 777-77-77", comment: "Phone place holder")
        adressTextField.placeholder = NSLocalizedString("Enter restaurant location", comment: "Location place holder")
        yesButton.setTitle(NSLocalizedString("Yes", comment: "Yes answer"), for: UIControlState.normal)
        noButton.setTitle(NSLocalizedString("No", comment: "No answer"), for: UIControlState.normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - UIImagePickerControllerDelegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        
        dismiss(animated: true, completion: nil)
        imageFlag = true
        
    }
    
    // MARK: - Action methods //Добавили кнопки
    @IBAction func save(sender:UIBarButtonItem) {
        let name = nameTextField.text
        let phone = phoneTextField.text
        let adress = adressTextField.text
        
        // Проверка на валидность введенных строк
        if name == "" || phone == "" || adress == "" {
            let alertController = UIAlertController(title: NSLocalizedString("Oops!", comment: "Oops alert title"), message: NSLocalizedString("You can not continue, because one of the fields blank. Please fill in all required fields", comment: "Text in all field message"), preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            
            return
        }
        
        let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        if managedObjectContext != nil {
            restaurant = NSEntityDescription.insertNewObject(forEntityName: "Restaurant", into: managedObjectContext!) as! Restaurant
            restaurant.name = name!
            restaurant.phone = phone!
            restaurant.adress = adress!
            
            //if let restaurantImage = imageView.image {
             //   restaurant.image = UIImagePNGRepresentation(restaurantImage) as NSData?
            //}
            if imageFlag == true {
                let restaurantImage = imageView.image 
                restaurant.image = UIImagePNGRepresentation(restaurantImage!) as NSData?
            }             
            restaurant.isVisited = isVisited
            
            do {
                try managedObjectContext?.save()
            } catch {
                print(error)
                return
            }
        }
        
        dismiss(animated: true, completion: nil)
        
        saveRecordToCloud(Restaurant: restaurant)
    }
    
    @IBAction func toggleBeenHereButton(sender: UIButton) {
        // Нажата кнопка Да
        if sender == yesButton {
            isVisited = true
            yesButton.backgroundColor = UIColor(red: 240.0/255.0, green: 108.0/255.0, blue: 50.0/255.0, alpha: 0.9)
            noButton.backgroundColor = UIColor.darkGray
        } else if sender == noButton { //Нажата кнопка Нет
            isVisited = false
            yesButton.backgroundColor = UIColor.darkGray
            noButton.backgroundColor = UIColor(red: 240.0/255.0, green: 108.0/255.0, blue: 50.0/255.0, alpha: 0.9)
        }
    }
    
    func saveRecordToCloud(Restaurant: Restaurant!) -> Void {
        // Prepare
        let record = CKRecord(recordType: "Restaurant")
        record.setValue(restaurant.name, forKey: "name")
        record.setValue(restaurant.phone, forKey: "phone")
        record.setValue(restaurant.adress, forKey: "adress")
        
        // Resize image
        let originalImage = UIImage(data: restaurant.image! as Data)!
        let scalingFactor = (originalImage.size.width > 1024) ? 1024 / originalImage.size.width : 1.0
        let scaledImage = UIImage(data: restaurant.image! as Data, scale: scalingFactor)!
        
        // Tmp use
        let imageFilePath = NSURL.fileURL(withPath: NSTemporaryDirectory() + restaurant.name)//NSTemporaryDirectory() + restaurant.name
        let imageData = UIImageJPEGRepresentation(scaledImage, 0.8)! as Data
        
        do {
            try imageData.write(to: imageFilePath)
        } catch {
            print("Saving error")
        }
            
       
        //?.writeToFile(imageFilePath, automatically: true)
        
        // Creating asset
        //let imageFileURL = NSURL(fileURLWithPath: imageFilePath)
        let imageAsset = CKAsset(fileURL: imageFilePath as URL)
        record.setValue(imageAsset, forKey: "image")
        
        let publicDatabase = CKContainer.default().publicCloudDatabase
        publicDatabase.save(record, completionHandler: { (record: CKRecord?, error: Error?) -> Void in
            // Remove tmp
            do {
                try FileManager.default.removeItem(at: imageFilePath)
            } catch {
                print("Saving error")
            }
            
        })
        
    }
}
