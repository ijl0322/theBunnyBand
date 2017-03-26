//
//  NoteSlots.swift
//  band
//
//  Created by Isabel  Lee on 17/03/2017.
//  Copyright © 2017 Isabel  Lee. All rights reserved.
//

import UIKit

//Defines a subclass of an UIImageView, representing an empty slot that can hold a single note of 
//a particular instrument. The user can drag notes into the slots to compose music.

class NoteSlots: UIImageView, UIGestureRecognizerDelegate {
    
    //MARK: Variables
    let noteSize = size.noteSize.rawValue
    var instrument: Instruments!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Initializer
    init(x: Double, y: Double) {
        super.init(frame: CGRect(x: x , y: y, width: noteSize, height: noteSize))
        self.instrument = Instruments.None
        self.isUserInteractionEnabled = true
    }
}
