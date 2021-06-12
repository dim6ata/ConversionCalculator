//
//  HistoryModelTemplate.swift
//  ConversionCalculator
//
//  Created by dim6ata on 20/03/2021.
//

import Foundation

/**
 Class that keeps a list of Strings that contain stored history of a particular Measurement type.
 Whenever the list is full the first element will be removed and the old one will be added as the last element of the list.
 */
class HistoryModel {
    
    /**
     ID of a History Model
     */
    private var id: Int!
    /**
     List of history data for a specific Measurement type.
     */
    var historyData: [String]!
    
    /**
     Initialises HistoryModel
     */
    init(id: Int){
        self.id = id
        historyData = [String]()
    }
    
    /**
     Sets data to historyData list. If the array is full it removes first element before adding to array
     */
    func setHistoryData(text: String){
        
        if historyData.count < NUM_ELEMENTS_TO_PRINT{
            historyData.append(text)
        }
        else{
            historyData.removeFirst(MIN_ELEMENTS)
            historyData.append(text)
        }
    }
}
