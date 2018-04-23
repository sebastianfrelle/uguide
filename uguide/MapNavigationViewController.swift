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
import Alamofire
import SwiftyJSON
import EstimoteProximitySDK

class MapNavigationViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var region = CLCircularRegion()
    let locationManager = CLLocationManager()
    var placesClient: GMSPlacesClient!
    let estimoteCloudCredentials = EPXCloudCredentials(appID: "sebastian-frelle-gmail-com-5ve", appToken: "604d08ce391572487e3d0c2395562cca")
    
    var placeId: String?
    var locationStart = CLLocation()
    var didEndLocationSet = false
    var locationEnd = CLLocation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.delegate = self
        placesClient = GMSPlacesClient.shared()
        lookUpPlaceID()
    }
    
    func lookUpPlaceID() {
        guard let placeId = placeId else {
            fatalError("No placeId set")
        }
        
        placesClient.lookUpPlaceID(placeId, callback: { (place, error) -> Void in
            if let error = error {
                print("lookup place id query error: \(error.localizedDescription)")
                return
            }
            if let place = place {
                print("Place name \(place.name)")
                print("Place address \(String(describing: place.formattedAddress))")
                print("Place placeID \(place.placeID)")
                print("Place coordinate \(place.coordinate)")
                
                // Sets end location coordinates
                self.locationEnd = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
                let radius = CLLocationDistance(60)
                self.region = CLCircularRegion(center: self.locationEnd.coordinate, radius: radius, identifier: place.name)
                self.didEndLocationSet = true
                self.createMarker(titleMarker: place.name, latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            }
            else {
                print("No place details for \(placeId)")
            }
        })
    }
    // MARK: Function to create marker
    func createMarker(titleMarker: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.title = titleMarker
        marker.map = mapView
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
        guard let locationStart = locations.first else {
            return
        }
        print("Location = \(locationStart.coordinate)")
        //Sets the start location variable
        mapView.camera = GMSCameraPosition(target: locationStart.coordinate, zoom: 14, bearing: 0, viewingAngle: 0)
        
        if didEndLocationSet {
            drawPath(startLocation: locationStart, endLocation: locationEnd)
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        //change view
    }
    
    //MARK: - this is function for create direction path, from start location to desination location
    func drawPath(startLocation: CLLocation, endLocation: CLLocation)
    {
        print(startLocation.coordinate, "Start Location")
        print(endLocation.coordinate, "End Location")
        let origin = "\(startLocation.coordinate.latitude),\(startLocation.coordinate.longitude)"
        let destination = "\(endLocation.coordinate.latitude),\(endLocation.coordinate.longitude)"
        
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=walking"
        
        Alamofire.request(url).responseJSON { response in
            
            print(response.request as Any)  // original URL request
            print(response.response as Any) // HTTP URL response
            print(response.data as Any)     // server data
            print(response.result as Any)   // result of response serialization
            
            let json = try? JSON(data: response.data!)
            let routes = json!["routes"].arrayValue
            print(routes)
            
            for route in routes
            {
                let routeOverviewPolyline = route["overview_polyline"].dictionary
                let points = routeOverviewPolyline?["points"]?.stringValue
                let path = GMSPath.init(fromEncodedPath: points!)
                let polyline = GMSPolyline.init(path: path)
                polyline.strokeWidth = 4
                polyline.strokeColor = UIColor.red
                polyline.map = self.mapView
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
        //proximityObserver.stopObservingZones()
    }
}
