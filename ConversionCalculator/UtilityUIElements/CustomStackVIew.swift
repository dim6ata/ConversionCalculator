//
//  CustomStackVIew.swift
//  ConversionCalculator
//
//  Created by dim6ata on 17/03/2021.
//

import Foundation
import UIKit

/**
 Customises UIStackView elements to allow for the editing up border radius.
 */
@IBDesignable
class CustomStackView: UIStackView{
    
    
    @IBInspectable var borderRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = borderRadius
        }
    }
    
    
}
