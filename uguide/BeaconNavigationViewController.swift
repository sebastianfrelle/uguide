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
    @IBOutlet weak var nestedImageView: UIImageView!
    
    var outerBeeCenter: CGPoint = CGPoint.zero
    var innerBeeCenter: CGPoint = CGPoint.zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outerBeeCenter = imageView.center
        innerBeeCenter = nestedImageView.center
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        scrollView.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension BeaconNavigationViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let scaleAffineTransform = CGAffineTransform.identity.scaledBy(x: scrollView.zoomScale, y: scrollView.zoomScale)
        
//        var translatedPoint = outerBeeCenter.applying(scaleAffineTransform)
//        imageView.transform = CGAffineTransform.identity.translatedBy(
//            x: translatedPoint.x - outerBeeCenter.x,
//            y: translatedPoint.y - outerBeeCenter.y)
        
        let translatedPoint = innerBeeCenter.applying(scaleAffineTransform)
        nestedImageView.transform = CGAffineTransform.identity.translatedBy(
            x: translatedPoint.x - innerBeeCenter.x,
            y: translatedPoint.y - innerBeeCenter.y)
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        let scaleAffineTransform = CGAffineTransform.identity.scaledBy(x: scale, y: scale)
        scrollView.contentSize = self.imageView.bounds.size.applying(scaleAffineTransform)
    }
}
