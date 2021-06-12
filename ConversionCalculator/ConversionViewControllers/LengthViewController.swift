//
//  LengthViewController.swift
//  ConversionCalculator
//
//  Created by dim6ata on 13/03/2021.
//

import UIKit

class LengthViewController: ConversionTemplateViewController {
    
    
    @IBOutlet var textFieldsCollection: [UITextField]!
    
    
    @IBAction func lengthTextFieldSelected(_ sender: UITextField) {
        currentTextFieldID = sender.tag
    }
    
    
    @IBAction func textFieldsEditingChanged(_ sender: UITextField) {
        performConversion()
    }
    
    /**
     Model that deals with all Length related conversions
     */
    var lengthModel = LengthModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tfArray = textFieldsCollection{
            textFields = tfArray
        }
        model = lengthModel
        initTextFields()
        initKeyboard()
        
    }
    
    
}
