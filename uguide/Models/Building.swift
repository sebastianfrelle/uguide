//
//  Building.swift
//  uguide
//
//  Created by Sebastian Frelle Koch on 3/12/18.
//  Copyright © 2018 Sebastian Frelle Koch. All rights reserved.
//

import UIKit

class Building: Model {
    var name: String
    var floors: [Floor]
    
    init(name: String, floors: [Floor] = [Floor]()) {
        self.name = name
        self.floors = floors
    }
}
