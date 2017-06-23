//
//  EditPannel.swift
//  band
//
//  Created by Isabel  Lee on 19/03/2017.
//  Copyright © 2017 Isabel  Lee. All rights reserved.
//

import Foundation
import UIKit

//Defines a subclass of UIView, representing the edit pannel for users to edit the song played by the 
//bunny band. 

class EditPannel: UIView {
    
    //MARK: Variables
    let allNotes = ["Do", "Re", "Mi", "Fa", "So", "La", "Ti", "Do_h", "Re_h", "Mi_h", "Fa_h", "So_h", "La_h", "Ti_h"]
    let allDrumNotes = ["single", "double", "triple"]
    let numSlots = 19
    let slotSize = size.noteSize.rawValue
    let buttonSize = size.noteSize.rawValue
    let bigControlButtonSize = size.controlButtonSize.rawValue
    let controlButtonSize = size.controlButtonSize.rawValue/2
    let song = Songs()
    let sheetMusicPage = SheetMusicView()
    var composedNoteList: [ComposedNotes] = []
    var tromboneButtons: [TromboneNoteButtons] = []
    var drumButtons: [DrumNoteButtons] = []
    var saxphoneButtons: [SaxphoneNoteButtons] = []
    var violinButtons: [ViolinNoteButtons] = []
    
    //MARK: Initializer
    init(){
        super.init(frame: CGRect(x: 0.0 , y: 0.0, width: size.screenWidth.rawValue, height: size.screenHeight.rawValue))
        self.addSubview(sheetMusicPage)
        sheetMusicPage.alpha = 0
        let buttonPlaceholder = UIImageView(frame: CGRect(x: 0.0 , y: 0.0, width: size.screenWidth.rawValue, height: size.screenHeight.rawValue))
        buttonPlaceholder.image = UIImage(named: "editPannel/buttonPlaceholder")
        self.addSubview(buttonPlaceholder)
        
        addTromboneSlots()
        addSaxphoneSlots()
        addDrumSlots()
        addViolinSlots()
        
        addDrumButtons()
        addTromboneButtons()
        addSaxphoneButtons()
        addViolinButtons()
        
        addComposedNotes()
        addButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Control Function
    
    //Plays the song composed by the user
    func playSong() {
        composedNoteList[0].playSong()
    }
    
    //Show the sheet music page
    func showSheetMusicPage() {
        self.backgroundColor = UIColor.black
        sheetMusicPage.alpha = 1
        sheetMusicPage.yourTurnPage.alpha = 0
    }
    
    //Hide the sheet music page
    func hideSheetMusicPage() {
        sheetMusicPage.alpha = 0
        self.backgroundColor = UIColor.clear
    }
    
    //Show the it's your turn page prompting the user to start composing a new song
    func showYourTurnPage() {
        sheetMusicPage.alpha = 1
        sheetMusicPage.showYourTurnPage()
        self.backgroundColor = UIColor.black
    }
    
    //Clear all notes in the slots, allowing the user to start a new song
    func clearAll() {
        for i in 0...numSlots {
            if let slot = self.viewWithTag(i + 100) as? NoteSlots{
                slot.image = UIImage(named: "trombone/t_None")
            }
            if let slot = self.viewWithTag(i + 200) as? NoteSlots{
                slot.image = UIImage(named: "drum/d_None")
            }
            if let slot = self.viewWithTag(i + 300) as? NoteSlots{
                slot.image = UIImage(named: "saxphone/s_None")
            }
            if let slot = self.viewWithTag(i + 400) as? NoteSlots{
                slot.image = UIImage(named: "violin/v_None")
            }
            composedNoteList[i].clearNote()
        }
    }
    
    //MARK: UIButton actions
    
    //Play the song composed by the user
    func playButton(_ button: UIButton!) {
        composedNoteList[0].playSong()
    }
    
    //Clear all notes added by the user so the user can start a new song.
    func clearSongButton(_ button: UIButton!) {
        clearAll()
    }
    
    //Hide and show note buttons of different instruments depending on which instrument button is tapped.
    func showMenuButton(_ button: UIButton!) {
        
        switch button.tag {
        //Saxphone
        case 1:
            hideDrumButtons()
            hideTromboneButtons()
            hideViolinButtons()
            showSaxphoneButtons()
            break
        //Drum
        case 2:
            hideTromboneButtons()
            showDrumButtons()
            hideSaxphoneButtons()
            hideViolinButtons()
            break
        //Violin
        case 3:
            hideTromboneButtons()
            hideDrumButtons()
            hideSaxphoneButtons()
            showViolinButtons()
            break
        //Trombone
        case 4:
            showTromboneButtons()
            hideDrumButtons()
            hideSaxphoneButtons()
            hideViolinButtons()
            break
        default:
            break
        }
    }
    
    //MARK: Gesture recognizer function
    func handleTap(_ recognizer: UITapGestureRecognizer){
        guard let view = recognizer.view else {
            print("cannot unwrap in function handleTap")
            return
        }
        
        let noteSlot = view as! NoteSlots
        let index = noteSlot.tag % 100
        switch noteSlot.instrument! {
        case .Trombone:
            composedNoteList[index].tNote = composedNoteList[index].tNone
            noteSlot.image = UIImage(named: "trombone/t_None")
            break
        case .Saxphone:
            composedNoteList[index].sNote = composedNoteList[index].sNone
            noteSlot.image = UIImage(named: "saxphone/s_None")
            break
        case .Drum:
            composedNoteList[index].dNote = composedNoteList[index].dNone
            noteSlot.image = UIImage(named: "drum/d_None")
            break
        case .Violin:
            composedNoteList[index].vNote = composedNoteList[index].vNone
            noteSlot.image = UIImage(named: "violin/v_None")
            break
        default:
            break
        }
    }
    
    
    func handlePan(_ recognizer: UIPanGestureRecognizer){
        
        let translation = recognizer.translation(in: recognizer.view)
        if let view = recognizer.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: recognizer.view)
        
        guard let NoteButton = recognizer.view as? NoteButtons else {
            print("cannot unwrap button")
            return
        }
        
        var typeTag = 0
        switch NoteButton.instrument! {
        case .Trombone:
            typeTag = 100
            break
        case .Saxphone:
            typeTag = 300
            break
        case .Drum:
            typeTag = 200
            break
        case .Violin:
            typeTag = 400
            break
        default:
            break
        }
        
        
        if recognizer.state == UIGestureRecognizerState.ended {
            
            for i in 0...numSlots{
                handleMove(imgTag: typeTag + i, recognizer: recognizer)
            }
            NoteButton.center = CGPoint(x: NoteButton.originalX, y: NoteButton.originalY)
        }
    }
    
