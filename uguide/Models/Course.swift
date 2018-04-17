//
//  Courses.swift
//  uguide
//
//  Created by Hannibal B. Moulvad on 26/02/2018.
//  Copyright © 2018 Sebastian Frelle Koch. All rights reserved.
//

import UIKit

class Course: Model {
    var name: String
    var id: String
    var courseLocation: CourseLocation?
    
    init?(name: String, id: String, courseLocation: CourseLocation?) {
        if name.isEmpty {
            return nil
        }
        
        if id.isEmpty || id.count > 5 {
            return nil
        }

        self.name = name
        self.id = id
        self.courseLocation = courseLocation
    }
    
    convenience init?(name: String, id: String, campus: Campus, building: Building, room: Room) {
        let courseLocation = CourseLocation(campus: campus, building: building, room: room)
        
        self.init(name: name, id: id, courseLocation: courseLocation)
    }
}

struct CourseLocation {
    var campus: Campus
    var building: Building
    var room: Room
}
