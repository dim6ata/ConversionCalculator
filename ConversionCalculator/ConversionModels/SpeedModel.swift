//
//  SpeedModel.swift
//  ConversionCalculator
//
//  Created by dim6ata on 16/03/2021.
//

import Foundation
/**
 Speed enum containing displayable values and their respective ID's in the program
 */
enum Speed : String, CaseIterable{
    
    case KM_H = "km/h"
    case M_S = "m/s"
    case MPH = "mph"
    case KNOT = "kn"
    /**
     An array of all enum elements, allowing access to all values by their index
     */
    static var array : [Speed]{return self.allCases}
    /**
     Retrieves the ID of a given enum value
     */
    func getID()->Int{
        return Speed.array.firstIndex(of: self)!
    }
    /**
     Retrieves the name of a case, based on an id element provided
     */
    static func getName(_ id: Int)-> String{
        return Speed.array[id].rawValue
    }
    
}
/**
 Provides the data and logic for Speed conversions
 */
class SpeedModel: CustomConversionModel{
    
    
    var kmh = Measurement(value: 0, unit: UnitSpeed.kilometersPerHour)
    var ms = Measurement(value: 0, unit: UnitSpeed.metersPerSecond)
    var mph = Measurement(value: 0, unit: UnitSpeed.milesPerHour)
    var knot = Measurement(value: 0, unit: UnitSpeed.knots)
    
    var speedMeasurements: [Measurement<UnitSpeed>]!
    
    
    init(){
        speedMeasurements = [Measurement<UnitSpeed>]()
        speedMeasurements.append(kmh)
        speedMeasurements.append(ms)
        speedMeasurements.append(mph)
        speedMeasurements.append(knot)
    }
    /**
     Converts provided data to necessary measurement types.
     */
    func convert(id: Int, val: Double) -> Dictionary<Int, String> {
        
        speedMeasurements[id].value = val
        
        var measurements: [Int:String] = [Int:String]()
        
        for counter in 0..<speedMeasurements.count{
            
            if counter == id {
                continue
            }
            
            speedMeasurements[counter].value = speedMeasurements[id].converted(to: speedMeasurements[counter].unit).value
            
            measurements[counter] = formatValue(number: speedMeasurements[counter].value)
        }
        
        return measurements
    }
    
    /**
     Returns a string with all the conversion values
     */
    func getFormattedConversionText() -> String {
        
        var text:String = ""
        for element in 0..<speedMeasurements.count{
            
            let value = formatValue(number: speedMeasurements[element].value)
            
            if element < speedMeasurements.count - 1{
                text.append("\(value) \(Speed.getName(element)) = \n")
            }
            else{
                text.append("\(value) \(Speed.getName(element))")
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