    func handleMove(imgTag: Int, recognizer: UIPanGestureRecognizer) {
        guard let tempImgView = self.viewWithTag(imgTag) as? NoteSlots else {
            print("unsucessful unwrap")
            return
        }
        
        guard let NoteButton = recognizer.view as? NoteButtons else {
            print("cannot unwrap button")
            return
        }

        let smallerFrame = tempImgView.frame.insetBy(dx: 20.0, dy: 20.0)
        
        if (recognizer.view?.frame)!.intersects(smallerFrame) {
            tempImgView.image = UIImage(named: NoteButton.fullName)
            switch tempImgView.instrument! {
            case .Trombone:
                composedNoteList[imgTag%100].addTNote(note: NoteButton.name)
                break
            case .Saxphone:
                composedNoteList[imgTag%100].addSNote(note: NoteButton.name)
                break
            case .Drum:
                composedNoteList[imgTag%100].addDNote(note: NoteButton.name)
                break
            case .Violin:
                composedNoteList[imgTag%100].addVNote(note: NoteButton.name)
            default:
                break
            }
        }
            
    }
    

    
    
    //MARK: Set up functions
    func addButtons() {
        let playButton: UIButton = UIButton(frame: CGRect(x: 800.0 , y: 850.0, width: 120.0, height: 50.0))
        playButton.backgroundColor = UIColor.white
        playButton.addTarget(self, action: #selector(playButton(_:)), for: UIControlEvents.touchUpInside)
        self.addSubview(playButton)
        
        let clearButton: UIButton = UIButton(frame: CGRect(x: 900, y: 850.0, width: 120.0, height: 50.0))
        clearButton.backgroundColor = UIColor.red
        clearButton.addTarget(self, action: #selector(clearSongButton(_:)), for: UIControlEvents.touchUpInside)
        self.addSubview(clearButton)
        
        let menuSButton: UIButton = UIButton(frame: CGRect(x: 0, y: 500.0, width: controlButtonSize, height: controlButtonSize))
        menuSButton.tag = 1
        menuSButton.setImage(UIImage(named: "editPannel/s_Button"), for: .normal)
        menuSButton.addTarget(self, action: #selector(showMenuButton(_:)), for: UIControlEvents.touchUpInside)
        self.addSubview(menuSButton)
        
        let menuDButton: UIButton = UIButton(frame: CGRect(x: controlButtonSize, y: 500.0, width: controlButtonSize, height: controlButtonSize))
        menuDButton.addTarget(self, action: #selector(showMenuButton(_:)), for: UIControlEvents.touchUpInside)
        menuDButton.tag = 2
        menuDButton.setImage(UIImage(named: "editPannel/d_Button"), for: .normal)
        self.addSubview(menuDButton)
        
        let menuVButton: UIButton = UIButton(frame: CGRect(x: 0, y: 500.0 + controlButtonSize, width: controlButtonSize, height: controlButtonSize))
        menuVButton.tag = 3
        menuVButton.setImage(UIImage(named: "editPannel/v_Button"), for: .normal)
        menuVButton.addTarget(self, action: #selector(showMenuButton(_:)), for: UIControlEvents.touchUpInside)
        self.addSubview(menuVButton)
        
        let menuTButton: UIButton = UIButton(frame: CGRect(x: controlButtonSize, y: 500.0 + controlButtonSize, width: controlButtonSize, height: controlButtonSize))
        menuTButton.tag = 4
        menuTButton.setImage(UIImage(named: "editPannel/t_Button"), for: .normal)
        menuTButton.addTarget(self, action: #selector(showMenuButton(_:)), for: UIControlEvents.touchUpInside)
        self.addSubview(menuTButton)
        
    }
    
    
    func addTromboneSlots() {
        for i in 0...numSlots {
            let newSlot = TromboneSlots(x: Double(i)*slotSize, y: slotSize*3)
            newSlot.tag = i + 100
            let tapGestureRecignizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            tapGestureRecignizer.delegate = newSlot
            tapGestureRecignizer.numberOfTapsRequired = 2
            newSlot.addGestureRecognizer(tapGestureRecignizer)
            newSlot.image = UIImage(named: "trombone/t_" + song.odeToJoyTrombone()[i])
            self.addSubview(newSlot)
        }
    }
    
    func addDrumSlots() {
        for i in 0...numSlots {
            let newSlot = DrumSlots(x: Double(i)*slotSize, y: slotSize*1)
            newSlot.tag = i + 200
            let tapGestureRecignizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            tapGestureRecignizer.delegate = newSlot
            tapGestureRecignizer.numberOfTapsRequired = 2
            newSlot.addGestureRecognizer(tapGestureRecignizer)
            newSlot.image = UIImage(named: "drum/d_" + song.odeToJoyDrum()[i])
            self.addSubview(newSlot)
        }
    }
    
    func addSaxphoneSlots() {
        for i in 0...numSlots {
            let newSlot = SaxphoneSlots(x: Double(i)*slotSize, y: slotSize*2)
            newSlot.tag = i + 300
            let tapGestureRecignizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            tapGestureRecignizer.delegate = newSlot
            tapGestureRecignizer.numberOfTapsRequired = 2
            newSlot.addGestureRecognizer(tapGestureRecignizer)
            newSlot.image = UIImage(named: "saxphone/s_" + song.odeToJoySaxphone()[i])
            self.addSubview(newSlot)
        }
    }
    
    func addViolinSlots() {
        for i in 0...numSlots {
            let newSlot = ViolinSlots(x: Double(i)*slotSize, y: 0.0)
            newSlot.tag = i + 400
            let tapGestureRecignizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
            tapGestureRecignizer.delegate = newSlot
            tapGestureRecignizer.numberOfTapsRequired = 2
            newSlot.addGestureRecognizer(tapGestureRecignizer)
            newSlot.image = UIImage(named: "violin/v_" + song.odeToJoyViolin()[i])
            self.addSubview(newSlot)
        }
    }
    
    func addComposedNotes() {
        composedNoteList = song.odeToJoy()
    }
    
    func addTromboneButtons() {
        for i in 0...6 {
            let newButton = TromboneNoteButtons(name: allNotes[i], x: Double(i)*buttonSize+bigControlButtonSize, y: 510.0)
            let panGestureRecignizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(_:)))
            panGestureRecignizer.delegate = newButton
            newButton.addGestureRecognizer(panGestureRecignizer)
            newButton.alpha = 0
            tromboneButtons.append(newButton)
            self.addSubview(newButton)
        }
        
        for i in 7...13{
            let newButton = TromboneNoteButtons(name: allNotes[i], x: Double(i-7)*buttonSize+bigControlButtonSize, y: 550.0)
            let panGestureRecignizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(_:)))
            panGestureRecignizer.delegate = newButton
            newButton.addGestureRecognizer(panGestureRecignizer)
            newButton.alpha = 0
            tromboneButtons.append(newButton)
            self.addSubview(newButton)
        }
    }
    
    func addDrumButtons() {
        for i in 0...2 {
            let newButton = DrumNoteButtons(name: allDrumNotes[i], x: Double(i)*buttonSize+bigControlButtonSize, y: 510.0)
            let panGestureRecignizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(_:)))
            panGestureRecignizer.delegate = newButton
            newButton.addGestureRecognizer(panGestureRecignizer)
            newButton.alpha = 0
            drumButtons.append(newButton)
            self.addSubview(newButton)
        }
    }
    
