//
//  WeightMeasurementModel.swift
//  ConversionCalculator
//
//  Created by dim6ata on 15/03/2021.
//

import Foundation

/**
 Enum for Weight elements, containing the measurement labels as well as ID locations.
 */
enum Weight : String, CaseIterable{
    
    case KG = "kg"
    case GRAM = "g"
    case OUNCE = "oz"
    case STONE = "st"
    case STONE_POUND = "lb"
    case POUND = "lb "
    
    /**
     An array of all enum elements, allowing access to all values by their index
     */
    static var array : [Weight]{return self.allCases}
    
    /**
     Retrieves the ID of a given enum value
     */
    func getID()->Int{
        return Weight.array.firstIndex(of: self)!
    }
    
    /**
     Retrieves the raw value (name) of a case, based on an id element provided
     */
    static func getName(_ id: Int)-> String{
        return Weight.array[id].rawValue
    }
    
}

/**
 Provides the data and logic for weight conversions
 */
class WeightModel: CustomConversionModel{
    
    
    
    var kg =  Measurement(value: 0, unit: UnitMass.kilograms)
    var gram =  Measurement(value: 0, unit: UnitMass.grams)
    var ounce = Measurement(value: 0, unit: UnitMass.ounces)
    var stone = Measurement(value: 0, unit: UnitMass.stones)
    var stonePound = Measurement(value: 0, unit: UnitMass.pounds)
    var pound = Measurement(value: 0, unit: UnitMass.pounds)
    
    var weightMeasurements: [Measurement<UnitMass>]!
    
    
    init(){
        
        
        weightMeasurements = [Measurement<UnitMass>]()
        weightMeasurements.append(kg)
        weightMeasurements.append(gram)
        weightMeasurements.append(ounce)
        weightMeasurements.append(stone)
        weightMeasurements.append(stonePound)
        weightMeasurements.append(pound)
        
    }
    
    
    
    /**
     Converts provided data to necessary measurement types.
     */
    func convert(id:Int, val: Double) -> Dictionary<Int,String>{
        
        weightMeasurements[id].value = val// the element that is converted from
        
        
        var measurements: [Int:String] = [Int:String]()//dictionary with converted values
        
        for counter in 0..<weightMeasurements.count{
            if counter == id {//prevents the change of currently edited value
                if id == Weight.STONE.getID(){//when stones entered prevents from changing stone pounds value - e.g 13.4 entered would not change the stone pound.
                    assignMeasurementValues(id, counter)
                }
                continue
            }
            assignMeasurementValues(id, counter)//performs conversions
            
            measurements[counter] = formatValue(number: weightMeasurements[counter].value)
            
        }//end loop
        
        return measurements
    }
    
    /**
     Determines and performs a conversion for selected elements
     - parameters:
     - id - holds the value of the currently edited element
     - counter - holds the value of the currently converted element.
     */
    private func assignMeasurementValues(_ id: Int,_ counter: Int){
        
        switch counter {
        case Weight.STONE.getID():
            performStonePoundConversion(id)
            break
        case Weight.STONE_POUND.getID():
            if id == Weight.STONE.getID(){
                performStonePoundConversion(id)
            }
            break
        default:
            weightMeasurements[counter].value =  weightMeasurements[id].converted(to: weightMeasurements[counter].unit).value
        }//end switch
    }
    
    /**
     Converts a value in stones to Stones in <Int> and pounds of the remainder of the stones value.
     */
    private func performStonePoundConversion(_ id: Int){
        let convertedStones = weightMeasurements[id].converted(to: UnitMass.stones).value
        let remainderInStones =  Measurement(value: convertedStones.truncatingRemainder(dividingBy: 1),unit: UnitMass.stones)
        weightMeasurements[Weight.STONE.getID()].value = floor(convertedStones)
        weightMeasurements[Weight.STONE_POUND.getID()].value = remainderInStones.converted(to: UnitMass.pounds).value
        
    }    
    
    /**
     Returns a string with all the conversion values
     */
    func getFormattedConversionText() -> String {
        
        var text:String = ""
        for index in 0..<weightMeasurements.count{
            
            let value = formatValue(number: weightMeasurements[index].value)
            if index < weightMeasurements.count - 1{
                if index == Weight.STONE.getID() {
                    text.append("\(value) \(Weight.getName(index)) and ")
                }
                else{
                    text.append("\(value) \(Weight.getName(index)) = \n")
                }
            }
            else{
                text.append("\(value) \(Weight.getName(index))")
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
        
        //        return String( format: ConversionSettings.getFormat(), number)
    }
    
    
}


