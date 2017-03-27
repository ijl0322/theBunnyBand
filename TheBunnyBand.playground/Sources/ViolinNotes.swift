//
//  ViolinNotes.swift
//  band
//
//  Created by Isabel  Lee on 23/03/2017.
//  Copyright © 2017 Isabel  Lee. All rights reserved.
//

import UIKit

//Defines a subclass of Notes, which can only represent a note of the violin.
class ViolinNotes: Notes {
    
    //MARK: Initializer
    required init(name: String) {
        let newName = "violin/v_" + name
        //print("\(newName)")
        super.init(name: newName)
    }
}
