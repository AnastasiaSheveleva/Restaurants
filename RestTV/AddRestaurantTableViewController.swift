//
//  AddRestaurantTableViewController.swift
//  RestTV
//
//  Created by Анастасия Шевелева on 02.10.16.
//  Copyright © 2016 Anastasia. All rights reserved.
//

import UIKit
import CoreData

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
            let alertController = UIAlertController(title: "Ой!", message: "Невозможно продолжить, потому что одно из полей пустое. Пожалуйста, заполните все необходимые поля.", preferredStyle: UIAlertControllerStyle.alert)
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
}
