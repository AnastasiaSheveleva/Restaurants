//
//  RecomendationsTableViewController.swift
//  RestTV
//
//  Created by Анастасия on 13.10.16.
//  Copyright © 2016 Anastasia. All rights reserved.
//

import UIKit
import CloudKit

class RecomendationsTableViewController: UITableViewController {

    @IBOutlet var spiner: UIActivityIndicatorView!
    
    var restaurants:[CKRecord] = []
    var imageCache = NSCache<CKRecordID, NSData>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Получение данных из облака
        getRecordsFromCloud()
        
        // Настройка анимации загрузки
        spiner.hidesWhenStopped = true
        spiner.center = view.center
        view.addSubview(spiner)
        spiner.startAnimating()
        
        // Pull to refresh
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = UIColor.white
        refreshControl?.tintColor = UIColor.darkGray
        refreshControl?.addTarget(self, action: #selector(RecomendationsTableViewController.getRecordsFromCloud), for: UIControlEvents.valueChanged)

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
    
    func getRecordsFromCloud() {
        var newRestaurantsFromCloud:[CKRecord] = []
        let cloudContainer = CKContainer.default()
        let publicDatabase = cloudContainer.publicCloudDatabase
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "Restaurant", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
       
        let queryOperation = CKQueryOperation(query: query)
        queryOperation.desiredKeys = ["name"]
        queryOperation.queuePriority = .veryHigh
        queryOperation.resultsLimit = 50
        
        queryOperation.recordFetchedBlock = { (record: CKRecord!) -> Void in
            if let restaurantRecord = record {
                newRestaurantsFromCloud.append(restaurantRecord)
            }
            
        }
        
        queryOperation.queryCompletionBlock = { (cursor: CKQueryCursor?, error: Error?) -> Void in
        
            if error != nil {
                print("Failed to get data from iCloud")
                return
            }
            print("Succcess")
                OperationQueue.main.addOperation() {
                self.restaurants = newRestaurantsFromCloud
                self.tableView.reloadData()
                self.spiner.stopAnimating()
                self.refreshControl?.endRefreshing()
            }
           
        }
        
        publicDatabase.add(queryOperation)
        
        /*
        publicDatabase.perform(query, inZoneWith: nil, completionHandler: { (results, error) -> Void in
            
            if error != nil {
                print(error)
                return
            }
            
            if let results = results {
                self.restaurants = results
                
                OperationQueue.main.addOperation() {
                    self.tableView.reloadData()
                }
            }
            
        })
         */
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! RecomendationsTableViewCell

        // Configure cell
        let restaurant = restaurants[indexPath.row]
        let labelText = restaurant.object(forKey: "name") as? String
        cell.nameLabel?.text = labelText! + " ."
        
        //Cache
        if let imageFile = imageCache.object(forKey: restaurant.recordID) {
            cell.customImageView?.image = UIImage(data: imageFile as Data)
        } else {
        // iCloud
            let publicDatabase = CKContainer.default().publicCloudDatabase
            let fetchRecordImageOperation = CKFetchRecordsOperation(recordIDs: [restaurant.recordID])
            fetchRecordImageOperation.desiredKeys = ["image"]
            fetchRecordImageOperation.queuePriority = .veryHigh
        
            fetchRecordImageOperation.perRecordCompletionBlock = { (record: CKRecord?, recorgID: CKRecordID?, error: Error?) -> Void in
            
                if error != nil {
                    print(error)
                    return
                }
                if let restaurantRecord = record {
                    OperationQueue.main.addOperation() {
                    if let imageAsset = restaurantRecord.object(forKey: "image") as? CKAsset {
                        let imageData = NSData(contentsOf: imageAsset.fileURL)! as NSData
                        cell.customImageView?.image = UIImage(data: imageData as Data)
                        self.imageCache.setObject(imageData, forKey: restaurant.recordID)
                        }
                    }
                }
            
            }
        
            publicDatabase.add(fetchRecordImageOperation)
        
        /*
        if let image = restaurant.object(forKey: "image") {
            let imageAsset = image as! CKAsset
            cell.customImageView?.image = UIImage(data: NSData(contentsOf: imageAsset.fileURL)! as Data)
        }
         */

        }
                
        return cell
    }
    
    override func  tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //cell.alpha = 0
        //UIView.animate(withDuration: 2.0, animations: {cell.alpha = 1})
        
        let rotationAngleInRadians = 90.0 * CGFloat(M_PI/180)
        let rotationTransform = CATransform3DMakeRotation(rotationAngleInRadians, 1, 0.5, 0)
        cell.layer.transform = rotationTransform
        
        UIView.animate(withDuration: 1.0, animations: {cell.layer.transform = CATransform3DIdentity})
        
        //let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 0, 0)
        //cell.layer.transform = rotationTransform
        
        //UIView.animate(withDuration: 1.0, animations: {cell.layer.transform = CATransform3DIdentity})
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
