//
//  ViewController.swift
//  FaceIt
//
//  Created by Vikas Hanumegowda on 7/4/17.
//  Copyright © 2017 Vikas Hanumegowda. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var faceView: FaceView!{
        didSet{
            updateUI()
        }
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

