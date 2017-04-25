//
//  FaceView.swift
//  FaceiT
//
//  Created by Arun Ramaswamy on 4/17/17.
//  Copyright © 2017 Arun Ramaswamy. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView {
    
    var eyeOpen : Bool = false        {
        didSet{
            setNeedsDisplay()
        }
    }
    
    var mouthCurvature : Double = -1.0 { //1.0 is smile and -1.0 is frown
        didSet{
            setNeedsDisplay()
        }
    }
    
    var scale : CGFloat = 0.9{
        didSet{
            setNeedsDisplay()
        }
    }
    
    //pan view
    func changeScale(byReactingTo pinchRecognizer : UIPinchGestureRecognizer){
        switch  pinchRecognizer.state{
        case .changed,.ended:
            scale = scale * pinchRecognizer.scale
            pinchRecognizer.scale = 1
        default:
            break
        }
    }
    
    private func pathForSkull() -> UIBezierPath {
        let path = UIBezierPath(arcCenter: skullCenter, radius: skullRadius, startAngle: 0, endAngle: 2 * CGFloat.pi , clockwise: false)
        path.lineWidth = 5.0
        return path
    }
    
    private var skullRadius : CGFloat {
        return min(bounds.size.width, bounds.size.height)/2 * scale
    }
    
    private var skullCenter : CGPoint {
        return CGPoint(x:bounds.midX,y:bounds.midY)
    }
    
    private enum Eye{
        case left
        case right
    }
    
    private func pathForEye(_ eye : Eye) -> UIBezierPath {
        func centerForEye(_ eye : Eye) -> CGPoint {
            let eyeOffset = skullRadius/Ratios.skullRadiusToEyeOffset
            var eyeCenter = skullCenter
            eyeCenter.y -= eyeOffset
            eyeCenter.x += (eye == Eye.left ? -eyeOffset : eyeOffset)
         return eyeCenter
        }
        
        let eyeRadius = skullRadius/Ratios.skullRadiusToEyeRadius
        let eyeCenter = centerForEye(eye)
        let path : UIBezierPath
        if eyeOpen {
             path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: false)
        }else {
             path = UIBezierPath(arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0, endAngle: CGFloat.pi, clockwise: false)
        }
        path.lineWidth = 3.0
        return path
    }
    
    private func pathForMouth() -> UIBezierPath {
        let mouthWidth = skullRadius/Ratios.skullRadiusToMouthWidth
        let mouthHeight = skullRadius/Ratios.skullRadiusToMouthHeight
        let mouthOffset = skullRadius/Ratios.skullRadiusToMouthOffset
        
        let mouthRect = CGRect(x: skullCenter.x - mouthWidth / 2  , y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
        
        
        
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.midY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.midY)
        
        //control points
        let smileOffset : CGFloat = CGFloat(mouthCurvature) *  mouthRect.height
        let cp1 = CGPoint(x: start.x + mouthRect.width / 3 , y: start.y + smileOffset)
        let cp2 = CGPoint(x: end.x - mouthRect.width / 3, y: start.y + smileOffset)
        let path = UIBezierPath()
        
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        
        path.lineWidth = 3.0
        return path
    }
    
    private struct Ratios {
        static let skullRadiusToEyeOffset : CGFloat = 3
        static let skullRadiusToEyeRadius : CGFloat = 10
        static let skullRadiusToMouthWidth : CGFloat = 1
        static let skullRadiusToMouthHeight : CGFloat = 3
        static let skullRadiusToMouthOffset : CGFloat = 4
    }
    
 override func draw(_ rect: CGRect) {
    
    pathForSkull().stroke()
    pathForEye(Eye.left).stroke()
    pathForEye(Eye.right).stroke()
    pathForMouth().stroke()
    
    }

}
