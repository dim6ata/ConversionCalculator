//
//  SettingsViewController.swift
//  ConversionCalculator
//
//  Created by dim6ata on 08/02/2021.
//

import UIKit


class SettingsViewController: UIViewController {
    
    /**
     VARIABLES
     */
    
    ///array of decimal buttons.
    @IBOutlet var decimalButtons: [UIButton]!
    
    
    @IBOutlet weak var switchButton: UISwitch!
    
    ///the values that buttons
    var buttonValues : [Int] = [1, 2, 3, 4]
    
    
    /**
     METHODS
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkDefaultsAvailable()
        
        switchSelectedButtonOn(button: decimalButtons[ConversionSettings.decimalPlaces-1])
        
        switchButton.setOn(ConversionSettings.isTemperatureCheckRequested, animated: false)
        
        notificationCenter.addObserver(self, selector: #selector(onAppInterrupt), name:UIApplication.willResignActiveNotification, object: nil)
        
    }
    
    /**
     If any defaults have been saved the program will retrieve them by calling this method before using any Settings values.
     */
    func checkDefaultsAvailable(){
        if let decimalPlaces = userDefault.value(forKey: DEFAULT_KEY.DECIMAL_PLACES.rawValue) as? Int{
            ConversionSettings.decimalPlaces = decimalPlaces
        }
        
        if let isChecked = userDefault.value(forKey: DEFAULT_KEY.IS_CHECK_REQUESTED.rawValue) as? Bool{
            ConversionSettings.isTemperatureCheckRequested = isChecked
        }
    }
    
    /**
     Listener for NotificationCenter updates.
     */
    @objc func onAppInterrupt(){
        
        saveDecimalPlacesSettings()
        saveIsCheckRequestedSettings()
    }
    
    /**
     Saves decimal places to user defaults
     */
    func saveDecimalPlacesSettings(){
        userDefault.set(ConversionSettings.decimalPlaces, forKey: DEFAULT_KEY.DECIMAL_PLACES.rawValue)
    }
    
    
    /**
     Saves isTemperatureCheckRequested to user defaults
     */
    func saveIsCheckRequestedSettings(){
        userDefault.set(ConversionSettings.isTemperatureCheckRequested, forKey: DEFAULT_KEY.IS_CHECK_REQUESTED.rawValue)
    }
    
    
    ///Action handler of button clicks
    @IBAction func buttonClickedAction(_ sender: UIButton) {
        for btn in decimalButtons {
            if btn.tag == sender.tag {//only runs for the specific button
                switchSelectedButtonOn(button: btn)
                ConversionSettings.decimalPlaces = buttonValues[sender.tag]
            }
            else{//switches off all other buttons
                switchButtonOff(button: btn)
            }
        }
        //        saveDecimalPlacesSettings()//unomment if default saving is more appropiate upon each button click.
    }
    
    /**
     Change button selection colours when it is selected
     */
    func switchSelectedButtonOn(button: UIButton){
        button.backgroundColor = UIColor.systemYellow
        button.setTitleColor(UIColor.black, for: .normal)
    }
    
    /**
     Change button selection colours when it is disselected
     */
    func switchButtonOff(button: UIButton){
        button.backgroundColor = UIColor.systemIndigo
        button.setTitleColor(UIColor.white, for: .normal)
    }
    
    ///handler for switch
    ///Note UISwitch contains a bug that raises a note when pressed:
    //It is documented here: https://stackoverflow.com/questions/56980875/what-does-invalid-mode-kcfrunloopcommonmodes-mean
    @IBAction func isbelowZeroSwitch(_ sender: UISwitch) {
        
        if sender.isOn{
            ConversionSettings.isTemperatureCheckRequested = true
        }
        else{
            ConversionSettings.isTemperatureCheckRequested = false
        }
        //        saveIsCheckRequestedSettings()//uncomment if saving data is required upon each click.
    }
    
    
}
