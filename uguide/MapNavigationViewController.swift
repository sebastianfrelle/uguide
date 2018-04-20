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

class MapNavigationViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager=CLLocationManager()
    //var mapView = GMSMapView();
    var camera = GMSCameraPosition();
    @IBOutlet weak var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.delegate=self
            self.locationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        print("Locations = \(locValue.latitude) \(locValue.longitude)")
        
        camera=GMSCameraPosition.camera(withLatitude: locValue.latitude, longitude: locValue.longitude , zoom: 14)
        
        mapView = GMSMapView.map(withFrame: .zero, camera: camera)
        //self.view = mapView;
        mapView.settings.myLocationButton=true
        mapView.isMyLocationEnabled=true
        //manager.stopUpdatingLocation()
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
