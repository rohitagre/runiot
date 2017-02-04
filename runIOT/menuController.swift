//
//  menuController.swift
//  runIOT
//
//  Created by Apple on 1/28/17.
//  Copyright © 2017 Boomboxninjas. All rights reserved.
//

import UIKit

class menuController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var menuitems: [String] = ["Home","Settings","About"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return menuitems.count;
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let mycell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! menuTableViewCell
        mycell.textLabel?.text = menuitems[indexPath.row]
        mycell.textLabel?.textColor = UIColor.white
        return mycell;
    }
    
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size:17)
        
        
        let ad:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        
        switch(indexPath.row)
        {
            
        case 0:
            
            let cv = self.storyboard?.instantiateViewController(withIdentifier:"centerViewController") as! centerViewController
            let cn = UINavigationController(rootViewController: cv)
            ad.centerContainer!.centerViewController = cn
            ad.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
            break;
            
        case 1:
            
            let sv = self.storyboard?.instantiateViewController(withIdentifier:"settingsViewController") as! settingsViewController
            let cn = UINavigationController(rootViewController: sv)
            ad.centerContainer!.centerViewController = cn
            ad.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
            break;
            
        case 2:
            let av = self.storyboard?.instantiateViewController(withIdentifier:"aboutViewController") as! aboutViewController
            let cn = UINavigationController(rootViewController: av)
            ad.centerContainer!.centerViewController = cn
            ad.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
            break;
            
        default:
            print("\(menuitems[indexPath.row]) is selected");
            break;
            
            
        }
    }
    
    public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.textLabel?.font = UIFont(name: "HelveticaNeue-Thin", size:17)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
