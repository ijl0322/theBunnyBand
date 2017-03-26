//
//  NoteButtons.swift
//  band
//
//  Created by Isabel  Lee on 16/03/2017.
//  Copyright © 2017 Isabel  Lee. All rights reserved.
//


//Defines a subclass of an UIImageView, representing a note button. 
//A note button is a button that shows the image of the name of the note of a particular instrument.
//When tapped, the note button will play note with a particular instrument
import UIKit
class NoteButtons: UIImageView, UIGestureRecognizerDelegate {
    
    //MARK: Variables
    let noteSize = size.noteSize.rawValue
    var instrument: Instruments!
    var name: String!
    var fullName: String!
    var originalX: Double!
    var originalY: Double!
    
    //MARK: Initializer
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(name: String, x: Double, y: Double) {
        super.init(frame: CGRect(x: x , y: y, width: noteSize, height: noteSize))
        self.fullName = name
        self.name = name
        self.isUserInteractionEnabled = true
        self.instrument = Instruments.None
        self.originalX = x + noteSize/2
        self.originalY = y + noteSize/2
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        tapGestureRecognizer.delegate = self
        self.addGestureRecognizer(tapGestureRecognizer)
    }
    
    //MARK: Gesture Recognizer Function
    
    //Plays the note when the button is tapped
    func handleTap(_: UITapGestureRecognizer){
        SharedAudioPlayer.player.playNote(name: fullName)
    }
}
