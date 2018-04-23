//
//  AppDelegate.swift
//  uguide
//
//  Created by Sebastian Frelle Koch on 4/16/18.
//  Copyright © 2018 Sebastian Frelle Koch. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import EstimoteProximitySDK

var GoogleMapsApiKey = "AIzaSyBoomyx6d-pqbuAANE4Bw7vUU1p_959evM"
var GooglePlacesApiKey = "AIzaSyBB5HYutW3zGi6nih4aqygFteAF5Jl3Xyc"
var EstimoteAppId = "sebastian-frelle-gmail-com-5ve"
var EstimoteAppToken = "604d08ce391572487e3d0c2395562cca"

import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // 1. Add a property to hold the Proximity Observer
    
    var window: UIWindow?
    var proximityObserver: EPXProximityObserver!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Firebase setup
        FirebaseApp.configure()
        
        // Google service setup
        GMSServices.provideAPIKey(GoogleMapsApiKey)
        GMSPlacesClient.provideAPIKey(GooglePlacesApiKey)
        
        // Estimote credentialslet
        let cloudCredentials = EPXCloudCredentials(appID: EstimoteAppId, appToken: EstimoteAppToken)
        self.proximityObserver = EPXProximityObserver(
            credentials: cloudCredentials,
            errorBlock: { error in
                print("proximity observer error: \(error)")
        })
        
        let beacon = EPXProximityZone(
            range: EPXProximityRange(desiredMeanTriggerDistance: 10.0)!,
            attachmentKey: "room", attachmentValue: "Orange Rounded Table")
        beacon.onEnterAction = { _ in
            
            
        }
        beacon.onExitAction = { _ in print("Colder...") }
        
        self.proximityObserver.startObserving([beacon])
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

