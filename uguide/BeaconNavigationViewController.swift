//
//  BeaconNavigationViewController.swift
//  uguide
//
//  Created by Sebastian Frelle Koch on 4/16/18.
//  Copyright © 2018 Sebastian Frelle Koch. All rights reserved.
//

import UIKit
import os.log

class BeaconNavigationViewController: UIViewController {
    
    //MARK: Views
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var beaconViews: [BeaconView]!
    
    @IBOutlet weak var lowerRightBeaconView: BeaconView!
    @IBOutlet weak var lowerLeftBeaconView: BeaconView!
    @IBOutlet weak var upperRightBeaconView: BeaconView!
    @IBOutlet weak var upperLeftBeaconView: BeaconView!
    
    var beacons: [Beacon]?
    
    //MARK: Properties
    var outerBeeCenter: CGPoint = CGPoint.zero
    var innerBeeCenter: CGPoint = CGPoint.zero
    var centers = [BeaconView: CGPoint]()
    
    var proximityNavigationController: ProximityNavigationController?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupBeacons()
        guard let beacons = self.beacons else {
            os_log("Failed to set up beacons", log: .default, type: .error)
            return
        }
        
        self.proximityNavigationController = ProximityNavigationController.setup(for: beacons)
        self.proximityNavigationController?.startListening()
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        scrollView.delegate = self
        
        // Build dictionary of centers
        for beaconView in beaconViews {
            centers[beaconView] = beaconView.center
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.proximityNavigationController?.stopListening()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupBeacons() {
        self.beacons = [
            Beacon(state: .deactivated, identifier: "322", location: "lower_right", view: lowerRightBeaconView),
            Beacon(state: .deactivated, identifier: "323", location: "lower_left", view: lowerLeftBeaconView),
            Beacon(state: .deactivated, identifier: "324", location: "upper_right", view: upperRightBeaconView),
            Beacon(state: .deactivated, identifier: "325", location: "upper_left", view: upperLeftBeaconView)
        ]
    }
}

extension BeaconNavigationViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let scale = CGAffineTransform.identity.scaledBy(x: scrollView.zoomScale, y: scrollView.zoomScale)
        
        for beaconView in beaconViews {
            updateBeaconPosition(beaconView: beaconView, scale: scale)
        }
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        let scaleAffineTransform = CGAffineTransform.identity.scaledBy(x: scale, y: scale)
        scrollView.contentSize = self.imageView.bounds.size.applying(scaleAffineTransform)
    }

    private func updateBeaconPosition(beaconView: BeaconView, scale: CGAffineTransform) {
        guard !centers.isEmpty else {
            fatalError("Centers dictionary was empty")
        }
        
        guard let beaconViewCenter = centers[beaconView] else {
            fatalError("Center not set for beacon \(beaconView)")
        }
        
        let translatedPoint = beaconViewCenter.applying(scale)
        beaconView.transform = CGAffineTransform.identity.translatedBy(
            x: translatedPoint.x - beaconViewCenter.x,
            y: translatedPoint.y - beaconViewCenter.y)
    }
}
