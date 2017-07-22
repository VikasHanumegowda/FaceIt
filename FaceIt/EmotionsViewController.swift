//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by Vikas Hanumegowda on 7/18/17.
//  Copyright © 2017 Vikas Hanumegowda. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationViewController = segue.destination
        if let navigationController = destinationViewController as? UINavigationController {
            destinationViewController = navigationController.visibleViewController ?? destinationViewController
        }
        if  let faceViewController = destinationViewController as? FaceViewController,
            let identifier = segue.identifier,
            let expression = emotionalFaces[identifier] {//this gets executed when all the three lets  happen
            faceViewController.expression = expression
            faceViewController.navigationItem.title = (sender as? UIButton)?.currentTitle
        }
    }
    
    private let emotionalFaces: Dictionary<String,FacialExpression> = [
        "sad" : FacialExpression(eyes: .Closed, mouth: .Frown),
        "happy" : FacialExpression(eyes: .Open, mouth: .Smile),
        "worried" : FacialExpression(eyes: .Open, mouth: .Smirk)
    ]

} 
