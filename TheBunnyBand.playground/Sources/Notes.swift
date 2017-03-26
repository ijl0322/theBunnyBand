//
//  Notes.swift
//  band
//
//  Created by Isabel  Lee on 16/03/2017.
//  Copyright © 2017 Isabel  Lee. All rights reserved.
//

import UIKit
import AVFoundation


//Defines the Notes class, representing a single music note of one particular instrument.

class Notes {
    
    //MARK: Variables
    let name: String
    var audioFile: AVAudioPlayer!
    
    
    //MARK: Initializer
    required init(name: String) {
        self.name = name
        let audioFileURL = URL(fileURLWithPath: Bundle.main.path(forResource: name, ofType: "wav")!)
        
        do {
            try audioFile = AVAudioPlayer(contentsOf: audioFileURL as URL, fileTypeHint: nil)
            audioFile.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
    }
    
    //Plays the audio file of the note
    func playNote() {
        audioFile.play()
    }
}
