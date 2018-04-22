//
//  Room.swift
//  uguide
//
//  Created by Sebastian Frelle Koch on 3/12/18.
//  Copyright © 2018 Sebastian Frelle Koch. All rights reserved.
//

import UIKit

struct Room: Model {
    var name: String
    var beacons: [Beacon]
    
    init(name: String, beacons: [Beacon] = [Beacon]()) {
        self.name = name
        self.beacons = beacons
    }
    
    var dictionary: [String : Any] {
        return [
            "name": name,
            "beacons": beacons,
        ]
    }
}
