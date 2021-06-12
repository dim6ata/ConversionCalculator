//
//  CustomStackPanel.swift
//  ConversionCalculator
//
//  Created by Dimitar Ralev on 17/03/2021.
//

import Foundation

@IBDesignable
class CustomStackPanel: UIButton {

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
