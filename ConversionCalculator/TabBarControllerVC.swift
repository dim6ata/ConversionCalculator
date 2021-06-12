//
//  TabBarControllerVC.swift
//  ConversionCalculator
//
//  Created by dim6ata on 19/03/2021.
//

import UIKit

/**
 UserDefaults which is used within all classes of the current project.
 */
let userDefault = UserDefaults.standard
/**
 NotificationCenter connection which is used within all classes of the current project.
 */
let notificationCenter = NotificationCenter.default


/**
 Class that manages tab bar controller.
 */
class TabBarControllerVC: UITabBarController {
    
    /**
     Tab bar object
     */
    @IBOutlet weak var conversionTabBar: UITabBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkDefaultsAvailable()
        notificationCenter.addObserver(self, selector: #selector(onAppInterrupt), name:UIApplication.willResignActiveNotification, object: nil)
        
        
    }
    
    /**
     
     */
    @objc func onAppInterrupt(){
        
        NavSettings.currentTabSelection = self.selectedIndex
        
        userDefault.set(NavSettings.currentTabSelection, forKey: DEFAULT_KEY.CURRENT_TAB.rawValue)
    }
    
    func checkDefaultsAvailable(){
        if let buttonPosition = userDefault.value(forKey: DEFAULT_KEY.CURRENT_TAB.rawValue) as? Int{
            NavSettings.currentTabSelection = buttonPosition
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.selectedIndex =
            NavSettings.currentTabSelection
        
    }
    
}
