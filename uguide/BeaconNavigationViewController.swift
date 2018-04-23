//
//  BeaconNavigationViewController.swift
//  uguide
//
//  Created by Sebastian Frelle Koch on 4/16/18.
//  Copyright © 2018 Sebastian Frelle Koch. All rights reserved.
//

import UIKit

class BeaconNavigationViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet var beacons: [BeaconView]!
    
    var outerBeeCenter: CGPoint = CGPoint.zero
    var innerBeeCenter: CGPoint = CGPoint.zero
    
    var centers = [BeaconView: CGPoint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        scrollView.delegate = self
        
        // Build dictionary of centers
        for beacon in beacons {
            centers[beacon] = beacon.center
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension BeaconNavigationViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let scale = CGAffineTransform.identity.scaledBy(x: scrollView.zoomScale, y: scrollView.zoomScale)
        
        for beacon in beacons {
            updateBeaconPosition(beacon: beacon, scale: scale)
        }
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        let scaleAffineTransform = CGAffineTransform.identity.scaledBy(x: scale, y: scale)
        scrollView.contentSize = self.imageView.bounds.size.applying(scaleAffineTransform)
    }

    private func updateBeaconPosition(beacon: BeaconView, scale: CGAffineTransform) {
        guard !centers.isEmpty else {
            fatalError("Centers dictionary was empty")
        }
        
        guard let beaconCenter = centers[beacon] else {
            fatalError("Center not set for beacon \(beacon)")
        }
        
        let translatedPoint = beaconCenter.applying(scale)
        beacon.transform = CGAffineTransform.identity.translatedBy(
            x: translatedPoint.x - beaconCenter.x,
            y: translatedPoint.y - beaconCenter.y)
    }
}
