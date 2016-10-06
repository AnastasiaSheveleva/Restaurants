//
//  MapViewController.swift
//  RestTV
//
//  Created by Анастасия on 29.09.16.
//  Copyright © 2016 Anastasia. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    var restaurant: Restaurant!
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self

        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString("Россия, Санкт-Петербург, " + restaurant.adress, completionHandler: { placemarks, error in
            if  error != nil {
                print(error)
                return
                }
            
                if let placemarks = placemarks {
                    let placemark = placemarks[0]
                
                    let annotation = MKPointAnnotation()
                    annotation.title = self.restaurant.name
                    annotation.subtitle = self.restaurant.adress
                
                    if let location = placemark.location {
                        annotation.coordinate = location.coordinate
                    
                        self.mapView.showAnnotations([annotation], animated: true)
                        self.mapView.selectAnnotation(annotation, animated: true)
                    }
                }
            })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        let identifer = "myPin"
        var annotationView: MKAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifer)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifer)
            annotationView?.canShowCallout = true
        }
        
        let leftIconView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        leftIconView.image = UIImage(data: restaurant.image! as Data)
        annotationView?.leftCalloutAccessoryView = leftIconView
        annotationView?.image = UIImage(named: "pin1")
        
        return annotationView
    }
    
}
