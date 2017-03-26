//
//  SaxphoneSlots.swift
//  band
//
//  Created by Isabel  Lee on 19/03/2017.
//  Copyright © 2017 Isabel  Lee. All rights reserved.
//

import UIKit

//Defines a subclass of NoteSlots, which only holds saxphone notes.
class SaxphoneSlots: NoteSlots {
 
    //MARK: Initializer
    override required init(x: Double, y: Double) {
        super.init(x: x, y: y)
        self.instrument = Instruments.Saxphone
        self.image = UIImage(named: "saxphone/s_None")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

