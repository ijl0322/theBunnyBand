//
//  ViewController.swift
//  band
//
//  Created by Isabel  Lee on 16/03/2017.
//  Copyright © 2017 Isabel  Lee. All rights reserved.
//

import UIKit
import AVFoundation

public class ViewController: UIViewController, MusicStatusDelegate, InfoViewDelegate {

    //MARK: Variables
    var editPannel: EditPannel?
    var tempEditPannel: EditPannel?
    
    let startButton = UIButton(frame: CGRect(x: 620.0 , y: 500.0, width: 100.0, height: 100.0))
    let sheetMusicButton = UIButton(frame: CGRect(x: 530.0 , y: 540.0, width: 60.0, height: 60.0))
    let infoButton = UIButton(frame: CGRect(x: 590.0 , y: 540.0, width: 60.0, height: 60.0))
    let playButton = UIButton(frame: CGRect(x: 650.0 , y: 540.0, width: 60.0, height: 60.0))
    let clearButton = UIButton(frame: CGRect(x: 710.0 , y: 540.0, width: 60.0, height: 60.0))
    
    let stage = UIImageView(frame: CGRect(x: 0, y: 0, width: 770, height: 600))
    var isFirstLaunch = true
    
    let lightingView = LightingView()
    let splashScreen = SplashScreen()
    let infoPage = InfoView()
    let band = Band()


    override public func viewDidLoad() {
        super.viewDidLoad()
        self.view.frame = CGRect(x: 0, y: 0, width: 770, height: 600)
        setUp()
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        splashScreen.animateLogo()
    }
    
    
    // Sets up the view, load the edit pannel in the background thread
    func setUp() {
        startButton.setImage(UIImage(named: "main/startButton"), for: .normal)
        startButton.addTarget(self, action: #selector(startButton(_:)), for: UIControl.Event.touchUpInside)
        infoPage.delegate = self
        
        DispatchQueue.global(qos: .background).async {
            self.tempEditPannel = EditPannel()
            DispatchQueue.main.async {
                self.editPannel = self.tempEditPannel
                self.editPannel!.composedNoteList.last?.delegate = self
                self.splashScreen.endLoading()
                self.view.addSubview(self.startButton)
                self.addBlinkingAnimation(view: self.startButton.imageView!)
            }
        }
        view.addSubview(splashScreen)
    }
    

    //MARK: UIButton setup and actions
    
    //Add all buttons to the view
    func addButtons() {
        
        sheetMusicButton.setImage(UIImage(named: "main/sheetMusicButton"), for: .normal)
        sheetMusicButton.addTarget(self, action: #selector(sheetMusicButton(_:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(sheetMusicButton)
        
        playButton.setImage(UIImage(named: "main/playButton"), for: .normal)
        playButton.addTarget(self, action: #selector(playButton(_:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(playButton)
        
        clearButton.setImage(UIImage(named: "main/clearAllButton"), for: .normal)
        clearButton.addTarget(self, action: #selector(clearButton(_:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(clearButton)
        
        infoButton.setImage(UIImage(named: "main/infoButton"), for: .normal)
        infoButton.addTarget(self, action: #selector(infoButton(_:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(infoButton)
    }
    
    //Gets called when the edit pannel is done loading and the user taps start.
    //Adds all appropriate subviews, and show the info page.
    @objc func startButton(_ button: UIButton) {
        startButton.removeFromSuperview()
        splashScreen.removeSplashScreen()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
            self.splashScreen.removeFromSuperview()
            self.stage.image = UIImage(named: "main/stage")
            self.lightingView.alpha = 0
            self.view.addSubview(self.stage)
            self.view.addSubview(self.lightingView)
            self.view.addSubview(self.band)
            self.view.addSubview(self.editPannel!)
            self.addButtons()
            self.view.addSubview(self.infoPage)
            self.infoPage.showInfo()
        }
    }
    
    //Gets called when the info button is tapped. 
    //Shows the info page
    @objc func infoButton(_ button: UIButton!) {
        self.view.addSubview(infoPage)
        infoPage.showInfo()
    }
    
    //Gets called when the play button is tapped. 
    //Start the performance
    @objc func playButton(_ button: UIButton!) {
        startPerformance()
    }
    
    //Gets called when the clear button is tapped.
    //Clear all the notes in the edit pannel. Allowing the user to start a new song.
    @objc func clearButton(_ button: UIButton!) {
        editPannel!.clearAll()
    }
    
    
    //Gets called when the sheetMusicButton is tapped. 
    //Shows the sheet Music page
    @objc func sheetMusicButton(_ button: UIButton!) {
        editPannel!.showSheetMusicPage()
    }
    
    //MARK: Protocol functions
    
    //Gets called when the music ends. 
    //Play the clapping audio file, stop band animation, and re-enable the play/clear button.
    func musicEnded() {
        SharedAudioPlayer.player.playNote(name: "main/clapping")
        self.band.stopAllAnimation()
        UIView.animate(withDuration: 6, animations: {
            self.lightingView.alpha = 0
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            self.playButton.isEnabled = true
            self.playButton.alpha = 1
            self.clearButton.isEnabled = true
            self.clearButton.alpha = 1
            if self.isFirstLaunch{
                self.editPannel?.showYourTurnPage()
                self.isFirstLaunch = false
            }
        }
    }
    
    //Gets called when the user is done reading the introduction.
    //Start the band's performance
    //Hides the sheet music page(in case it is visible and blocks the users view)
    //Also disable the play/clear button to prevent the user from clicking them during the performance
    func startPerformance() {
        editPannel?.hideSheetMusicPage()
        band.startBand()
        playButton.isEnabled = false
        clearButton.isEnabled = false
        self.playButton.alpha = 0
        self.clearButton.alpha = 0
        self.lightingView.alpha = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.editPannel!.playSong()
        }
    }
    
    //MARK: Supporting functions
    func addBlinkingAnimation(view: UIView) {
        let key = "opacity"
        let animation = CABasicAnimation(keyPath: key)
        animation.fromValue = 1.0
        animation.toValue = 0.0
        animation.duration = 0.5
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.autoreverses = true
        animation.repeatCount = Float.greatestFiniteMagnitude
        view.layer.add(animation, forKey: key)
        
    }
}

