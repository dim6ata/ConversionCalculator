//
//  HistoryTempVC.swift
//  ConversionCalculator
//
//  Created by w1696151 on 14/03/2021.
//TODO DELETE

import UIKit


class HistoryTempVC : UIViewController {


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
     Initialises page elements.
     */
    func initiailiseElements(){
        
        pageTitle.text = "\(MEASURE.getName(viewID)) HISTORY"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        initiailiseElements()
        
    }



}
