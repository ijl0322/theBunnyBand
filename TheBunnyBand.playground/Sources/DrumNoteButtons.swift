//
//  DrumNoteButtons.swift
//  band
//
//  Created by Isabel  Lee on 19/03/2017.
//  Copyright © 2017 Isabel  Lee. All rights reserved.
//

import UIKit

//Defines a subclass of NoteButtons, which can only be a note button for the drum.
class DrumNoteButtons: NoteButtons {
    
    //MARK: Initializer
    required override init(name: String, x: Double, y: Double) {
        super.init(name: name, x: x, y: y)
        self.fullName = "drum/d_" + name
        self.image = UIImage(named: self.fullName)
        self.instrument = Instruments.Drum
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
