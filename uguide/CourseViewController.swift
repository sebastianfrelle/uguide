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

    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var courseID: UILabel!

    @IBOutlet weak var campus: UILabel!
    @IBOutlet weak var building: UILabel!
    @IBOutlet weak var room: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let course = course {
            // Set navigation bar title
            title = "\(course.id): \(course.name)"
            
            courseName.text = course.name
            courseID.text = course.id
            
            if let courseLocation = course.courseLocation {
                campus.text = courseLocation.campus.name
                building.text = courseLocation.building.name
                room.text = courseLocation.room.name
            }
        }
        

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
