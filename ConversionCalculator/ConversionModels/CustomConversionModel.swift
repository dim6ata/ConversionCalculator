//
//  ConversionModelProtocol.swift
//  ConversionCalculator
//
//  Created by dim6ata on 16/03/2021.
//

import Foundation
import UIKit

/**
 A protocol that sets up the template of necessary methods for Conversion Models. 
 */
protocol CustomConversionModel{
    
    func convert(id: Int, val: Double) -> Dictionary<Int,String>
    
    func getFormattedConversionText()->String
    
    func formatValue(number: Double)->String
}
