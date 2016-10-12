//
//  Restaurants.swift
//  RestTV
//
//  Created by Анастасия on 23.09.16.
//  Copyright © 2016 Anastasia. All rights reserved.
//

import UIKit
import CoreData

class RestaurantTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    
    var restaurants: [Restaurant] = []
    var searchResult: [Restaurant] = []
    var fetchResultController: NSFetchedResultsController<Restaurant>!
    var searchController: UISearchController!
    
   override func viewDidLoad() {
        super.viewDidLoad()
    
        // Убрать пустые ячейки таблицы
        //tableView.tableFooterView = UIView(frame: CGRect.zero)
    
        // Сменить title в Navigation Bar
        title = NSLocalizedString("Restaurants", comment: "Main table name")
    
        // Удалить title у кнопки  back
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    
        // Настройка Search Controller
        searchController = UISearchController(searchResultsController: nil)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("Restaurants search", comment: "Search bar placeholder")
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.barTintColor = UIColor(white: 0.4, alpha: 1.0)
    
        // Настройка запросов и контекста
        let fetchRequest: NSFetchRequest<Restaurant> = Restaurant.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
    
        let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
        if managedObjectContext != nil {
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: managedObjectContext!, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                restaurants = fetchResultController.fetchedObjects!
            } catch {
                print(error)
                return
            }
        }
    
    
        // Самомасштабирование
        tableView.estimatedRowHeight = 70.0
        tableView.rowHeight = UITableViewAutomaticDimension
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnSwipe = true
        tableView.reloadData()
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
        if searchController.isActive {
            return searchResult.count
        } else {
            return restaurants.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        let restaurant = (searchController.isActive) ? searchResult[indexPath.row] : restaurants[indexPath.row]
        
        // Настройка ячейки
        if (restaurant.image?.description) != nil {
            let image = UIImage(data: restaurant.image as! Data)
                cell.thumbnailImageView?.image = image
            } else {
                cell.thumbnailImageView?.image = UIImage(named: "picture")
            }
    
        //cell.thumbnailImageView?.image = UIImage(data: restaurants[indexPath.row].image as! Data)
        cell.nameLabel?.text = restaurant.name
        cell.locationLabel?.text = restaurant.adress
        cell.typeLabel?.text = restaurant.phone
        
        if restaurant.isVisited {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        cell.thumbnailImageView.layer.cornerRadius = 14.0
        cell.thumbnailImageView.clipsToBounds = true
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if searchController.isActive {
            return false
        } else {
            return true
        }
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let _newIndexPath = newIndexPath {
                tableView.insertRows(at: [_newIndexPath], with: .fade)
            }
        case .delete:
            if let _newIndexPath = newIndexPath {
                tableView.deleteRows(at: [_newIndexPath], with: .fade)
            }
        case .update:
            if let _newIndexPath = newIndexPath {
                tableView.reloadRows(at: [_newIndexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        
        restaurants = controller.fetchedObjects as! [Restaurant]
        
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        //Social
        let shareAction = UITableViewRowAction(style: .default, title: NSLocalizedString("Share", comment: "Share button"), handler: { (ACTION, indexPath) -> Void in
            let defaultText = NSLocalizedString("Share with text", comment: "Share text") + self.restaurants[indexPath.row].name
            let activityController = UIActivityViewController(activityItems: [defaultText], applicationActivities: nil)
            self.present(activityController, animated: true, completion: nil)
        })
        
        //Delete
        let deleteAction = UITableViewRowAction(style: .default, title: NSLocalizedString("Delete", comment: "Delete button"), handler: {(ACTION, indexPath) -> Void in
            self.restaurants.remove(at: indexPath.row)
            
            let managedObjectContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
            if managedObjectContext != nil {
                let restaurantToDelete = self.fetchResultController.object(at: indexPath)
                
                //managedObjectContext?.delete(restaurantToDelete)
                //tableView.deleteRows(at: [indexPath], with: .fade) !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
                
                do {
                    managedObjectContext?.delete(restaurantToDelete)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    try managedObjectContext?.save()
                } catch {
                    print(error)
                    return
                }
            }
            
        })
    
        shareAction.backgroundColor = UIColor(colorLiteralRed: 28/255, green: 165/255, blue: 253/255, alpha: 1)
        deleteAction.backgroundColor = UIColor(colorLiteralRed: 202/255, green: 202/255, blue: 203/255, alpha: 1)
        
        return [deleteAction, shareAction]
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! DetailViewController
                //destinationController.restaurantImage = restaurants[indexPath.row].image
                destinationController.restaurant = restaurants[indexPath.row]
             }
        }
    }
    
    
    @IBAction func unwindToRestaurant(segue: UIStoryboardSegue) {
        
    }

    // Search
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(searchText: searchText)
            tableView.reloadData()
        }
    }
    
    func filterContent(searchText: String) {
        searchResult = restaurants.filter({ (restaurant: Restaurant) -> Bool in
            let nameMatch = restaurant.name.range(of: searchText, options: String.CompareOptions.caseInsensitive)
            let adressMatch = restaurant.adress.range(of: searchText, options: String.CompareOptions.caseInsensitive)
            
            return nameMatch != nil || adressMatch != nil
        })
    }
}
