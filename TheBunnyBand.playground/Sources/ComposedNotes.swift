//
//  ComposedNotes.swift
//  band
//
//  Created by Isabel  Lee on 18/03/2017.
//  Copyright © 2017 Isabel  Lee. All rights reserved.
//

import UIKit

//A protocol that passes the information that the status of the music
protocol MusicStatusDelegate: class {
    func musicEnded()
}

//At any given time, there could be four instruments playing at the same time.
//The CompsoedNotes represents a single time frame, and keeps track of the notes being played 
//by the four instruments in this time frame. 
//The ConposedNotes is linked to each other like a linked list, when a note is done playing, 
//the next note is accessed through the next property.
class ComposedNotes {
    
    //MARK: Variables
    weak var delegate: MusicStatusDelegate?
    var tNote: Notes
    var sNote: Notes
    var dNote: Notes
    var vNote: Notes
    var tNone = SharedNoneNote.trombone
    var sNone = SharedNoneNote.saxphone
    var dNone = SharedNoneNote.drum
    var vNone = SharedNoneNote.violin
    var next: ComposedNotes?
    
    //MARK: Initializer
    init(tNoteName: String = "None", sNoteName: String = "None", dNoteName: String = "None", vNoteName: String = "None") {
        tNote = TromboneNotes(name: tNoteName)
        sNote = SaxphoneNotes(name: sNoteName)
        dNote = DrumNotes(name: dNoteName)
        vNote = ViolinNotes(name: vNoteName)
    }
    
    //MARK: Control functions
    
    //Adds a trombone note to the composed note. 
    //Will replace the previous trombone note.
    func addTNote(note: String) {
        tNote = TromboneNotes(name: note)
    }

    //Adds a saxphone note to the composed note.
    //Will replace the previous saxphone note.
    func addSNote(note: String) {
        sNote = SaxphoneNotes(name: note)
    }
    
    //Adds a drum note to the composed note.
    //Will replace the previous drum note.
    func addDNote(note: String) {
        dNote = DrumNotes(name: note)
    }
    
    //Adds a violin note to the composed note.
    //Will replace the previous violin note.
    func addVNote(note: String) {
        vNote = ViolinNotes(name: note)
    }
    
    //Play the current composed note. 
    //If there is a next note, play the next note until there are no more next note.
    //If there are not more next notes, use the music status delegate to signify that music has ended.ß
    func playSong() {
        tNote.playNote()
        sNote.playNote()
        dNote.playNote()
        vNote.playNote()
        if let nextNote = self.next {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                print("playing next")
                nextNote.playSong()
            }
        } else {
            delegate?.musicEnded()
            print("song ended")
        }
    }
    
    //Set the notes of all instruments to None
    func clearNote() {
        tNote = tNone
        dNote = dNone
        sNote = sNone
        vNote = vNone
    }
}
