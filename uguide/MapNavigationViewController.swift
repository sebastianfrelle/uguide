//
//  MapNavigationViewController.swift
//  uguide
//
//  Created by Sebastian Frelle Koch on 4/16/18.
//  Copyright © 2018 Sebastian Frelle Koch. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit
import CoreLocation

class MapNavigationViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    let locationManager=CLLocationManager()
    @IBOutlet weak var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    guard status == .authorizedWhenInUse else {
    return
    }
    locationManager.startUpdatingLocation()
    mapView.isMyLocationEnabled = true
    mapView.settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        print("Location = \(location.coordinate)")
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        locationManager.stopUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

}
