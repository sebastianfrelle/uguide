//
//  CourseViewController.swift
//  uguide
//
//  Created by Sebastian Frelle Koch on 4/16/18.
//  Copyright © 2018 Sebastian Frelle Koch. All rights reserved.
//

import UIKit

class CourseViewController: UIViewController {
    //MARK: Properties
    var course: Course?
    
    //MARK: Views
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var courseID: UILabel!
    @IBOutlet weak var campus: UILabel!
    @IBOutlet weak var building: UILabel!
    @IBOutlet weak var room: UILabel!
    @IBOutlet weak var takeMeThereBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Styles the button
        takeMeThereBtn.layer.cornerRadius = 6
        
        guard let course = course else {
            fatalError("No course set")
        }
        
        // Set navigation bar title and textlabel titles
        title = "\(course.id): \(course.name)"
        courseName.text = course.name
        courseID.text = course.id
        campus.text = course.courseLocation.campus
        building.text = course.courseLocation.building
        room.text = course.courseLocation.room
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    @IBAction func unwindToCourseView(sender: UIStoryboardSegue) {
        //print(sender)
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        let segueId = segue.identifier ?? ""
        switch (segueId) {
        case "NavigateToCourse":
            guard let destinationViewController = segue.destination as? UINavigationController else {
                fatalError("Expected destination UINavigationController; got \(segue.destination)")
            }
            
            guard let mapViewController = destinationViewController.viewControllers.first as? MapNavigationViewController else {
                fatalError("First VC of Nav View Controller \(destinationViewController) is not a MapNavigationViewController")
            }
            
            guard let placeId = course?.placeId else {
                fatalError("course not set")
            }
            
            mapViewController.placeId = placeId
        default:
            fatalError("Segue with unknown identifier: \(segueId)")
        }
    }
    
}
