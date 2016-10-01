//
//  detailViewController.swift
//  RestTV
//
//  Created by Анастасия on 26.09.16.
//  Copyright © 2016 Anastasia. All rights reserved.
//

import UIKit

class detailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, RestaurantCustomTableViewCell2Delegate {
    
    @IBOutlet weak var restaurantImageView: UIImageView!
    var restaurant = Restaurant(name: "", phone: "", adress: "", logo: "", image: "", isVisited: false, rating: "")
    
    @IBOutlet weak var detailTableView: UITableView!
    
    @IBOutlet weak var rateButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    
    func restaurantCustomTableViewCell2(cell: UITableViewCell, didSwithIsVisited isVisited: Bool) {
        restaurant.isVisited = isVisited
        }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Скругляет углы таблицы
        detailTableView.layer.cornerRadius = 13.0
        detailTableView.clipsToBounds = true
        
        // Дополнтельные действия после загрузки view
        restaurantImageView.image = UIImage(named: restaurant.image)
        
        // Сменить title в Navigation Bar
        //title = restaurant.name
        
        // Самомасштабирование
        detailTableView.estimatedRowHeight = 40.0
        detailTableView.rowHeight = UITableViewAutomaticDimension
        
        // Значок рейтинга
        let rating = restaurant.rating
        rateButton.setImage(UIImage(named: rating), for: UIControlState.normal)
        
        // Цвет и толщина границы значка карты
        // mapButton.layer.borderColor = UIColor.white.cgColor
       // mapButton.layer.borderWidth = 3.5
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if indexPath.row == 3 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell2", for: indexPath) as! RestaurantCustomTableViewCell2
                    cell.fieldLabel.text = "Я был здесь"
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
                        cell.fieldLabel.text = "Название"
                        cell.valueLabel.text = restaurant.name
                    case 1:
                        cell.fieldLabel.text = "Телефон"
                        cell.valueLabel.text = restaurant.phone
                    case 2:
                        cell.fieldLabel.text = "Адрес"
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
    
    @IBAction func close(segue: UIStoryboardSegue)
    {
        if let ratingVC = segue.source as? RateViewController {
            if let rating = ratingVC.rating {
                rateButton.setImage(UIImage(named: rating), for: UIControlState.normal)
                restaurant.rating = rating
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMap" {
            let destinationViewController = segue.destination as! MapViewController
            destinationViewController.restaurant = restaurant
        }
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
