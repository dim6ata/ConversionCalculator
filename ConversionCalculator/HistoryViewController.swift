//
//  HistoryViewController.swift
//  ConversionCalculator
//
//  Created by dim6ata on 08/02/2021.
//  FOLLOWING LINK RESOURCE USED TO LEARN ABOUT SCROLL VIEWS(Go back to it in case of forgetting):
//  https://medium.com/@barteknowacki/uiscrollview-explained-uiscrollview-with-auto-layout-and-content-layout-guides-tutorial-77cf158a47e3
//

import UIKit

/**
 Class that is responsible for the management of History View.
 */
class HistoryViewController: UIViewController {
    
    /**
     Array holding history view controller elements
     */
    var historyVCList: [HistoryTemplateViewController]!
    
    /**
     StackView container which is used to contain HistoryTemplateViewController views.
     It is used to display a specific view depending on SegmentedControl button selection
     */
    @IBOutlet weak var stackContainer: UIStackView!
    
    /**
     Keeps a value of previously selected id
     */
    var previousViewID: Int!
    
    /**
     The navigation bar object of type UISegmentedControl
     */
    @IBOutlet weak var conversionButtons: UISegmentedControl!
    
    
    /**
     An array containing all History Model elements for a particular
     */
    var historyModelsList: [HistoryModel]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkHistoryModelListIsInitialised()
        checkDefaultsAvailable()
        initViews()
        notificationCenter.addObserver(self, selector: #selector(onAppInterrupt), name:UIApplication.willResignActiveNotification, object: nil)
        
        
        
        /**
         Not used - can delete if not needed later.
         */
        notificationCenter.addObserver(forName: NavSettings.NavigationNotificationName,
                                       object: nil,
                                       queue: nil,
                                       using:handleHistoryData)
        
    }
    
    /**
     Initialises the list containing individual HistoryModelTemplate objects. There would be one that is associated to
     each page. 
     */
    func initHistoryModelsList(){
        
        historyModelsList = HistoryData.shared.historyDataList
    }
    
    /**
     Ensures that History Data can be written to even if the history page has not been called.
     */
    func checkHistoryModelListIsInitialised(){
        
        if historyModelsList == nil {
            initHistoryModelsList()
        }
    }
    
    
    /**
     Runs ieach time before the view appears on screen
     */
    override func viewWillAppear(_ animated: Bool) {
        
        populateHistoryData()
        changeSelection()
    }
    
    /**
     Goes through all TextView elements of the currently selected view controller and if corresponding data is available the elements are made visible and their text populated as per the stored data.
     */
    func populateHistoryData(){
        var index = 0
        
        for element in historyVCList[NavSettings.currentNavSelection].viewCollection{
            if HistoryData.shared.historyDataList[NavSettings.currentNavSelection].historyData.count>index{
                
                let data = HistoryData.shared.historyDataList[NavSettings.currentNavSelection].historyData[index]
                
                element.text = data
                
                //shows the containers that contain data. 
                historyVCList[NavSettings.currentNavSelection].containerList[index].isHidden = false
                
            }
            else{
                historyVCList[NavSettings.currentNavSelection].containerList[index].isHidden = true
            }
            index += 1
        }
        
    }
    
    
    /**
     Used to change the views and segmented control selection based on changes made in ConversionViewController
     */
    func changeSelection(){
        conversionButtons.selectedSegmentIndex = NavSettings.currentNavSelection
        stackContainer.bringSubviewToFront(historyVCList[NavSettings.currentNavSelection].view)
    }
    
    /**
     Used to populate application data in case it is available.
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
     Handles NotificationCenter events. It is used to store data when the app goes into the background.
     */
    @objc func onAppInterrupt(){
        
        userDefault.set(NavSettings.currentNavSelection, forKey: DEFAULT_KEY.CURRENT_BUTTON.rawValue)
    }
    
    
    
    /**
     Responsible for initialising individual conversion view elements
     */
    func initViews(){
        
        historyVCList = [HistoryTemplateViewController]()
        for i in 0..<NUM_PAGES{
            let page = HistoryTemplateViewController()
            page.viewID = i
            historyVCList.append(page)
        }
        
        for vc in historyVCList{
            
            stackContainer.addSubview(vc.view)
            
        }
    }
    
    /**
     Handles Navigation Button Selection
     */
    @IBAction func NavigationButtonsValueChanged(_ sender: UISegmentedControl) {
        
        previousViewID = NavSettings.currentNavSelection//assigns to the previous id, keeping track, to ensure clearing of values
        NavSettings.currentNavSelection = sender.selectedSegmentIndex
        populateHistoryData()
        stackContainer.bringSubviewToFront(historyVCList[NavSettings.currentNavSelection].view)
        
    }
    
    
    /**
     Not currently used
     */
    @objc func handleHistoryData(notification:Notification){
        if let data = notification.userInfo![DEFAULT_KEY.INFO_DATA_NAME]{
            checkHistoryModelListIsInitialised()
            print("The received string is : \(data)")
        }
    }
    
    
}
