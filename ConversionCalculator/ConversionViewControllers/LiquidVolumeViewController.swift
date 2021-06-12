//
//  LiquidVolumeViewController.swift
//  ConversionCalculator
//
//  Created by dim6ata on 13/03/2021.
//

import UIKit

class LiquidVolumeViewController: ConversionTemplateViewController {
    
    
    @IBOutlet var textFieldsCollection: [UITextField]!
    
    
    @IBAction func volumeTextFieldSelected(_ sender: UITextField) {
        currentTextFieldID = sender.tag
    }
    
    
    @IBAction func textFieldsEditingChanged(_ sender: UITextField) {
        performConversion()
    }
    
    /**
     Measurement model for all volume related units
     */
    var liquidVolumeModel = LiquidVolumeModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tfArray = textFieldsCollection{
            textFields = tfArray
        }
        model = liquidVolumeModel
        initTextFields()
        initKeyboard()
    }
}
