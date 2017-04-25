//
//  ViewController.swift
//  FaceiT
//
//  Created by Arun Ramaswamy on 4/17/17.
//  Copyright © 2017 Arun Ramaswamy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var faceView: FaceView!{
        // IOS takes few microseconds to connect this to view during startup. SO if model gets intialized before that then updateUI method is not called at all because i) faceView is not intialized so didSet won't work, ii) the didSet of expression also wont work because didSet doesn't get called during intialization.
        didSet{
            
            let handler = #selector(FaceView.changeScale(byReactingTo:))
            let pinchRecognizer = UIPinchGestureRecognizer(target: faceView, action: handler)
            //gesture
            faceView.addGestureRecognizer(pinchRecognizer)
            //tap
            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(toggleEyes(byReactingTo :)))
            faceView.addGestureRecognizer(tapRecognizer)
            updateUI()
        }
    }

    var expression = FacialExpression(eyes : .open, mouth : .grin) {
        didSet{
                updateUI()
        }
    }
    
    //handler for toggling eyes to keep in sync with the model
    func toggleEyes(byReactingTo tapRecognizer: UITapGestureRecognizer){
        if tapRecognizer.state == .ended{
            let eyes : FacialExpression.Eyes = expression.eyes == .closed  ? .open : .closed
            expression = FacialExpression(eyes: eyes, mouth: expression.mouth)
        }
        
    }
    
   
    private func updateUI(){
    
        switch expression.eyes {
            case .open :
                faceView?.eyeOpen = true // optional chaining added because faceView is null if             expression gets called before faceView is initialized
            case .closed :
                faceView?.eyeOpen = false
            case .squinting :
                faceView?.eyeOpen = false
        }
        
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
        
    }
    
    private let mouthCurvatures = [
        FacialExpression.Mouth.frown : -1.0,
        FacialExpression.Mouth.grin : 0.5,
        FacialExpression.Mouth.neutral : 0.0,
        FacialExpression.Mouth.smile : 1.0,
        FacialExpression.Mouth.smirk : -0.5,
    ]
  
    
    //handler for toggling mouth to keep in sync with the model
    func toggleMouth(byReactingTo tapRecognizer: UITapGestureRecognizer){
        if tapRecognizer.state == .ended {
            let mouth : FacialExpressionn = expression.mouth.happier ==   ? .open : .closed
            expression = FacialExpression(eyes: eyes, mouth: expression.mouth)
        }
        
    }
    

}

