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
    
    init?(name: String, id: String, courseLocation: CourseLocation? = nil) {
        if name.isEmpty || id.isEmpty {
            return nil
        }

        self.name = name
        self.id = id
        self.courseLocation = courseLocation
    }

    required convenience init?(coder aDecoder: NSCoder) {
        print("what")
        self.init(name: "", id: "")
    }
}

struct CourseLocation {
    var campus: Campus
    var building: Building
    var room: Room
    
    init(campus: Campus, building: Building, room: Room) {
        self.campus = campus
        self.building = building
        self.room = room
    }
}
