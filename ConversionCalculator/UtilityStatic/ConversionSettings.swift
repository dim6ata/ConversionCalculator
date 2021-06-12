//
//  DecimalFomatter.swift
//  ConversionCalculator
//
//  Created by dim6ata on 17/03/2021.
//

import Foundation
import UIKit

/**
 Statically sets the number of decimal places to be used in the system.
 Also creates a formatter based upon the value of decimalPlaces
 */
class ConversionSettings{
    
    
    /**
     Variable holding number of decimal places that would be displayed for conversions. It is set in SettingsViewController and used in ConversionViewController.
     */
    static var decimalPlaces = 2
    
    /**
     Creates a format based on the value of decimalPlaces
     */
    static func getFormat()->String{
        return "%."+String(decimalPlaces)+"f"
    }
    
    /**
     Variable holding a boolean value for whether the user wants to be warned about temperature checks that go below absolute zero.
     The reason is because the conversion is possible, however negative values for kelvins are generally not allowed.
     */
    static var isTemperatureCheckRequested = false
    
}
