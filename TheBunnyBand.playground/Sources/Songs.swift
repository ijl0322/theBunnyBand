//
//  Songs.swift
//  band
//
//  Created by Isabel  Lee on 21/03/2017.
//  Copyright © 2017 Isabel  Lee. All rights reserved.
//

import UIKit

//Defines a class that represents songs. 
//This allows the program to preload songs into the edit pannel without the user composing the song
class Songs {
    
    //MARK: Variables
    let tNotes = ["Mi_h", "Mi_h", "Fa_h", "So_h", "None",
                  "So_h", "Fa_h", "Mi_h", "Re_h", "None",
                  "Do_h", "Do_h", "Re_h", "Mi_h", "None",
                  "Mi_h", "None", "Re_h", "Re_h", "None"]
    let dNotes = ["single", "single", "double", "double", "None",
                  "single", "single", "double", "double", "None",
                  "single", "single", "double", "double", "None",
                  "triple", "None", "single", "single", "None"]
    let sNotes = ["Do_h", "Do_h", "Re_h", "Mi_h", "None",
                  "Mi_h", "Re_h", "Do_h", "Ti", "None",
                  "Do", "Do", "Ti", "Do_h", "None",
                  "Mi_h", "None", "Ti", "Ti", "None"]
    let vNotes = ["Mi_h", "Mi_h", "Fa_h", "So_h", "None",
                  "So_h", "Fa_h", "Mi_h", "Re_h", "None",
                  "Do_h", "Do_h", "Re_h", "Mi_h", "None",
                  "Mi_h", "None", "Re_h", "Re_h", "None"]

    //MARK: Initializer
    init(){

    }
    
    //Returns an array of composed notes, representing Beethoven's famous composition - Symphony No. 9
    // (ode to Joy)
    
    func odeToJoy() -> [ComposedNotes]{
        var notes: [ComposedNotes] = []
    
        for i in 0..<tNotes.count{
            let newComposedNote = ComposedNotes(tNoteName: tNotes[i], sNoteName: sNotes[i], dNoteName: dNotes[i], vNoteName: vNotes[i])
            if let lastElement = notes.last {
                lastElement.next = newComposedNote
            }
            notes.append(newComposedNote)
        }
        return notes
    }
    
    //Return an array of string(name of notes) of the instrument trombone.
    //For the song ode to joy.
    func odeToJoyTrombone() -> [String] {
        return self.tNotes
    }
    
    //Return an array of string(name of notes) of the instrument drum.
    //For the song ode to joy.
    func odeToJoyDrum() -> [String] {
        return self.dNotes
    }
    
    //Return an array of string(name of notes) of the instrument saxphone.
    //For the song ode to joy.
    func odeToJoySaxphone() -> [String] {
        return self.sNotes
    }
    
    //Return an array of string(name of notes) of the instrument violin.
    //For the song ode to joy.
    func odeToJoyViolin() -> [String] {
        return self.vNotes
    }
}
