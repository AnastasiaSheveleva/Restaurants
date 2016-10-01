//
//  Restaurants.swift
//  RestTV
//
//  Created by Анастасия on 23.09.16.
//  Copyright © 2016 Anastasia. All rights reserved.
//

import UIKit

class Restaurants: UITableViewController {
    
    var restaurants: [Restaurant] = [
        Restaurant(name: "Мари Vanna", phone: "+7 (812) 640-16-16", adress: "ул. Ленина, 18", logo: "mari.png", image: "mari2.jpg", isVisited: false, rating: "rating"),
        Restaurant(name: "Бричмула", phone: "+7 (812) 640-16-16", adress: "Комендантский пр., 13", logo: "brich.png", image: "brich2.jpg", isVisited: true, rating: "rating"),
        Restaurant(name: "Шурпа", phone: "+7 (812) 640-16-16", adress: "Энгельса пр., 27, 2 этаж", logo: "shyrpa.png", image: "shyrpa2.jpg", isVisited: false, rating: "rating"),
        Restaurant(name: "Food Park", phone: "+7 (812) 640-16-16", adress: "Александровский парк, 4/3 литера А", logo: "fpark.jpg", image: "fpark2.jpg", isVisited: false, rating: "rating"),
        Restaurant(name: "Katyusha", phone: "+7 (812) 640-16-16", adress: "Невский пр., 22/24", logo: "kate.png", image: "kate2.jpg", isVisited: false, rating: "rating"),
        Restaurant(name: "Mamalыga", phone: "+7 (812) 640-16-16", adress: "ул. Казанская, 2", logo: "mamal.png", image: "mamal2.jpg", isVisited: false, rating: "rating"),
        Restaurant(name: "Белка", phone: "+7 (812) 640-16-16", adress: "ул. Рыбацкая, д. 2", logo: "belka.jpg", image: "belka2.jpg", isVisited: false, rating: "rating"),
        Restaurant(name: "Рибай", phone: "+7 (812) 640-16-16", adress: "ул. Казанская, 3а", logo: "ribay.png", image: "ribay2.jpg", isVisited: false, rating: "rating"),
        Restaurant(name: "Двор Помидор", phone: "+7 (812) 640-16-16", adress: "пр. Космонавтов, 14, ТРК «Питер Радуга»", logo: "dvor.jpg", image: "dvor2.jpg", isVisited: false, rating: "rating"),
        Restaurant(name: "Лужайка", phone: "+7 (812) 640-16-16", adress: "Аптекарский пр., 16", logo: "lyg.png", image: "lyg2.jpg", isVisited: false, rating: "rating"),
        Restaurant(name: "Плюшкин", phone: "+7 (812) 640-16-16", adress: "Комендантский пр., 9 к. 2 ТК «Променад»", logo: "plush.png", image: "plush2.jpg", isVisited: false, rating: "rating"),
        Restaurant(name: "Sunday Ginza", phone: "+7 (812) 640-16-16", adress: "Южная дорога, 4/2", logo: "sunday.png", image: "sunday2.jpg", isVisited: false, rating: "rating"),
        Restaurant(name: "Пряности & Радости", phone: "+7 (812) 640-16-16", adress: "ул. Белинского, 5", logo: "pryanosti.png", image: "pryanosti2.jpg", isVisited: false, rating: "rating"),
        Restaurant(name: "Хочу Харчо", phone: "+7 (812) 640-16-16", adress: "ул. Садовая, 39/41", logo: "harcho.png", image: "harcho2.jpg", isVisited: false, rating: "rating"),
        Restaurant(name: "Гастрономика", phone: "+7 (812) 640-16-16", adress: "ул. Марата, 5/21", logo: "gastr.png", image: "gastr2.jpg", isVisited: false, rating: "rating"),
        Restaurant(name: "Царь", phone: "+7 (812) 640-16-16", adress: "ул. Садовая, 12", logo: "zar.png", image: "zar2.jpg", isVisited: false, rating: "rating"),
        Restaurant(name: "Баклажан", phone: "+7 (812) 640-16-16", adress: "Полюстровский пр., 84 А, ТРК Europolis", logo: "bacl.jpg", image: "bacl2.jpg", isVisited: false, rating: "rating"),
        Restaurant(name: "Чечил", phone: "+7 (812) 640-16-16", adress: "Дегтярный переулок, 2", logo: "chechil.png", image: "chechil2.jpg", isVisited: false, rating: "rating"),
        Restaurant(name: "Volga-volga", phone: "+7 (812) 640-16-16", adress: "Петровская наб., спуск №1, напротив дома №8", logo: "volga.jpg", image: "volga2.jpg", isVisited: false, rating: "rating"),
        Restaurant(name: "Capuletti", phone: "+7 (812) 640-16-16", adress: "Большой пр. П.С., 74", logo: "capul.png", image: "capul2.jpg", isVisited: false, rating: "rating"),
        Restaurant(name: "Terrassa", phone: "+7 (812) 640-16-16", adress: "ул. Казанская, 3", logo: "terrassa.png", image: "terrassa2.jpg", isVisited: false, rating: "rating"),
        Restaurant(name: "Москва", phone: "+7 (812) 640-16-16", adress: "Невский пр., 114, ТК «Невский центр»", logo: "moscow.png", image: "moscow2.jpg", isVisited: false, rating: "rating"),
        Restaurant(name: "Ларисиваннухочу", phone: "+7 (812) 640-16-16", adress: "пр. Науки, 14, корп. 1, литера А", logo: "larisa.jpg", image: "larisa2.jpg", isVisited: false, rating: "rating"),
        Restaurant(name: "Francesco", phone: "+7 (812) 640-16-16", adress: "Суворовский пр., 47", logo: "franc.png", image: "franc2.jpg", isVisited: false, rating: "rating"),
        Restaurant(name: "Наша DACHA", phone: "+7 (812) 640-16-16", adress: "Приморское шоссе, д. 448", logo: "dacha.jpg", image: "dacha2.jpg", isVisited: false, rating: "rating")]
    
