//
//  SheetMusicView.swift
//  band
//
//  Created by Isabel  Lee on 24/03/2017.
//  Copyright © 2017 Isabel  Lee. All rights reserved.
//

import UIKit

//Define a subclass of UIImageView, showing the sheet music of the song "twinkle twinkle little star"
//So that the user can orchestrate the bunnies to play this song

class SheetMusicView: UIImageView {
    
    //MARK: Variables
    var infoButton: UIButton!
    var tromboneButton: UIButton!
    var drumButton: UIButton!
    var violinButton: UIButton!
    var saxphoneButton: UIButton!
    var doneButton: UIButton!
    var yourTurnPage: UIImageView!
    let darkGrey = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1)
    
    //MARK: Initializer
    init() {
        super.init(frame: CGRect(x: 0.0 , y: 160.0, width: size.screenWidth.rawValue, height: 342.0))
        self.image = UIImage(named: "sheetMusicView/sheetMusicIntro")
        self.isUserInteractionEnabled = true
        setUp()
    }
    
    //Initializes all images and buttons for the view
    func setUp() {
        infoButton = UIButton(frame: CGRect(x: 0.0 , y: 0.0, width: 68.5, height: 68.5))
        violinButton = UIButton(frame: CGRect(x: 0.0 , y: 68.5, width: 68.5, height: 68.5))
        drumButton = UIButton(frame: CGRect(x: 0.0 , y: 137.0, width: 68.5, height: 68.5))
        saxphoneButton = UIButton(frame: CGRect(x: 0.0 , y: 205.5, width: 68.5, height: 68.5))
        tromboneButton = UIButton(frame: CGRect(x: 0.0 , y: 274.0, width: 68.5, height: 68.5))
        doneButton = UIButton(frame: CGRect(x: 660.0 , y: 274.0, width: 92.0, height: 44.0))
        yourTurnPage = UIImageView(frame: CGRect(x: 0.0 , y: 0.0, width: size.screenWidth.rawValue, height: 342.0))
        
        yourTurnPage.image = UIImage(named: "sheetMusicView/yourTurn")
        
        infoButton.tag = 1
        violinButton.tag = 2
        drumButton.tag = 3
        saxphoneButton.tag = 4
        tromboneButton.tag = 5
        
        infoButton.addTarget(self, action: #selector(buttonTapped), for: UIControl.Event.touchUpInside)
        violinButton.addTarget(self, action: #selector(buttonTapped), for: UIControl.Event.touchUpInside)
        drumButton.addTarget(self, action: #selector(buttonTapped), for: UIControl.Event.touchUpInside)
        saxphoneButton.addTarget(self, action: #selector(buttonTapped), for: UIControl.Event.touchUpInside)
        tromboneButton.addTarget(self, action: #selector(buttonTapped), for: UIControl.Event.touchUpInside)
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: UIControl.Event.touchUpInside)
        
        self.addSubview(infoButton)
        self.addSubview(violinButton)
        self.addSubview(drumButton)
        self.addSubview(saxphoneButton)
        self.addSubview(tromboneButton)
        self.addSubview(doneButton)
    }
    
    
    //MARK: Control Functions
    func showYourTurnPage() {
        yourTurnPage.isUserInteractionEnabled = true
        let okButton = UIButton(frame: CGRect(x: 680.0 , y: 274.0, width: 92.0, height: 44.0))
        okButton.setImage(UIImage(named: "infoView/okButton"), for: .normal)
        okButton.addTarget(self, action: #selector(okButtonTapped), for: UIControl.Event.touchUpInside)
        okButton.tag = 6
        yourTurnPage.addSubview(okButton)
        self.addSubview(yourTurnPage)
    }
    
    //MARK: UIButton action
    
    //Show the music sheet of different instruments depending on which button the users tapped
    @objc func buttonTapped(_ button: UIButton) {
        
        switch button.tag{
        case 1:
            self.image = UIImage(named: "sheetMusicView/sheetMusicIntro")
            break
        case 2:
            self.image = UIImage(named: "sheetMusicView/violinSheetMusic")
            break
        case 3:
            self.image = UIImage(named: "sheetMusicView/drumSheetMusic")
            break
        case 4:
            self.image = UIImage(named: "sheetMusicView/saxphoneSheetMusic")
            break
        case 5:
            self.image = UIImage(named: "sheetMusicView/tromboneSheetMusic")
            break
        default:
            break
        }
    }
    
    //Hides the view when the user taps the done button
    @objc func doneButtonTapped(_ button: UIButton){
        self.alpha = 0
        self.superview?.backgroundColor = UIColor.clear
    }
    
    @objc func okButtonTapped(_ button: UIButton){
        self.alpha = 0
        self.superview?.backgroundColor = UIColor.clear
        yourTurnPage.removeFromSuperview()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
