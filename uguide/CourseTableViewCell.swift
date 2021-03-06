//
//  CourseTableViewCell.swift
//  uguide
//
//  Created by Sebastian Frelle Koch on 4/16/18.
//  Copyright © 2018 Sebastian Frelle Koch. All rights reserved.
//

import UIKit

class CourseTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var courseID: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    // Configure the view for the selected state
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //Sets the name of each cell
    func populate(course: Course) {        
        courseName.text = course.name
        courseID.text = course.id
    }

}
