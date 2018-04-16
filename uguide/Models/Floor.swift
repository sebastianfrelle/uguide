//
//  Floor.swift
//  uguide
//
//  Created by Sebastian Frelle Koch on 3/12/18.
//  Copyright © 2018 Sebastian Frelle Koch. All rights reserved.
//

import UIKit

class Floor: Model {
    var rooms: [Room]
    
    init(rooms: [Room] = [Room]()) {
        self.rooms = rooms
    }
}
