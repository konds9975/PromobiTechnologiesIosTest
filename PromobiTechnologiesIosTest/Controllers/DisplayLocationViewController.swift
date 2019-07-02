//
//  DisplayLocationViewController.swift
//  PromobiTechnologiesIosTest
//
//  Created by Kondya on 02/07/19.
//  Copyright © 2019 Fortune4. All rights reserved.
//

import UIKit
import MapKit

class DisplayLocationViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    var locationInfo : LocationInfo?
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        if let locationInfo = self.locationInfo {
            self.addAnnotation(location: locationInfo)
        }
  
    }
    func addAnnotation(location: LocationInfo){
        
        let lattitude = Double(locationInfo?.lattitude ?? "0")!
        let longitude = Double(locationInfo?.longitude ?? "0")
        let annotation = MKPointAnnotation()
        annotation.coordinate.latitude = lattitude
        annotation.coordinate.longitude = longitude ?? 0.0
        annotation.title = "Lattitude: \(locationInfo?.lattitude ?? "")\nLongitude: \(locationInfo?.longitude ?? "")\nBattery: \((locationInfo?.battery ?? 0)*100)%\nTime and Date: \(locationInfo?.datetime?.toString() ?? "NA")"
        self.mapView.addAnnotation(annotation)
    }

}
