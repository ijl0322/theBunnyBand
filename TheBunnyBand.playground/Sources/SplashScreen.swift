//
//  SplashScreen.swift
//  band
//
//  Created by Isabel  Lee on 22/03/2017.
//  Copyright © 2017 Isabel  Lee. All rights reserved.
//

import UIKit

//Defines a subclass of an UIView, representing the splash screen of the project
class SplashScreen: UIView {
    
    //MARK: Variables
    var bandLogo: UIImageView!
    var signature: UIImageView!
    var violinBunny: UIImageView!
    var saxphoneBunny: UIImageView!
    var tromboneBunny: UIImageView!
    var drumBunny: UIImageView!
    var loadingLabel: UILabel!
    var loadingEnded = false

    //MARK: Initializer
    init() {
        super.init(frame: CGRect(x: 0.0 , y: 0.0, width: size.screenWidth.rawValue, height: size.screenHeight.rawValue))
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        self.backgroundColor = UIColor.black
        self.bandLogo = UIImageView(frame: CGRect(x: 172.0 , y: -128.0, width: 456, height: 128))
        self.bandLogo.image = UIImage(named: "splashScreen/bandLogo")
        self.signature = UIImageView(frame: CGRect(x: 84.0 , y: -118.0, width: 160, height: 118))
        self.signature.image = UIImage(named: "splashScreen/signature")
        self.addSubview(bandLogo)
        self.addSubview(signature)
        
        loadingLabel = UILabel(frame: CGRect(x: 620, y: 500, width: 100, height: 100))
        loadingLabel.textAlignment = .center
        loadingLabel.text = "Loading..."
        loadingLabel.textColor = UIColor.white
        loadingLabel.alpha = 0
        self.addSubview(loadingLabel)
        
        tromboneBunny = UIImageView(frame: CGRect(x: -250.0 , y: 215.0, width: 250.0, height: 400.0))
        tromboneBunny.image = UIImage(named: "band/t_bunny")
        tromboneBunny.contentMode = .scaleAspectFit
        self.addSubview(tromboneBunny)
        
        violinBunny = UIImageView(frame: CGRect(x: -275.0 , y: 200.0, width: 275.0, height: 400.0))
        violinBunny.image = UIImage(named: "band/v_bunny")
        violinBunny.contentMode = .scaleAspectFit
        self.addSubview(violinBunny)
        
        drumBunny = UIImageView(frame: CGRect(x: 1050.0 , y: 200.0, width: 250.0, height: 400.0))
        drumBunny.image = UIImage(named: "band/d_bunny")
        drumBunny.contentMode = .scaleAspectFit
        self.addSubview(drumBunny)
        
        saxphoneBunny = UIImageView(frame: CGRect(x: 1050.0 , y: 215.0, width: 250.0, height: 400.0))
        saxphoneBunny.image = UIImage(named: "band/s_bunny")
        saxphoneBunny.contentMode = .scaleAspectFit
        self.addSubview(saxphoneBunny)
        
    }
    
    //MARK: Control Functions
    
    //The program will load things in the backbround thread when showing the splash screen
    //The splashscreen will show the loadingLabel when it is loading. 
    //This function hides the loading label when loading is done.
    func endLoading(){
        loadingEnded = true
        loadingLabel.alpha = 0
    }
    
    //Shows the loadingLabel
    func showLoadingLabel() {
        if !loadingEnded {
            loadingLabel.alpha = 1
        }
    }
    
    //MARK: Animations
    
    //Animates the bunnies and logo off the splash screen before it gets removed
    func removeSplashScreen() {
        UIView.animate(withDuration: 1, animations: {
            self.bandLogo.center.y = -128
            self.signature.center.y = -118
        }, completion: {(finish: Bool) in UIView.animate(withDuration: 0.5, animations: {
            self.tromboneBunny.center.x = -250
            self.saxphoneBunny.center.x = 1050
        }, completion: {(finish: Bool) in UIView.animate(withDuration: 0.8, animations: {
            self.violinBunny.center.x = -250
            self.drumBunny.center.x = 1050
        }, completion: nil)})})
    }
    
    //Animate the logo and the bunnies onto the splash screen
    func animateLogo() {
        UIView.animate(withDuration: 1, delay: 0.2, animations: {
            self.bandLogo.center.y = 273
        }, completion: {(finish: Bool) in
            UIView.animate(withDuration: 0.4, animations: {
              self.bandLogo.transform = CGAffineTransform(rotationAngle: (-15.0 * CGFloat(Double.pi)) / 180.0)
            }, completion: { (finish: Bool) in UIView.animate(withDuration: 0.3, animations: {
                self.bandLogo.transform = CGAffineTransform(rotationAngle: (10.0 * CGFloat(Double.pi)) / 180.0)
            }, completion: {(finish: Bool) in UIView.animate(withDuration: 0.2, animations: {
                self.bandLogo.transform = CGAffineTransform(rotationAngle: (0.0 * CGFloat(Double.pi)) / 180.0)
            }, completion: {(finish: Bool) in UIView.animate(withDuration: 0.2, animations: {
                self.signature.center.y = 168
            }, completion: {(finish: Bool) in UIView.animate(withDuration: 1, delay: 1.2, animations: {
                self.bandLogo.center.y = 173
                self.signature.center.y = 68
            }, completion: {(finish: Bool) in UIView.animate(withDuration: 1.5, animations: {
                self.violinBunny.center.x = 317.5
            }, completion: {(finish: Bool) in UIView.animate(withDuration: 1.5, animations: {
                self.drumBunny.center.x = 525.0
            }, completion: {(finish: Bool) in UIView.animate(withDuration: 1, animations: {
                self.tromboneBunny.center.x = 125.0
            }, completion: {(finish: Bool) in UIView.animate(withDuration: 1, animations: {
                self.saxphoneBunny.center.x = 675.0
            }, completion:{(finish: Bool) in
                self.showLoadingLabel()})})})})})})})})})
        })
    }
}
