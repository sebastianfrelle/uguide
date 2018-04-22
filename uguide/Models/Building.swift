//
//  Building.swift
//  uguide
//
//  Created by Sebastian Frelle Koch on 3/12/18.
//  Copyright © 2018 Sebastian Frelle Koch. All rights reserved.
//

import UIKit

struct Building: Model {
    var name: String
    var floors: [Floor]
    
    var dictionary: [String: Any] {
        return [
            "name": name,
            "floors": floors,
        ]
    }
}

