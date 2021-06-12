//
//  TemperatureModel.swift
//  ConversionCalculator
//
//  Created by dim6ata on 13/03/2021.
//

import Foundation

import UIKit

/**
 Temperature enum containing displayable values and their respective ID's in the program
 */
enum Temperature : String, CaseIterable{
    
    case CELSIUS = "°C"
    case FAHRENHEIT = "°F"
    case KELVIN = "K"
    
    /**
     An array of all enum elements, allowing access to all values by their index
     */
    static var array : [Temperature]{return self.allCases}
    
    /**
     Retrieves the ID of a given enum value
     */
    func getID()->Int{
        return Temperature.array.firstIndex(of: self)!
    }
    
    /**
     Retrieves the name of a case, based on an id element provided
     */
    static func getName(_ id: Int)-> String{
        return Temperature.array[id].rawValue
    }
}

/**
 Provides the data and logic for Temperature conversions
 */
class TemperatureModel:CustomConversionModel{
    
    
    var celsius = Measurement(value: 0, unit: UnitTemperature.celsius)
    var fahrenheit = Measurement(value: 0, unit: UnitTemperature.fahrenheit)
    var kelvin = Measurement(value: 0, unit: UnitTemperature.kelvin)
    var tempMeasurements: [Measurement<UnitTemperature>]!
    
    
    init(){
        
        tempMeasurements = [Measurement<UnitTemperature>]()
        tempMeasurements.append(celsius)
        tempMeasurements.append(fahrenheit)
        tempMeasurements.append(kelvin)
        
    }
    
    /**
     Converts provided data to necessary measurement types.
     */
    func convert(id: Int, val: Double) -> Dictionary<Int, String> {
        
        tempMeasurements[id].value = val
        
        var measurements: [Int:String] = [Int:String]()
        
        for counter in 0..<tempMeasurements.count{
            
            if counter == id {
                continue
            }
            
            tempMeasurements[counter].value = tempMeasurements[id].converted(to: tempMeasurements[counter].unit).value
            
            measurements[counter] = formatValue(number: tempMeasurements[counter].value)
        }
        
        return measurements
    }
    
    /**
     Sets the minimum possible value for Celsius Temperatures
     */
    let CELSIUS_MIN = -273.15
    
    /**
     Sets the minimum possible value for Fahrenheit Temperatures
     */
    let FAHRENHEIT_MIN = -459.67
    
    /**
     Sets the minimum possible value for Kelvin Temperatures
     */
    let KELVIN_MIN = 0
    
    /**
     Checks validity of temperature, no temperature should go below absolute zero or 0 Kelvins.
     */
    func isTempValid(temp: String, id: Int)->Bool{
        
        if let value = Double(temp){
            
            switch id {
            case Temperature.CELSIUS.getID():
                return value >= CELSIUS_MIN
            case Temperature.FAHRENHEIT.getID():
                return value >= FAHRENHEIT_MIN
            case Temperature.KELVIN.getID():
                return Int(value) >= KELVIN_MIN
                
            default:
                return false
            }
        }
        else{
            return false
        }
    }
    
    /**
     Returns a string with all the conversion formatted values
     */
    func getFormattedConversionText() -> String {
        var text:String = ""
        for element in 0..<tempMeasurements.count{
            let value = formatValue(number: tempMeasurements[element].value)
            
            if element < tempMeasurements.count - 1{
                text.append("\(value) \(Temperature.getName(element)) = \n")
            }
            else{
                text.append("\(value) \(Temperature.getName(element))")
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
