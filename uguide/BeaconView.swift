//
//  BeaconView.swift
//  uguide
//
//  Created by Sebastian Frelle Koch on 4/23/18.
//  Copyright © 2018 Sebastian Frelle Koch. All rights reserved.
//

import UIKit

class BeaconView: UIImageView {
    enum State {
        case activated, deactivated
    }
    
    var state: State = .deactivated
    
    func activate() {
        state = .activated
        image = #imageLiteral(resourceName: "BeaconActivated")
    }
    
    func deactivate() {
        state = .deactivated
        image = #imageLiteral(resourceName: "BeaconDeactivated")
    }
}
