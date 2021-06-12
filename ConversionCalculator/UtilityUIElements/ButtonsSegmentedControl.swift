//
//  ButtonsSegmentedControl.swift
//  ConversionCalculator
//
//  Created by dim6ata on 13/03/2021.
//

import Foundation
import UIKit

/**
 Referenced from (user7652057, 2017) - https://stackoverflow.com/questions/42573378/change-the-height-of-uisegmented-control-using-ib
 
 A custom SegmentedControl class which adds fields in Storyboard editor.
 */
@IBDesignable class ButtonsSegmentedControl: UISegmentedControl{
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @IBInspectable var height: CGFloat = 30{
        didSet{
            let newCentre = center
            frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: height)
            center = newCentre
        }
        
    }
    
    
    @IBInspectable var background:UIColor!{
        didSet{
            if let newColour = background{
                backgroundColor = newColour
                
            }else{
                backgroundColor = UIColor.white
            }
        }
    }
}