   override func viewDidLoad() {
        super.viewDidLoad()
        
        // Самомасштабирование
        tableView.estimatedRowHeight = 70.0
        tableView.rowHeight = UITableViewAutomaticDimension
       
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return restaurants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        
        cell.thumbnailImageView?.image = UIImage(named: restaurants[indexPath.row].logo)
        cell.nameLabel?.text = restaurants[indexPath.row].name
        cell.locationLabel?.text = restaurants[indexPath.row].adress
        cell.typeLabel?.text = restaurants[indexPath.row].phone
        
        if restaurants[indexPath.row].isVisited {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        cell.thumbnailImageView.layer.cornerRadius = 13.0
        cell.thumbnailImageView.clipsToBounds = true
    
        return cell
    }
    
    /*
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let optionMenu = UIAlertController(title: nil, message: "Что вы хотите сделать?", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
     var checkIsVisited = "Я был здесь"
     self.restaurants[indexPath.row].isVisited ? (checkIsVisited = "Меня здесь не было") : (checkIsVisited = "Я был здесь")
        //if self.restouranIsVisited[indexPath.row] == false {checkIsVisited = "Я был здесь"}
        //else {checkIsVisited = "Меня здесь не было"}
        
        let isVisitedAction = UIAlertAction(title: checkIsVisited, style: .default, handler:{
            (action: UIAlertAction!) -> Void in
            let cell = tableView.cellForRow(at: indexPath)
            if self.restaurants[indexPath.row].isVisited == false {
                cell?.accessoryType = .checkmark
                self.restaurants[indexPath.row].isVisited = true}
            else {
                cell?.accessoryType = .none
                self.restaurants[indexPath.row].isVisited = false}
            })
 
        let callActionHandler = { (action: UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Сервис не доступен", message: "Простите но сейчас позвонить не возможно. Попробуйте позже", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }
        
        let callAction = UIAlertAction(title: "Позвонить " + "\(restaurants[indexPath.row].phone)", style: .default, handler: callActionHandler)
        
        optionMenu.addAction(cancelAction)
        optionMenu.addAction(callAction)
        optionMenu.addAction(isVisitedAction)
        //self.present(optionMenu, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //Social
        let shareAction = UITableViewRowAction(style: .default, title: "Поделиться", handler: { (ACTION, indexPath) -> Void in
            let defaultText = "Попробуй вкусняшки в " + self.restaurants[indexPath.row].name
            let activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
        })
        
        //Delete
        let deleteAction = UITableViewRowAction(style: .default, title: "Удалить", handler: {(ACTION, indexPath) -> Void in
            self.restaurants.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
                
        })
    
        shareAction.backgroundColor = UIColor(colorLiteralRed: 28/255, green: 165/255, blue: 253/255, alpha: 1)
        deleteAction.backgroundColor = UIColor(colorLiteralRed: 202/255, green: 202/255, blue: 203/255, alpha: 1)
        
        return [deleteAction, shareAction]
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! detailViewController
                //destinationController.restaurantImage = restaurants[indexPath.row].image
                destinationController.restaurant = restaurants[indexPath.row]
             }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
        tableView.reloadData()
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
