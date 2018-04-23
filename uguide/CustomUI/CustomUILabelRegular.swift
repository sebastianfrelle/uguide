//
//  CustomUILabelRegular.swift
//  uguide
//
//  Created by Hannibal B. Moulvad on 23/04/2018.
//  Copyright © 2018 Sebastian Frelle Koch. All rights reserved.
//

import UIKit

class CustomUILabelRegular: UILabel {
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    func commonInit() {
        self.font = UIFont(name: "Lato-Regular.ttf", size: 12)
    }
}
