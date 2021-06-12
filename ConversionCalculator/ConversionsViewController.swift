//
//  ConversionsViewController.swift
//  ConversionCalculator
//
//  Created by dim6ata on 08/02/2021.
//NAVIGATION REFERENCED FROM (taeSwift, 2017): https://www.youtube.com/watch?v=e5nxg5NzLks&t=146s
//

import UIKit

/**
 Enumeration for special buttons' locations
 */
enum SpecialButtons: Int {
    case DELETE = 11
    case NEGATE = 12
    case SAVE = 13
}
/**
 Class responsible for handling the Conversions View of the Tab Bar Controller
 */
class ConversionsViewController: UIViewController, AlertDelegate {
    
    
    
    //VARIABLES DECLARATION
    
    /**
     Array holding conversion view elements
     */
    var conversionViews: [ConversionTemplateViewController]!
    
    /**
     Array of values used when a custom keyboard button is pressed. 
     */
    var numericValues:[String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9", ".", "0"]
    
    /**
     Connects to the UIView container that is used for displaying individual conversion view controllers
     */
    @IBOutlet weak var viewPlaceholder: UIView!
    
    /**
     Connects the segmented control buttons to current view controller
     */
    @IBOutlet weak var conversionButtons: UISegmentedControl!
    
    /**
     Keeps a value of previously selected id
     */
    var previousViewID: Int!
    
    
    
    //METHODS DECLARATION
    
    /**
     Loads the data the first time the view is created
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        checkDefaultsAvailable()
        initViews()
        notificationCenter.addObserver(self, selector: #selector(onAppInterrupt), name:UIApplication.willResignActiveNotification, object: nil)
    }
    
    /**
     If any defaults have been saved the program will retrieve them by calling this method before using any Settings values.
     */
    func checkDefaultsAvailable(){
        
        if !NavSettings.areNavigationDefaultsLoaded{
            if let buttonPosition = userDefault.value(forKey: DEFAULT_KEY.CURRENT_BUTTON.rawValue) as? Int{
                NavSettings.currentNavSelection = buttonPosition
                NavSettings.areNavigationDefaultsLoaded = true
            }
        }
    }
    /**
     Listener for NotificationCenter updates.
     */
    @objc func onAppInterrupt(){
        
        userDefault.set(NavSettings.currentNavSelection, forKey: DEFAULT_KEY.CURRENT_BUTTON.rawValue)
    }
    
    /**
     Responsible for initialising individual conversion view elements
     */
    func initViews(){
        
        conversionViews = [ConversionTemplateViewController]()
        
        conversionViews.append(WeightViewController())
        conversionViews.append(TemperatureViewController())
        conversionViews.append(LiquidVolumeViewController())
        conversionViews.append(LengthViewController())
        conversionViews.append(SpeedViewController())
        
        for vc in conversionViews{
            
            viewPlaceholder.addSubview(vc.view)
            vc.alertDelegate = self //initialises delegate
        }
    }
    
    /**
     Performed each time the view is loaded. It is intended to display the appropriate view relative to the one that has been selected in the History View
     */
    override func viewWillAppear(_ animated: Bool) {
        conversionButtons.selectedSegmentIndex = NavSettings.currentNavSelection
        
        viewPlaceholder.bringSubviewToFront(conversionViews[NavSettings.currentNavSelection].view)
    }
    
    /**
     Stops editing within the current view
     */
    func endEdit(){
        self.view.endEditing(true)
    }
    
    func finishEditingSequence(){
        endEdit()
        conversionViews[NavSettings.currentNavSelection].clearSelectionUponChange()
    }
    
    /**
     When the screen outside of text fields is selected, the text field that has been selected will lose focus.
     Referenced from (thenewbosston, 2015) - https://www.youtube.com/watch?v=HI4JV7ClXB0 [8m 3s]
     Additionally clears the selection from textfields via clearSelectionUponChange
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        finishEditingSequence()
    }
    
    
    /**
     Declares the action of segmented controller's button's press
     */
    @IBAction func navigationButtonsAction(_ sender: UISegmentedControl) {
        
        previousViewID = NavSettings.currentNavSelection
        NavSettings.currentNavSelection = sender.selectedSegmentIndex
        viewPlaceholder.bringSubviewToFront(conversionViews[NavSettings.currentNavSelection].view)
        
        endEdit()
        conversionViews[previousViewID].clearSelectionUponChange()
    }
    
    
    /**
     Handles the click events on numeric keyboard elements
     */
    @IBAction func keyboardButtonClicked(_ sender: UIButton) {
        
        conversionViews[NavSettings.currentNavSelection].typeInTextField(text: numericValues[sender.tag])
    }
    
    
    /**
     Handles the clicks on special buttons e.g delete, NEG, Save
     */
    @IBAction func specialButtonsClicked(_ sender: UIButton) {
        
        switch sender.tag {
        case SpecialButtons.DELETE.rawValue:
            
            conversionViews[NavSettings.currentNavSelection].deleteLastCharacter()
            break
            
        case SpecialButtons.NEGATE.rawValue:
            conversionViews[NavSettings.currentNavSelection].negateValue()
            break
            
        case SpecialButtons.SAVE.rawValue:
            
            
            HistoryData
                .shared
                .historyDataList[NavSettings.currentNavSelection]
                .setHistoryData(text: conversionViews[NavSettings.currentNavSelection].getModelString())
            
            conversionViews[NavSettings.currentNavSelection].clearTextFields()
            finishEditingSequence()
            
            raiseAlert(title: "Data Saved", text: "Your conversion has been stored. Go to History tab to access past conversions.")
            //            notificationCenter.post(name: NavSettings.NavigationNotificationName, object: nil, userInfo: [DEFAULT_KEY.INFO_DATA_NAME:conversionViews[NavSettings.currentNavSelection].getModelString()])
            
            break
            
        default:
            break
        }
        
    }
    
    
    /**
     Method that would create an alert dialogue
     - parameters:
     - title - holds the string value of the text that would be displayed as a title of the alert dialogue
     - text - holds the main body of the text that would notify the user with the desired message.
     */
    func raiseAlert(title: String, text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
