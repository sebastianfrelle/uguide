//
//  Model.swift
//  uguide
//
//  Created by Sebastian Frelle Koch on 3/12/18.
//  Copyright © 2018 Sebastian Frelle Koch. All rights reserved.
//

import UIKit

class Model {
    var uid: String
    
    init() {
        self.uid = UUID().uuidString
    }
}
