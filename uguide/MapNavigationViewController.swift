//
//  MapNavigationViewController.swift
//  uguide
//
//  Created by Sebastian Frelle Koch on 4/16/18.
//  Copyright © 2018 Sebastian Frelle Koch. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import GooglePlaces

class MapNavigationViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager=CLLocationManager()
    var placesClient: GMSPlacesClient!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        placesClient = GMSPlacesClient.shared()
        lookUpPlaceID()
    }
    
    func lookUpPlaceID() {
        let placeID = "ChIJ__anOmNOUkYR86hP1LlgQic"
        placesClient.lookUpPlaceID(placeID, callback: { (place, error) -> Void in
        if let error = error {
            print("lookup place id query error: \(error.localizedDescription)")
            return
        }
            if let place = place {
                print("Place name \(place.name)")
                print("Place address \(String(describing: place.formattedAddress))")
                print("Place placeID \(place.placeID)")
                print("Place placeID \(place.coordinate)")
                print("Place attributions \(String(describing: place.attributions))")
                let position = place.coordinate
                let marker = GMSMarker(position: position)
                marker.title = "DTU Lyngby"
                marker.snippet = "Bygning 302"
                marker.map = self.mapView
            }
            else {
                print("No place details for \(placeID)")
            }
        })
        
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
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 14, bearing: 0, viewingAngle: 0)
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