    func addSaxphoneButtons() {
        for i in 0...6 {
            let newButton = SaxphoneNoteButtons(name: allNotes[i], x: Double(i)*buttonSize+bigControlButtonSize, y: 510.0)
            let panGestureRecignizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(_:)))
            panGestureRecignizer.delegate = newButton
            newButton.addGestureRecognizer(panGestureRecignizer)
            newButton.alpha = 0
            saxphoneButtons.append(newButton)
            self.addSubview(newButton)
        }
        
        for i in 7...13 {
            let newButton = SaxphoneNoteButtons(name: allNotes[i], x: Double(i-7)*buttonSize+bigControlButtonSize, y: 550.0)
            let panGestureRecignizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(_:)))
            panGestureRecignizer.delegate = newButton
            newButton.addGestureRecognizer(panGestureRecignizer)
            newButton.alpha = 0
            saxphoneButtons.append(newButton)
            self.addSubview(newButton)
        }
    }
    
    func addViolinButtons() {
        for i in 0...6 {
            let newButton = ViolinNoteButtons(name: allNotes[i], x: Double(i)*buttonSize+bigControlButtonSize, y: 510.0)
            let panGestureRecignizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(_:)))
            panGestureRecignizer.delegate = newButton
            newButton.addGestureRecognizer(panGestureRecignizer)
            newButton.alpha = 0
            violinButtons.append(newButton)
            self.addSubview(newButton)
        }
        
        for i in 7...13 {
            let newButton = ViolinNoteButtons(name: allNotes[i], x: Double(i-7)*buttonSize+bigControlButtonSize, y: 550.0)
            let panGestureRecignizer = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(_:)))
            panGestureRecignizer.delegate = newButton
            newButton.addGestureRecognizer(panGestureRecignizer)
            newButton.alpha = 0
            violinButtons.append(newButton)
            self.addSubview(newButton)
        }
    }
    
    //MARK: Animations
    
    //Hide all trombone buttons one by one
    func hideTromboneButtons() {
        for i in 1...tromboneButtons.count{
            UIView.animate(withDuration: 0.1, delay: 0.05*Double(i), options: [], animations:{
                self.tromboneButtons[self.tromboneButtons.count - i].alpha = 0
            }, completion: nil)
        }
    }
    
    //Hide all drum buttons one by one
    func hideDrumButtons() {
        for i in 1...drumButtons.count{
            UIView.animate(withDuration: 0.1, delay: 0.05*Double(i), options: [], animations:{
                self.drumButtons[self.drumButtons.count - i].alpha = 0
            }, completion: nil)
        }
    }
    
    //Hide all saxphone buttons one by one
    func hideSaxphoneButtons() {
        for i in 1...saxphoneButtons.count{
            UIView.animate(withDuration: 0.1, delay: 0.05*Double(i), options: [], animations:{
                self.saxphoneButtons[self.saxphoneButtons.count - i].alpha = 0
            }, completion: nil)
        }
    }
    
    //Hide all violin buttons one by one
    func hideViolinButtons() {
        for i in 1...violinButtons.count{
            UIView.animate(withDuration: 0.1, delay: 0.05*Double(i), options: [], animations:{
                self.violinButtons[self.violinButtons.count - i].alpha = 0
            }, completion: nil)
        }
    }
    
    //Show all trombone buttons one by one
    func showTromboneButtons() {
        for i in 0..<tromboneButtons.count{
            UIView.animate(withDuration: 0.1, delay: 0.05*Double(i), options: [], animations:{
                self.tromboneButtons[i].alpha = 1
            }, completion: nil)
        }
    }
    
    //Show all trombone buttons one by one
    func showDrumButtons() {
        for i in 0..<drumButtons.count{
            UIView.animate(withDuration: 0.1, delay: 0.05*Double(i), options: [], animations:{
                self.drumButtons[i].alpha = 1
            }, completion: nil)
        }
    }
    
    //Show all saxphone buttons one by one
    func showSaxphoneButtons() {
        for i in 0..<saxphoneButtons.count{
            UIView.animate(withDuration: 0.1, delay: 0.05*Double(i), options: [], animations:{
                self.saxphoneButtons[i].alpha = 1
            }, completion: nil)
        }
    }
    
    //Show all violin buttons one by one
    func showViolinButtons() {
        for i in 0..<violinButtons.count{
            UIView.animate(withDuration: 0.1, delay: 0.05*Double(i), options: [], animations:{
                self.violinButtons[i].alpha = 1
            }, completion: nil)
        }
    }
}

