//
//  MEASURE.swift
//  ConversionCalculator
//
//  Created by dim6ata on 16/03/2021.
//

import Foundation

///Code referenced from (Jonathan Bronson, 2018):
///https://stackoverflow.com/questions/28461133/swift-enum-both-a-string-and-an-int
///Sets up details for measurement.
enum MEASURE: String, CaseIterable{
    
    case WEIGHT
    case TEMPERATURE
    case LIQUID_VOLUME = "LIQUID VOLUME"
    case LENGTH
    case SPEED
    
    /**
     An array of all enum elements, allowing access to all values by their index
     */
    static var measuresArray: [MEASURE] {return self.allCases}
    
    /**
     Retrieves the ID of a given enum value
     */
    func getID()->Int{
        return MEASURE.measuresArray.firstIndex(of: self)!
    }
    
    /**
     Retrieves the raw value (name) of a case, based on an id element provided
     */
    static func getName(_ id: Int)-> String{
        return MEASURE.measuresArray[id].rawValue
    }
}
