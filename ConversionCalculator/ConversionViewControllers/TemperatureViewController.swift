//
//  TemperatureViewController.swift
//  ConversionCalculator
//
//  Created by dim6ata on 13/03/2021.
//

import UIKit


class TemperatureViewController: ConversionTemplateViewController {
    
    //Variables
    
    @IBOutlet var textFieldsCollection: [UITextField]!
    
    @IBAction func temperatureTextFieldSelected(_ sender: UITextField) {
        currentTextFieldID = sender.tag
    }
    
    @IBAction func textFieldsEditingChanged(_ sender: UITextField) {
        
        convertBasedOnUserSettings()
    }
    
    /**
     Performs a check at the user settings whether or not a temperature validation is required.
     */
    func convertBasedOnUserSettings(){
        if ConversionSettings.isTemperatureCheckRequested {
            validateTemperature()//only if valid the conversions are made
        }else{
            performConversion()
        }
    }
    
    
    ///Method that handles the verification of data entered within TextFields
    ///Such validation is required for temperature values, since temperature should not go below Absolute Zero.
    func validateTemperature(){
        
        if temperatureModel.isTempValid(temp: (textFieldsDict[currentTextFieldID]?.text)!, id: currentTextFieldID)
        {
            performConversion()
        }
        else{
            if textFieldsDict[currentTextFieldID]?.text != ""{
                
                alertDelegate?.raiseAlert(title: "Wrong Data Entered",
                                          text: "Values under \(temperatureModel.KELVIN_MIN) K, \(temperatureModel.CELSIUS_MIN)°C and \(temperatureModel.FAHRENHEIT_MIN)°F are not allowed as they fall below the absolute zero.")
            }
            clearTextFields()
        }
    }
    
    /**
     Measurement model for all temperature related units
     */
    var temperatureModel = TemperatureModel()
    
    
    /**
     
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tfArray = textFieldsCollection{
            textFields = tfArray
        }
        model = temperatureModel
        initTextFields()
        initKeyboard()
    }
    
    /**
     Negates the value of a UITextField numeric entry.
     To be implemented only for classes that allow negative values.
     Otherwise leave empty.
     */
    override func negateValue() {
        
        if let id = currentTextFieldID{
            var tempText = textFieldsDict[id]?.text
            if var number = Double(tempText!){
                number = -number
                tempText = "\(number)"
                textFieldsDict[id]?.text = tempText
                
                if ConversionSettings.isTemperatureCheckRequested {
                    validateTemperature()//only if valid the conversions are made
                }else{
                    performConversion()
                }
            }
        }
    }
    
}
