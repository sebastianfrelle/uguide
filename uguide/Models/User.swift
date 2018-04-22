//
//  User.swift
//  uguide
//
//  Created by Hannibal B. Moulvad on 26/02/2018.
//  Copyright © 2018 Sebastian Frelle Koch. All rights reserved.
//

import UIKit

struct User: Model {
    var name: String
    var courses = [String]()
    
    var dictionary: [String : Any] {
        return [
            "name": name,
            "courses": courses,
        ]
    }
}
