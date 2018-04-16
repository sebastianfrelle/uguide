//
//  User.swift
//  uguide
//
//  Created by Hannibal B. Moulvad on 26/02/2018.
//  Copyright © 2018 Sebastian Frelle Koch. All rights reserved.
//

import UIKit

class User: Model {
    var name: String
    var courses = [String]()
    
    init(name: String, courses: [String]) {
        self.name = name
        self.courses = courses
    }
    
}




