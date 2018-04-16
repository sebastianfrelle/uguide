//
//  University.swift
//  uguide
//
//  Created by Sebastian Frelle Koch on 3/12/18.
//  Copyright © 2018 Sebastian Frelle Koch. All rights reserved.
//

import UIKit

class University: Model {
    var name: String
    var courses: [Course]?
    
    init(name: String, courses: [Course] = [Course]()) {
        self.name = name
//        Initialize course array
    }
}
