//
//  EmotionsViewController.swift
//  FaceiT
//
//  Created by Arun Ramaswamy on 4/30/17.
//  Copyright © 2017 Arun Ramaswamy. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {

  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        let destinationViewController = segue.destination
        // can remove multiple if let(s) with comma separated
        if let faceViewController = destinationViewController as? ViewController,
             let identifier = segue.identifier,
                let expression = emotionalFaces[identifier] {
                    faceViewController.expression = expression
                    faceViewController.navigationItem.title = (sender as? UIButton)?.currentTitle
                }
        
    }
    private let emotionalFaces : Dictionary<String,FacialExpression> =
        [
            "Sad" : FacialExpression(eyes : FacialExpression.Eyes.closed, mouth : .frown),
            "Worried" : FacialExpression(eyes : FacialExpression.Eyes.open, mouth : .smirk),
            "Happy" : FacialExpression(eyes : FacialExpression.Eyes.open, mouth : .smile),
        ]

}
