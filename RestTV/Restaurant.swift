//
//  Restaurant.swift
//  RestTV
//
//  Created by Анастасия on 27.09.16.
//  Copyright © 2016 Anastasia. All rights reserved.
//

import Foundation

class Restaurant {
    var name = ""
    var phone = ""
    var adress = ""
    var image = ""
    var isVisited = false
    var rating = ""
    
    init(name: String, phone: String, adress: String, image: String, isVisited: Bool, rating: String) {
        self.name = name
        self.phone = phone
        self.adress = adress
        self.image = image
        self.isVisited = isVisited
        self.rating = rating
    }
}
