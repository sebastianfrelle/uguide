//
//  University.swift
//  uguide
//
//  Created by Sebastian Frelle Koch on 3/12/18.
//  Copyright © 2018 Sebastian Frelle Koch. All rights reserved.
//

import UIKit

struct University: Model {
    var name: String
    var courses: [Course]?
    
    var dictionary: [String: Any] {
        return [
            "name": name,
            "courses": courses,
        ]
    }
}
