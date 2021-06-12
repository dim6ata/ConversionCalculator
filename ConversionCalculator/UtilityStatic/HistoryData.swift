//
//  HistoryModel.swift
//  ConversionCalculator
//
//  Created by dim6ata on 20/03/2021.
//

import Foundation
import UIKit

/**
 Global variable holding the number of conversion pages that would be displayed on the system. Current value is 5.
 */
let NUM_PAGES = 5
/**
 Global variable holding the limit of  elements to store and display on each hisotry page. Currently displaying 5 elements.
 */
let NUM_ELEMENTS_TO_PRINT = 5
/**
 
 */
let MIN_ELEMENTS = 1
/**
 Singleton class that provides a list of history model elements.
 It is intended to be shared between Conversion and History classes.
 */
class HistoryData{
    
    /**
     List that stores HistoryModelTemplate objects, one for each existing sections.
     */
    var historyDataList:[HistoryModel]!
    
    
    /**
     Element that is used for initialising singleton HistoryData object
     */
    static let shared = HistoryData()
    
    /**
     Singleton constructor set to private to avoid the creation of multiple objects.
     */
    private init(){
        
        historyDataList = [HistoryModel]()
        for i in 0..<NUM_PAGES{
            let model = HistoryModel(id: i)
            historyDataList.append(model)
        }
        
        checkDefaultsAvailable()//checks if there are any defaults to load from UserDefaults
        
        notificationCenter.addObserver(self, selector: #selector(onAppInterrupt), name:UIApplication.willResignActiveNotification, object: nil)
    }
    
    /**
     Goes through stored UserDefaults to find if there are matching values.
     */
    private func checkDefaultsAvailable(){
        
        for i in 0..<historyDataList.count{
            if let savedList = userDefault.object(forKey: MEASURE.getName(i)) as? [String]{
                historyDataList[i].historyData = savedList
            }
        }
    }
    
    /**
     Method that is called when a notification is called. 
     */
    @objc private func onAppInterrupt(){
        
        for element in 0..<historyDataList.count{
            userDefault.set(historyDataList[element].historyData, forKey: MEASURE.getName(element))            
        }
    }
    
}
