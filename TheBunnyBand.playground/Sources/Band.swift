//
//  Band.swift
//  band
//
//  Created by Isabel  Lee on 20/03/2017.
//  Copyright © 2017 Isabel  Lee. All rights reserved.
//



import UIKit

//Define a subclass of UIView, which represents four bunny musicians and two spotlights.
class Band: UIView {
    
    //MARK: Variables
    var tromboneBunny: UIImageView!
    var drumBunny: UIImageView!
    var saxphoneBunny: UIImageView!
    var violinBunny: UIImageView!
    var leftLight: UIImageView!
    var rightLight: UIImageView!
    
    //MARK: Initializer
    init(){
        super.init(frame: CGRect(x: 0.0 , y: 160.0, width: 800.0, height: 440.0))
        addBunnies()
        addSpotlight()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Adds all bunnies to the view
    func addBunnies() {
        
        violinBunny = UIImageView(frame: CGRect(x: 180.0 , y: 30.0, width: 275.0, height: 275.0))
        violinBunny.image = UIImage(named: "band/v_bunny")
        violinBunny.contentMode = .scaleAspectFit
        self.addSubview(violinBunny)
        
        tromboneBunny = UIImageView(frame: CGRect(x: 0.0 , y: 55.0, width: 250.0, height: 250.0))
        tromboneBunny.image = UIImage(named: "band/t_bunny")
        tromboneBunny.contentMode = .scaleAspectFit
        self.addSubview(tromboneBunny)
        
        drumBunny = UIImageView(frame: CGRect(x: 400.0 , y: 40.0, width: 250.0, height: 250.0))
        drumBunny.image = UIImage(named: "band/d_bunny")
        drumBunny.contentMode = .scaleAspectFit
        self.addSubview(drumBunny)
        
        saxphoneBunny = UIImageView(frame: CGRect(x: 550.0 , y: 55.0, width: 250.0, height: 250.0))
        saxphoneBunny.image = UIImage(named: "band/s_bunny")
        saxphoneBunny.contentMode = .scaleAspectFit
        self.addSubview(saxphoneBunny)
    }
    
    //Adds the spot lights to the view
    func addSpotlight() {
        
        // Add left spot light
        leftLight = UIImageView(frame: CGRect(x: 0.0 , y: -10.0, width: 250.0, height: 440.0))
        leftLight.image = UIImage(named: "band/light_l")
        leftLight.alpha = 0
        self.addSubview(leftLight)
        
        // Add right spotlight
        rightLight = UIImageView(frame: CGRect(x: 520.0 , y: -10.0, width: 250.0, height: 440.0))
        rightLight.image = UIImage(named: "band/light_r")
        rightLight.alpha = 0
        self.addSubview(rightLight)
    }
    
    //Turn on spotlight, then start the band's animation
    func startBand() {
        leftLight.alpha = 0.7
        rightLight.alpha = 0.7
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6){
            self.animateBunnies()
            self.animateSpotlight()
        }
    }
    
    //MARK: Animations
    
    //Adds the wiggle animations to the bunnies
    func animateBunnies() {
        wiggleAnimation(image: tromboneBunny)
        wiggleAnimation(image: drumBunny)
        wiggleAnimation(image: saxphoneBunny)
        wiggleAnimation(image: violinBunny)
    }
    
    //Animate the spotlight so that it rotates during the performance
    func animateSpotlight() {
        leftLight.alpha = 0.7
        rightLight.alpha = 0.7
        rotateWithAnchor(image: leftLight, anchorX: 0.0, anchorY: 0.0, fromAngle: 0.0, toAngle: -20.0)
        rotateWithAnchor(image: rightLight, anchorX: 1.0, anchorY: 0.0, fromAngle: 0.0, toAngle: 20.0)
    }
    
    //Slowly dim the spotlights and stop all animations
    func stopAllAnimation(){
        
        //Move spotlights to it's original position
        leftLight.transform = CGAffineTransform(rotationAngle: (0.0 * CGFloat(Double.pi)) / 180.0)
        rightLight.transform = CGAffineTransform(rotationAngle: (0.0 * CGFloat(Double.pi)) / 180.0)
        
        //Slowly dim the spotlights
        UIView.animate(withDuration: 6, animations: {
            self.leftLight.alpha = 0
            self.rightLight.alpha = 0
        }, completion: { (finish: Bool) in
            self.leftLight.layer.removeAllAnimations()
            self.rightLight.layer.removeAllAnimations()
        })
        
        drumBunny.layer.removeAllAnimations()
        saxphoneBunny.layer.removeAllAnimations()
        tromboneBunny.layer.removeAllAnimations()
        violinBunny.layer.removeAllAnimations()
    }
    
    //This function takes an image, and rotate it around the point (anchorX and anchorY), to and from the fromAngle and toAngle.
    func rotateWithAnchor(image: UIView, anchorX: Double, anchorY: Double, fromAngle: Double, toAngle: Double){
        setAnchorPoint(anchorPoint: CGPoint(x: anchorX, y: anchorY), view: image)

        let rotationInDegrees = Measurement(value: 45, unit: UnitAngle.degrees)
        let rotationInRadians = CGFloat(rotationInDegrees.converted(to: .radians).value)
        let transform = CATransform3DMakeRotation(rotationInRadians, 0, 0.0, 1.0)
        image.layer.transform = transform
        
        let animation = CABasicAnimation(keyPath: "transform")
        animation.fromValue = NSValue(caTransform3D: CATransform3DMakeRotation(CGFloat(Measurement(value: fromAngle, unit: UnitAngle.degrees).converted(to: .radians).value), 0, 0.0, 1.0))
        animation.toValue = NSValue(caTransform3D: CATransform3DMakeRotation(CGFloat(Measurement(value: toAngle, unit: UnitAngle.degrees).converted(to: .radians).value), 0, 0.0, 1.0))
        animation.duration = 2.0
        animation.repeatCount = Float.infinity
        animation.autoreverses = true
        image.layer.add(animation, forKey: "rotateWithAnchor")
    }
    //MARK: Supporting functions
    
    //This function sets the anchorPoint of an UIView from the center to the anchor point specified 
    //in the parameters
    func setAnchorPoint(anchorPoint: CGPoint, view: UIView) {
        var newPoint = CGPoint(x: view.bounds.size.width * anchorPoint.x, y: view.bounds.size.height * anchorPoint.y)
        var oldPoint = CGPoint(x: view.bounds.size.width * view.layer.anchorPoint.x, y: view.bounds.size.height * view.layer.anchorPoint.y)
        
        newPoint = newPoint.applying(view.transform)
        oldPoint = oldPoint.applying(view.transform)
        
        var position : CGPoint = view.layer.position
        
        position.x -= oldPoint.x
        position.x += newPoint.x;
        position.y -= oldPoint.y;
        position.y += newPoint.y;
        
        view.layer.position = position;
        view.layer.anchorPoint = anchorPoint;
    }
    
    //Returns a random interval from the interval provided. (with variance)
    func randomInterval(_ interval: TimeInterval, variance: Double) -> TimeInterval {
        return interval + variance * Double((Double(arc4random_uniform(1000)) - 500.0) / 500.0)
    }
    
    //Adds a wiggling animation to a UIImageView.
    func wiggleAnimation(image: UIImageView) {
        let angle = 0.1
        let wiggle = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        wiggle.values = [-angle, angle]
        
        wiggle.autoreverses = true
        wiggle.duration = self.randomInterval(0.5, variance: 0.05)
        wiggle.repeatCount = Float.infinity
        wiggle.isAdditive = true
        image.layer.add(wiggle, forKey: "wiggle")
    }
}
