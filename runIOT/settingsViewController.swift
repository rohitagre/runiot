//
//  settingsViewController.swift
//  runIOT
//
//  Created by Apple on 1/28/17.
//  Copyright © 2017 Boomboxninjas. All rights reserved.
//

import UIKit

class settingsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usercred: stylingText!
    @IBOutlet weak var pwd: stylingText!
    @IBOutlet weak var newscroll: UIScrollView!
    
    @IBOutlet weak var save: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        
        usercred.text = UserDefaults.standard.string(forKey: "uname")
        pwd.text = UserDefaults.standard.string(forKey: "pwd")
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saved(_ sender: UIButton) {
        saveCreds()
           }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        newscroll.setContentOffset(CGPoint(x:0,y:90), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        newscroll.setContentOffset(CGPoint(x:0,y:0), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if(usercred == textField){
            usercred.resignFirstResponder()
            pwd.becomeFirstResponder()
        }
        else
        {
            textField.resignFirstResponder()
            saveCreds()
        }
        return true
    }
    func saveCreds() {
        UserDefaults.standard.set(self.usercred.text, forKey: "uname")
        UserDefaults.standard.set(self.pwd.text, forKey: "pwd")
        self.view.endEditing(true)
    }
}
