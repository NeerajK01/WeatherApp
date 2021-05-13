//
//  SettingVC.swift
//  WeatherApp
//
//  Created by Parveen kumar on 31/10/2019 .
//

import UIKit

class SettingVC: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userNameBTN: UIButton!
    @IBOutlet weak var fehrenheitSwitch: UISwitch!
    
    @IBOutlet weak var celciusSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userNameBTN.layer.masksToBounds = true
        self.userNameBTN.layer.cornerRadius = self.userNameBTN.frame.height * 0.20
        
        celciusSwitch.setOn(true, animated: true)
        fehrenheitSwitch.setOn(false, animated: true)
        
    }
    
    @IBAction func submitUsernameAction(_ sender: Any) {
        if let username = self.userNameTextField.text{
            UserDefaults.standard.set(username, forKey: "username")
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userNameUpdate"), object: nil, userInfo: nil)
        }
    }
    
    @IBAction func fehrenheitAction(_ sender: Any) {
        if((sender as AnyObject).isOn == true){
            celciusSwitch.setOn(false, animated: true)
            Constant.shared.celcius = false
        }else{
            celciusSwitch.setOn(true, animated: true)
            Constant.shared.celcius = true
        }
    }
    
    @IBAction func celciusAction(_ sender: Any) {
        if((sender as AnyObject).isOn == true){
            fehrenheitSwitch.setOn(false, animated: true)
            Constant.shared.celcius = true
        }else{
            fehrenheitSwitch.setOn(true, animated: true)
            Constant.shared.celcius = false
        }
    }
    
}
