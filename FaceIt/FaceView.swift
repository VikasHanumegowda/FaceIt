//
//  FaceView.swift
//  FaceIt
//
//  Created by Vikas Hanumegowda on 7/4/17.
//  Copyright © 2017 Vikas Hanumegowda. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView {

    @IBInspectable
    var scale: CGFloat = 0.9 {
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var eyesOpen: Bool = false {
        didSet{
            setNeedsDisplay()
        }
    }

    
    @IBInspectable
    var mouthCurvature: Double = -1.0 //1.0: smile, -1.0: frown
    {
        didSet{
            setNeedsDisplay()
        }
    }

    @IBInspectable
    var lineWidth: CGFloat = 5.0 {
        didSet{
            setNeedsDisplay()
        }
    }

    
    @IBInspectable
    var color: UIColor = UIColor.black {
        didSet{
            setNeedsDisplay()
        }
    }

    
    func changeScale(byReactingTo pinchRecognizer: UIPinchGestureRecognizer){
        switch pinchRecognizer.state {
        case .changed,.ended:
            scale *= pinchRecognizer.scale
            pinchRecognizer.scale = 1
        default:
            break
        }
    }
    
    private var skullRadius: CGFloat {
        return min(bounds.width, bounds.height) / 2 * scale
    }
    
    private var skullCenter: CGPoint {
        return CGPoint(x: bounds.midX , y: bounds.midY)
    }
    
    private enum Eye {
        case left
        case right
    }
    
    private func pathForEye(_ eye: Eye) -> UIBezierPath {
        
        func centerOfEye(_ eye:Eye)->CGPoint {
            let eyeOffset = skullRadius/Ratios.skullRadiusToEyeOffset
            var eyeCenter = skullCenter
            eyeCenter.y -= eyeOffset
            eyeCenter.x += ((eye == .left) ? -1 : 1) * eyeOffset
            return eyeCenter
        }
        
        let eyeRadius = skullRadius/Ratios.skullRadiusToEyeRadius
        let eyeCenter = centerOfEye(eye)
        var path: UIBezierPath
        if eyesOpen {
            path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        }
        else {
            path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x-eyeRadius, y: eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x+eyeRadius, y: eyeCenter.y))
        }
        path.lineWidth = lineWidth
        return path
    }
    
    
    private func pathForMouth() -> UIBezierPath {
        let mouthWidth = skullRadius/Ratios.skullRadiusToMouthWidth
        let mouthHeight = skullRadius/Ratios.skullRadiusToMouthHeight
        let mouthOffset = skullRadius/Ratios.skullRadiusToMouthOffset
        
        let mouthRect = CGRect(
            x: skullCenter.x-mouthWidth/2,
            y: skullCenter.y+mouthOffset,
            width: mouthWidth,
            height: mouthHeight)
        
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.midY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.midY)
        
        let smileOffset = CGFloat(max(-1,min(mouthCurvature,1)))*mouthRect.height
        
        let cp1 = CGPoint(x: mouthRect.minX + (mouthRect.maxX-mouthRect.minX)/3, y: mouthRect.midY+smileOffset)
        let cp2 = CGPoint(x: mouthRect.minX + 2*(mouthRect.maxX-mouthRect.minX)/3, y: mouthRect.midY+smileOffset )
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        return path
    }
    
    private func pathForSkull() -> UIBezierPath {
        let path = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        path.lineWidth = lineWidth
        return path
    }
    
    override func draw(_ rect: CGRect) {
        color.set()
        pathForSkull().stroke()
        color.set()
        pathForEye(.left).stroke()
        pathForEye(.right).stroke()
        pathForMouth().stroke()
        
    }
    
    private struct Ratios {
        static let skullRadiusToEyeOffset: CGFloat = 3
        static let skullRadiusToEyeRadius: CGFloat = 10
        static let skullRadiusToMouthWidth: CGFloat = 1
        static let skullRadiusToMouthHeight: CGFloat = 3
        static let skullRadiusToMouthOffset: CGFloat = 3
        
    }
}
