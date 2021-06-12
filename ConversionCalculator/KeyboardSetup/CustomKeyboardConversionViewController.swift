//
//  CustomKeyboardConversionViewController.swift
//  ConversionCalculator
//
//  Created by dim6ata on 13/03/2021.
//NOT USED CURRENTLY

import UIKit

/**
 Sets up keyboard delegate to enable communication between custom keyboard and text fields.
 Referenced from:  (Alex Pilugin, 2016) - https://stackoverflow.com/questions/39677776/xcode-8-swift-3-using-custom-keyboard-extension-with-a-particular-text-field
 */
protocol KeyboardDelegate: class {
    func buttonWasPressed(text: String)
}



class CustomKeyboardConversionViewController: UIViewController {

    
    
    weak var delegate: KeyboardDelegate?
    
//    @IBOutlet weak var keyView: UIScrollView!
    
    var currentString : String = ""
    
    
    @IBOutlet weak var testButtonOutlet: UIButton!
    
    
    @IBAction func testButton(_ sender: Any) {
        
        print("the current string is " + currentString)
        
    }
    
    @IBAction func buttonsClicked(_ sender: UIButton) {
        
        print("the current string is " + currentString)
        
        switch sender.tag{
        
        case 1:
            currentString.append(String(1))
            break
            
        case 2:
            currentString.append(String(2))
            break
        default:
            
            break
        
        }
        
        
        self.delegate?.buttonWasPressed(text: currentString)
        
    
        
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("keyboard controller works")
      
//        keyboardView.keyboardDismissMode = .onDrag

//        keyView.keyboardDismissMode = .onDrag
//        oneButton.backgroundColor = UIColor .systemIndigo
        // Do any additional setup after loading the view.
    }


    
    override func viewDidAppear(_ animated: Bool) {
        
//        testButtonOutlet.addAction(buttonsClicked, for: [])
        
        
        
        //instantiate listeners when the view appears.
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
