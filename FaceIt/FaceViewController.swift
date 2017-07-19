//
//  ViewController.swift
//  FaceIt
//
//  Created by Vikas Hanumegowda on 7/4/17.
//  Copyright © 2017 Vikas Hanumegowda. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {

    @IBOutlet weak var faceView: FaceView!{
        didSet{
            let handler = #selector(FaceView.changeScale(byReactingTo: ))
            let pinchRecognizer = UIPinchGestureRecognizer(target: faceView, action: handler)
            faceView.addGestureRecognizer(pinchRecognizer)
            
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.toggleEyes(byReactingTo:)))
            tapRecognizer.numberOfTapsRequired = 2
            faceView.addGestureRecognizer(tapRecognizer)
            
            let swipeDownRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(increaseHappiness))
            swipeDownRecognizer.direction = .down
            faceView.addGestureRecognizer(swipeDownRecognizer)
            
            let swipeUpRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(decreaseHappiness))
            swipeUpRecognizer.direction = .up
            faceView.addGestureRecognizer(swipeUpRecognizer)
            
            updateUI()
        }
    }
    
    func toggleEyes(byReactingTo tapRecognizer: UITapGestureRecognizer){
        if tapRecognizer.state == .ended {
            let eyes: FacialExpression.Eyes = (expression.eyes == .Closed) ? .Open : .Closed
            expression = FacialExpression(eyes: eyes, mouth: expression.mouth )
        }
    }
    
    func increaseHappiness() {
        expression.mouth = expression.mouth.happierMouth()
    }
    
    func decreaseHappiness() {
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    var expression = FacialExpression(eyes: .Closed, mouth: .Frown){
        didSet{
            updateUI()
        }
    }
    
    private func updateUI(){
        switch expression.eyes {
        case .Open:
            faceView?.eyesOpen = true
        case .Closed:
            faceView?.eyesOpen = false
        case .Squinting:
            faceView?.eyesOpen = false
        }
        faceView?.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
    }
    
    private let mouthCurvatures = [FacialExpression.Mouth.Grin:0.5,.Frown:-1.0,.Smirk:-0.5,.Neutral:0.0,.Smile:1.0]
}

