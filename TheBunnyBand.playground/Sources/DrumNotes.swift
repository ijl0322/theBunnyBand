//
//  DrumNotes.swift
//  band
//
//  Created by Isabel  Lee on 19/03/2017.
//  Copyright © 2017 Isabel  Lee. All rights reserved.
//

import UIKit

//Defines a subclass of Notes, which can only represent a note of the drum.
class DrumNotes: Notes {
    
    //MARK: Initializer
    required init(name: String) {
        let newName = "drum/d_" + name
        //print("\(newName)")
        super.init(name: newName)
    }
}
