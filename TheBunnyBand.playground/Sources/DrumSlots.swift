//
//  DrumSlots.swift
//  band
//
//  Created by Isabel  Lee on 19/03/2017.
//  Copyright © 2017 Isabel  Lee. All rights reserved.
//

import UIKit

//Defines a subclass of NoteSlots, which only holds drum notes.
class DrumSlots: NoteSlots {

    //MARK: Initializer
    override required init(x: Double, y: Double) {
        super.init(x: x, y: y)
        self.instrument = Instruments.Drum
        self.image = UIImage(named: "drum/d_None")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

