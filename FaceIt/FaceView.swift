//
//  FaceView.swift
//  FaceIt
//
//  Created by Vikas Hanumegowda on 7/4/17.
//  Copyright © 2017 Vikas Hanumegowda. All rights reserved.
//

import UIKit

class FaceView: UIView {

    override func draw(_ rect: CGRect) {
        let skullRadius = min(bounds.width, bounds.height) / 2 * 0.9
        let skullCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        let path = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        path.lineWidth = 5.0
        UIColor.brown.set()
        path.stroke()
        
    }
}
