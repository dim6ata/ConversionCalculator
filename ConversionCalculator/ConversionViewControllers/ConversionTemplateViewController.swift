//
//  ConversionTemplateViewController.swift
//  ConversionCalculator
//
//  Created by dim6ata on 15/03/2021.
//

import UIKit

///Allows subviews to throw a notification message in the main view controller.
protocol AlertDelegate{
    
    /**
     Method that would create an alert dialogue
     - parameters:
     - title - holds the string value of the text that would be displayed as a title of the alert dialogue
     - text - holds the main body of the text that would notify the user with the desired message.
     */
    func raiseAlert(title: String, text:String)
}

/**
 Referenced from (LimeRed, 2017) - https://stackoverflow.com/questions/32339717/how-to-remove-characters-from-a-string-in-swift
 */
extension String {
    
    func removeCharacters(from forbiddenChars: CharacterSet) -> String {
        let passed = self.unicodeScalars.filter { !forbiddenChars.contains($0) }
        return String(String.UnicodeScalarView(passed))
    }
    
    func removeCharacters(from: String) -> String {
        return removeCharacters(from: CharacterSet(charactersIn: from))
    }
}


/**
 Template UIViewController Class that is reused for all ConversionViewController elements
 */
class ConversionTemplateViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /**
     Dictionary of <Key = Int (UITextField Tag): Value = UITextField>
     */
    var textFieldsDict : [Int:UITextField]!
    
    /**
     Array of UITextField elements that is assigned the value of individual ViewControllers' Outlet Collections.
     */
    var textFields:[UITextField]!
    
    /**
     Central model that is assigned according to which class is using it
     */
    var model : CustomConversionModel!
    
    /**
     Contains the value of currently selected UITextField
     */
    var currentTextFieldID : Int!
    
    ///A delegate instance which connects sub-view controllers with their parent.
    var alertDelegate: AlertDelegate?
    
    /**
     Initialises Text Fields: to be called after textFields has been assigned.
     */
    func initTextFields(){
        /**
         Conversion from array to dictionary referenced from:
         (Upset Unicorn, 2020) - https://www.codegrepper.com/code-examples/swift/swift+map+array+to+dictionary
         */
        textFieldsDict = textFields.reduce([Int: UITextField]()) { (dict, col) -> [Int: UITextField] in
            var dictionary = dict
            dictionary[col.tag] = col
            return dictionary
        }
    }
    
    /**
     Initialises custom keyboard by disabling popup keyboards that may be assigned to text fields
     */
    func initKeyboard(){
        for field in textFields{
            field.inputView = UIView()//removes the popup keyboard, allowing only on screen keyboard to be used.
        }
    }
    
    /**
     Types numeric values into currently selected text field.
     */
    public func typeInTextField(text:String){
        
        //only when an element is selected the typing will happen:
        if let id = currentTextFieldID{
            textFieldsDict[id]?.insertText(text)
        }
    }
    
    /**
     Clears the currently selected text fields id. Used when leaving the view in order to avoid typing within a field when
     nothing is selected
     */
    public func clearSelectionUponChange(){
        currentTextFieldID = nil
    }
    
    /**
     Performs conversion calculations
     */
    public func performConversion(){
        
        var text = textFieldsDict[currentTextFieldID]?.text
        
        //Ensures text formatting is cleared before converting TextField text to Double for conversions:
        if ((text?.contains(",")) != nil){
            text = text?.removeCharacters(from: ",")
        }
        
        //Attempts to convert TextField text to double:
        if let num = Double(text!){
            if let model = self.model {//checks model
                let results = model.convert(id: currentTextFieldID, val: num)
                
                for index in 0..<textFields.count{
                    if index != currentTextFieldID{
                        textFieldsDict[index]?.text = results[index]
                    }
                }
            }
        } else{//when empty clears the textfields
            clearTextFields()
        }
    }
    
    ///Method that is responsible for clearing of all textfields
    func clearTextFields(){
        for field in textFields{
            field.text = ""
        }
    }
    
    
    /**
     Deletes the last character of a selected element
     */
    func deleteLastCharacter() {
        if let id = currentTextFieldID{
            textFieldsDict[id]?.deleteBackward()//removes selected position of text field
            performConversion()
        }
    }
    
    
    /**
     Method that is used only at specific situations.
     Only for specific models would the negative button work.
     */
    public func negateValue(){}
    
    /**
     Allows access to a selected model's displayable data 
     */
    func getModelString()->String{
        
        return model.getFormattedConversionText()
        
    }
    
    
}
