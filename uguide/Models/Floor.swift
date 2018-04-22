//
//  Floor.swift
//  uguide
//
//  Created by Sebastian Frelle Koch on 3/12/18.
//  Copyright © 2018 Sebastian Frelle Koch. All rights reserved.
//

import UIKit

struct Floor: Model {
    var rooms: [Room]
    
    var dictionary: [String : Any] {
        return [
            "rooms": rooms,
        ]
    }
}
