//
//  TromboneNoteButtons.swift
//  band
//
//  Created by Isabel  Lee on 17/03/2017.
//  Copyright © 2017 Isabel  Lee. All rights reserved.
//


import UIKit

//Defines a subclass of NoteButtons, which can only be a note button for the trombone.
class TromboneNoteButtons: NoteButtons {

    //MARK: Initializer
    required override init(name: String, x: Double, y: Double) {
        super.init(name: name, x: x, y: y)
        self.fullName = "trombone/t_" + name
        self.image = UIImage(named: self.fullName)
        self.instrument = Instruments.Trombone
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
