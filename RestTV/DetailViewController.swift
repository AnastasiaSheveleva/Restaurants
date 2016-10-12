//
//  detailViewController.swift
//  RestTV
//
//  Created by Анастасия on 26.09.16.
//  Copyright © 2016 Anastasia. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RestaurantCustomTableViewCell2Delegate {
    
    var restaurant: Restaurant!
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var detailTableView: UITableView!
    
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    
    func restaurantCustomTableViewCell2(cell: UITableViewCell, didSwithIsVisited isVisited: Bool) {
        restaurant.isVisited = isVisited
        
        //let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        
            do {
                try restaurant.managedObjectContext?.save()
            } catch {
                print(error)
                return
            }
    }

    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Скругляет углы таблицы
        detailTableView.layer.cornerRadius = 13.0
        detailTableView.clipsToBounds = true
        
        // Картинка для view
        if restaurant.image != nil {
            restaurantImageView.image = UIImage(data: restaurant.image as! Data)}
                
        // Сменить title в Navigation Bar
        title = restaurant.name
        
        // Сменить цвет разделителей
        // tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        
        // Самомасштабирование
        detailTableView.estimatedRowHeight = 40.0
        detailTableView.rowHeight = UITableViewAutomaticDimension
        
        // Значок рейтинга
        if let rating = restaurant.rating {
            rateButton.setImage(UIImage(named: rating), for: UIControlState.normal)
        }
        
        // Цвет и толщина границы значка карты
        // mapButton.layer.borderColor = UIColor.white.cgColor
       // mapButton.layer.borderWidth = 3.5
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Data Source Protocol
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! RestaurantCustomTableViewCell2
                    cell.fieldLabel.text = NSLocalizedString("Been here", comment: "Been here field")
                    if restaurant.isVisited == false {
                        cell.valueIsVisited.isOn = false
                    }
                    else {
                        cell.valueIsVisited.isOn = true
                    }
                    cell.delegate = self
                return cell

            }
            
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as! RestaurantCustomTableViewCell1
                switch indexPath.row {
                    case 0:
                        cell.fieldLabel.text = NSLocalizedString("Name", comment: "Name field")
                        cell.valueLabel.text = restaurant.name
                    case 1:
                        cell.fieldLabel.text = NSLocalizedString("Phone", comment: "Phone field")
                        cell.valueLabel.text = restaurant.phone
                    case 2:
                        cell.fieldLabel.text = NSLocalizedString("Location", comment: "Location field")
                        cell.valueLabel.text = restaurant.adress
                    default:
                        cell.fieldLabel.text = ""
                        cell.valueLabel.text = ""
                    }
               
                return cell
                
            }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func close(segue: UIStoryboardSegue) {
        if let ratingFromRateViewController = segue.source as? RateViewController {
            let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
                if managedObjectContext != nil {
                    if let rating = ratingFromRateViewController.rating {
                        rateButton.setImage(UIImage(named: rating), for: UIControlState.normal)
                        restaurant.rating = rating
                    }
            
                    do {
                        try managedObjectContext?.save()
                    } catch {
                        print(error)
                        return
                    }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap" {
            let destinationViewController = segue.destination as! MapViewController
            destinationViewController.restaurant = restaurant
        }
    }
    
    @IBAction func phoneButtonClick(_ sender: AnyObject) {
        
        let alertController = UIAlertController(title: NSLocalizedString("Call to ", comment: "Call in allert title") + "\(restaurant.name)", message: NSLocalizedString("by number ", comment: "Number in allert message") + "\(restaurant.phone! as String)" + "?", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: "Answer yes"), style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) -> Void in
            let alertController2 = UIAlertController(title: NSLocalizedString("Service is not available", comment: "Service is not available allert title") , message: NSLocalizedString("Sorry, but now it is impossible to call. Try later.", comment: "Service is not available allert message"), preferredStyle: UIAlertControllerStyle.alert)
            alertController2.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController2, animated: true, completion: nil)
        }))
        alertController.addAction(UIAlertAction(title: NSLocalizedString("No", comment: "Answer no"), style: UIAlertActionStyle.cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
