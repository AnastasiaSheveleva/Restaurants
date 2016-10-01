//
//  RestaurantCustomTableViewCell2.swift
//  RestTV
//
//  Created by Анастасия on 27.09.16.
//  Copyright © 2016 Anastasia. All rights reserved.
//

import UIKit

protocol RestaurantCustomTableViewCell2Delegate {
    func restaurantCustomTableViewCell2(cell: UITableViewCell, didSwithIsVisited isVisited: Bool) -> Void
}

class RestaurantCustomTableViewCell2: UITableViewCell {

    var delegate: RestaurantCustomTableViewCell2Delegate?
    @IBOutlet var fieldLabel: UILabel!
    @IBOutlet var valueIsVisited: UISwitch!
    
    @IBAction func SwitchIsVisited(_ sender: UISwitch) {
        delegate?.restaurantCustomTableViewCell2(cell: self, didSwithIsVisited: sender.isOn)
    }

}
