//: Playground - noun: a place where people can play


import UIKit
import PlaygroundSupport


// Create an instance of the view controller
let viewController = ViewController()

// Allow playground to execute

viewController.preferredContentSize = viewController.view.frame.size
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = viewController.view