//
//  WeightViewController.swift
//  ConversionCalculator
//
//  Created by dim6ata on 13/03/2021.
//

import UIKit

class WeightViewController: ConversionTemplateViewController, KeyboardDelegate {
    
    //VARIABLES
    /**
     Array that contains Weight UITextField elements
     */
    @IBOutlet var textFieldsCollection: [UITextField]!
    
    /**
     Measurement model for all weight related units
     */
    var weightModel = WeightModel()
    
    /**
     initialises popup keyboard controller class. Not currently in use.
     */
    var keyController = CustomKeyboardConversionViewController()
    
    
    
    /**
     **********************************************************
     ACTIONS
     **********************************************************
     */
    
    
    /**
     Changes the id of the currently selected UITextField
     */
    @IBAction func weightTextFieldSelection(_ sender: UITextField) {
        currentTextFieldID = sender.tag
    }
    
    /**
     Handler for editing changed.
     */
    @IBAction func textFieldsEditingChanged(_ sender: UITextField) {
        performConversion()
    }
    
    /**
     **********************************************************
     METHODS
     **********************************************************
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tfArray = textFieldsCollection{
            textFields = tfArray
        }
        
        model = weightModel
        initTextFields()
        initKeyboard()
        
        //        initPopupKeyboard()//NOT FULLY IMPLEMENTED
    }
    
    
    
    /**
     **********************************************************
     NOT FULLY IMPLEMENTED CODE USING POPUP KEYBOARD
     **********************************************************
     */
    
    /**
     Popup keyboard handler
     NOT CURRENTLY USED.
     */
    func buttonWasPressed(text: String) {
        textFieldsCollection[0].insertText(text)
    }
    
    
    /**
     initialises popup keyboard if required.
     Not Fully Implemented.
     <br>Use on screen keyboard from ConversionViewController
     */
    func initPopupKeyboard(){
        keyController.delegate = self
        let customKeyboard = keyController.view
        for field in textFieldsCollection{
            field.inputView = customKeyboard
        }
    }
    
}
