//
//  HistoryTemplateViewController.swift
//  ConversionCalculator
//
//  Created by dim6ata on 16/03/2021.
//

import UIKit

/**
 Creates the template for displaying history data within the main HistoryViewController. It provides the different containers where text can be shown. 
 */
class HistoryTemplateViewController: UIViewController {
    
    
    
    /**
     Identifies the view
     */
    var viewID:Int!
    
    /**
     Used to set the page title
     */
    @IBOutlet weak var pageTitle: UILabel!
    
    /**
     Collection of UITextView elements.
     They will be populated by the stored history data
     */
    @IBOutlet var viewCollection: [UITextView]!
    
    
    /**
     Collection of container StackView elements. To be used for displaying history data. Showing and hiding of this element could be beneficial depending on the number of entries there are saved on the system. 
     */
    @IBOutlet var containerList: [CustomStackView]!
    
    /**
     Initialises page elements.
     */
    func initiailiseElements(){
        pageTitle?.text = "\(MEASURE.getName(viewID)) HISTORY"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initiailiseElements()
    }
    
    
}
