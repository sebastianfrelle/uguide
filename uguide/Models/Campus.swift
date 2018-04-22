//
//  Campus.swift
//  uguide
//
//  Created by Sebastian Frelle Koch on 3/12/18.
//  Copyright © 2018 Sebastian Frelle Koch. All rights reserved.
//

import UIKit

struct Campus: Model {
    var name: String
    
    var dictionary: [String : Any] {
        return [
            "name": name,
        ]
    }
}
