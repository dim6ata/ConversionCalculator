//
//  NavSettings.swift
//  ConversionCalculator
//
//  Created by dim6ata on 16/03/2021.
//
//import UIKit
import Foundation


/**
 Class containing static utility elements that are associated with the navigation
 functionality of the application.
 */
class NavSettings{
    
    /**
     Holds the value of the currently selected navigation button
     */
    static var currentNavSelection = 0
    
    
    /**
     Holds the value of true when the Navigation related defaults are loaded and false when they are not yet loaded
     */
    static var areNavigationDefaultsLoaded = false
    
    /**
     Holds the value of the currently selected Tab Bar element
     */
    static var currentTabSelection = 0
    
    
    /**
     Holds the value of the notification name used for passing data between ConversionViewController and HistoryViewController
     */
    static let NavigationNotificationName = Notification.Name(DEFAULT_KEY.NAV_NOTIF_NAME.rawValue)
    
    
    
}
