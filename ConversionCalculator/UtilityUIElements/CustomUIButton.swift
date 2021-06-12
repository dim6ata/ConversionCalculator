//
//  CustomUIButton.swift
//  ConversionCalculator
//
//  Created by dim6ata on 13/03/2021.
//

import Foundation
import UIKit

/**
 Class that creates editable fields for desired UITextField elements.
 */
@IBDesignable
class CustomUIButton: UIButton{
    
    //    @IBInspectable var borderColor: UIColor? {
    //        didSet {
    //            layer.borderColor = borderColor?.cgColor
    //        }
    //    }
    //
    //    @IBInspectable var borderWidth: CGFloat = 0 {
    //        didSet {
    //            layer.borderWidth = borderWidth
    //        }
    //    }
    
    @IBInspectable var borderRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = borderRadius
        }
    }
    
    
}
