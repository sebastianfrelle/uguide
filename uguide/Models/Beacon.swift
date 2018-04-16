//
//  Beacon.swift
//  uguide
//
//  Created by Sebastian Frelle Koch on 3/12/18.
//  Copyright © 2018 Sebastian Frelle Koch. All rights reserved.
//

import UIKit

class Beacon: Model {
    var position: Position
    
    init(x: Double, y: Double) {
        self.position = Position(x, y)
    }    
}

struct Position {
    var x, y: Double
    
    init(_ x: Double, _ y: Double) {
        self.x = x
        self.y = y
    }
}
