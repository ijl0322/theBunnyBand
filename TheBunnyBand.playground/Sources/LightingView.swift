//
//  LightingView.swift
//  band
//
//  Created by Isabel  Lee on 21/03/2017.
//  Copyright © 2017 Isabel  Lee. All rights reserved.
//

import UIKit

//Defines a subclass of UIView that represents the lighting effects on stage.
class LightingView: UIView {
    
    //MARK: Initializer
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 800, height: 600))
        
        let emitter = layer as! CAEmitterLayer
        emitter.emitterPosition = CGPoint(x: bounds.size.width / 2, y: 0)
        emitter.emitterSize = bounds.size
        emitter.emitterShape = kCAEmitterLayerRectangle
        
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "main/sparkle.png")!.cgImage
        cell.birthRate = 10
        cell.speed = 2.0
        cell.lifetime = 10
        
        emitter.emitterCells = [cell]
        emitter.emitterPosition = CGPoint(x: 200, y: 400)
        emitter.emitterShape = kCAEmitterLayerSphere
        emitter.emitterSize = CGSize(width: 800, height: 800)
        emitter.renderMode = kCAEmitterLayerOldestFirst
        
        cell.velocity = 5.0
        cell.velocityRange = 700
        cell.yAcceleration = 10
        cell.xAcceleration = 0
        cell.scale = 1.0
        cell.scaleRange = 1.0
        cell.scaleSpeed = 0.5
        cell.lifetimeRange = 10
        cell.spin = 1.0
        cell.spinRange = 10.0
        cell.alphaSpeed = -0.1

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var layerClass: AnyClass {
        return CAEmitterLayer.self
    }
}
