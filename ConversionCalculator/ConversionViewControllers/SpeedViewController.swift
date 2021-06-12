//
//  SpeedViewController.swift
//  ConversionCalculator
//
//  Created by dim6ata on 13/03/2021.
//

import UIKit
///A controller of the Speed Conversions page.
class SpeedViewController: ConversionTemplateViewController {
    
    
    ///An array of TextField objects that are present in the SpeedViewController view.
    @IBOutlet var textFieldsCollection: [UITextField]!
    
    ///Notifies when a TextField has been selected
    @IBAction func speedTextFieldSelected(_ sender: UITextField) {
        currentTextFieldID = sender.tag
    }
    
    ///Notifies when a TextField is being edited.
    @IBAction func textFieldsEditingChanged(_ sender: UITextField) {
        performConversion()
    }
    
    /**
     Model that deals with Speed related conversions
     */
    var speedModel = SpeedModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tfArray = textFieldsCollection{
            textFields = tfArray
        }
        model = speedModel
        initTextFields()
        initKeyboard()
    }
    
    
}
