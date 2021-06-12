//
//  LengthModel.swift
//  ConversionCalculator
//
//  Created by dim6ata on 16/03/2021.
//

import Foundation
/**
 Length enum containing displayable values and their respective ID's in the program
 */
enum Length : String, CaseIterable{
    
    case METER = "m"
    case KM = "km"
    case MILES = "mi"
    case CENT = "cm"
    case MILLI = "mm"
    case YARD = "yd"
    case INCH = "in"
    
    /**
     An array of all enum elements, allowing access to all values by their index
     */
    static var array : [Length]{return self.allCases}
    /**
     Retrieves the ID of a given enum value
     */
    func getID()->Int{
        return Length.array.firstIndex(of: self)!
    }
    /**
     Retrieves the name of a case, based on an id element provided
     */
    static func getName(_ id: Int)-> String{
        return Length.array[id].rawValue
    }
    
}

/**
 Provides the data and logic for Length conversions
 */
class LengthModel: CustomConversionModel{
    
    
    var meter = Measurement(value: 0, unit: UnitLength.meters)
    var km = Measurement(value: 0, unit: UnitLength.kilometers)
    var mile = Measurement(value: 0, unit: UnitLength.miles)
    var cm = Measurement(value: 0, unit: UnitLength.centimeters)
    var mm = Measurement(value: 0, unit: UnitLength.millimeters)
    var yard = Measurement(value: 0, unit: UnitLength.yards)
    var inch = Measurement(value: 0, unit: UnitLength.inches)
    
    var lengthMeasurements: [Measurement<UnitLength>]!
    
    
    init(){
        lengthMeasurements = [Measurement<UnitLength>]()
        lengthMeasurements.append(meter)
        lengthMeasurements.append(km)
        lengthMeasurements.append(mile)
        lengthMeasurements.append(cm)
        lengthMeasurements.append(mm)
        lengthMeasurements.append(yard)
        lengthMeasurements.append(inch)
        
    }
    
    /**
     Converts provided data to necessary measurement types.
     */
    func convert(id: Int, val: Double) -> Dictionary<Int, String> {
        
        lengthMeasurements[id].value = val
        
        var measurements: [Int:String] = [Int:String]()
        
        for counter in 0..<lengthMeasurements.count{
            
            if counter == id {
                continue
            }
            
            lengthMeasurements[counter].value = lengthMeasurements[id].converted(to: lengthMeasurements[counter].unit).value
            
            measurements[counter] = formatValue(number: lengthMeasurements[counter].value)
            
        }
        
        return measurements
    }
    
    /**
     Returns a string with all the conversion formatted values
     */
    func getFormattedConversionText() -> String {
        var text:String = ""
        for element in 0..<lengthMeasurements.count{
            let value = formatValue(number: lengthMeasurements[element].value)
            
            if element < lengthMeasurements.count - 1{
                text.append("\(value) \(Length.getName(element)) = \n")
            }
            else{
                text.append("\(value) \(Length.getName(element))")
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
