//
//  LiquidVolumeModel.swift
//  ConversionCalculator
//
//  Created by dim6ata on 16/03/2021.
//

import Foundation

/**
 Volume enum containing displayable values and their respective ID's in the program
 */
enum Volume : String, CaseIterable{
    
    case LITERS = "l"
    case ML = "ml"
    case PINTS = "pt"
    case GALLON = "gal"
    case FL_OUNCE = "fluid oz"
    
    /**
     An array of all enum elements, allowing access to all values by their index
     */
    static var array : [Volume]{return self.allCases}
    
    /**
     Retrieves the ID of a given enum value
     */
    func getID()->Int{
        return Volume.array.firstIndex(of: self)!
    }
    /**
     Retrieves the name of a case, based on an id element provided
     */
    static func getName(_ id: Int)-> String{
        return Volume.array[id].rawValue
    }
    
}

/**
 Provides the data and logic for Liquid Volume conversions
 */
class LiquidVolumeModel: CustomConversionModel{
    
    
    var litre = Measurement(value: 0, unit: UnitVolume.liters)
    var millilitre = Measurement(value: 0, unit: UnitVolume.milliliters)
    var pint = Measurement(value: 0, unit: UnitVolume.imperialPints)
    var gallon = Measurement(value: 0, unit: UnitVolume.imperialGallons)
    var ounce = Measurement(value: 0, unit: UnitVolume.fluidOunces)
    
    
    var volumeMeasurements: [Measurement<UnitVolume>]!
    
    
    init(){
        volumeMeasurements = [Measurement<UnitVolume>]()
        volumeMeasurements.append(litre)
        volumeMeasurements.append(millilitre)
        volumeMeasurements.append(pint)
        volumeMeasurements.append(gallon)
        volumeMeasurements.append(ounce)
    }
    
    /**
     Converts provided data to necessary measurement types.
     */
    func convert(id: Int, val: Double) -> Dictionary<Int, String> {
        
        volumeMeasurements[id].value = val
        
        var measurements: [Int:String] = [Int:String]()
        
        for counter in 0..<volumeMeasurements.count{
            
            if counter == id {
                continue
            }
            
            volumeMeasurements[counter].value = volumeMeasurements[id].converted(to: volumeMeasurements[counter].unit).value
            
            measurements[counter] = formatValue(number: volumeMeasurements[counter].value)
        }
        
        return measurements
    }
    
    /**
     Returns a string with all the conversion formatted values
     */
    func getFormattedConversionText() -> String {
        var text:String = ""
        for element in 0..<volumeMeasurements.count{
            let value = formatValue(number: volumeMeasurements[element].value)
            
            if element < volumeMeasurements.count - 1{
                text.append("\(value) \(Volume.getName(element)) = \n")
            }
            else{
                text.append("\(value) \(Volume.getName(element))")
            }
        }
        return text
    }
    /**
     Formats a given double value into a displayable format.
     */
    func formatValue(number: Double)->String{
        
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.minimumFractionDigits = ConversionSettings.decimalPlaces
        formatter.maximumFractionDigits = ConversionSettings.decimalPlaces
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: number))!    
    }
    
}
