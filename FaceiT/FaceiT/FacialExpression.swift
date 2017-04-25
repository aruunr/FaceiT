//
//  FacialExpression.swift
//  FaceiT
//
//  Created by Arun Ramaswamy on 4/23/17.
//  Copyright © 2017 Arun Ramaswamy. All rights reserved.
//

import Foundation

//Model for representing facial expressionl
struct FacialExpression
{

    enum Eyes : Int {
        case open
        case closed
        case squinting
    }

    enum Mouth : Int {
        case frown
        case smirk
        case neutral
        case grin
        case smile
    
        var sadder : Mouth {
            return Mouth(rawValue : rawValue - 1) ?? .frown
        }
        
        var happier : Mouth {
            return Mouth(rawValue : rawValue + 1) ?? .smile
        }
    
    }
    
    let eyes : Eyes
    let mouth : Mouth
    
    var sadder : FacialExpression {
        return FacialExpression(eyes : self.eyes, mouth : self.mouth.sadder)
    }
    
    var happier : FacialExpression {
        return FacialExpression(eyes : self.eyes, mouth : self.mouth.happier)
    }

}
