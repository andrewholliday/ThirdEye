//
//  RegisterViewController.swift
//  Third Eye
//
//  Created by Admin on 10/8/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import UIKit
import CoreLocation

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var sldDistance: UISlider!
    @IBOutlet weak var txtChildName: UITextField!
    
    @IBOutlet weak var lblMajor: UILabel!
    @IBOutlet weak var lblMinor: UILabel!
    
    @IBOutlet weak var lblDistance: UILabel!
    
    
    var SelectedTag:Tag?
    
    
//     required init(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//       // fatalError("init(coder:) has not been implemented")
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lblDistance.text = "5"
        sldDistance.value = 5
        lblMajor.text = String(SelectedTag!.major)
        lblMinor.text = String(SelectedTag!.minor)
        txtChildName.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resousrces that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        txtChildName.resignFirstResponder()
        return true;
    }

    @IBAction func onDistanceChanged(sender: UISlider) {
        lblDistance.text = String(Int(sender.value))
    }
    
    @IBAction func onRegisterChildClick(sender: AnyObject) {
//
//        var b = Tag(uuid: self.SelectedBeacon.proximityUUID,
//            major: Int(self.SelectedBeacon.major),
//            minor: Int(self.SelectedBeacon.minor))
        
        
        var newTag = RegisteredTag(name: txtChildName.text!,
                                  alarmDistance: Int(sldDistance.value),
            uuid: self.SelectedTag!.uuid, major: self.SelectedTag!.major, minor: self.SelectedTag!.minor)
        
        TagManager.Service.AddTag(newTag)
        
        performSegueWithIdentifier("RegisteredTagSegue", sender: sender)
       
        
    }


}
