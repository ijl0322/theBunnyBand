//
//  SharedAudioPlayer.swift
//  band
//
//  Created by Isabel  Lee on 21/03/2017.
//  Copyright © 2017 Isabel  Lee. All rights reserved.
//

import AVFoundation

//Defines a singleton, an audio player shared by all note buttons.
class SharedAudioPlayer {
    
    //MARK: Variables
    static let player = SharedAudioPlayer()
    var audioFile: AVAudioPlayer!
    
    //MARK: Initializer
    private init() {}
    
    func playNote(name: String) {
        let audioFileURL = URL(fileURLWithPath: Bundle.main.path(forResource: name, ofType: "wav")!)
        
        do {
            try audioFile = AVAudioPlayer(contentsOf: audioFileURL as URL, fileTypeHint: nil)
            audioFile.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        audioFile.play()
    }

}
