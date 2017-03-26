//
//  SharedNoneNotes.swift
//  band
//
//  Created by Isabel  Lee on 23/03/2017.
//  Copyright © 2017 Isabel  Lee. All rights reserved.
//

//Deines a singleton, representing none notes (used when a particular instrument is not playing
//during that time frame) of a particular instrument.

class SharedNoneNote {
    
    //MARK: Variables
    static let violin = ViolinNotes(name: "None")
    static let saxphone = SaxphoneNotes(name: "None")
    static let trombone = TromboneNotes(name: "None")
    static let drum = DrumNotes(name: "None")
    
    //MARK: Initializer
    private init() {}
    
}

