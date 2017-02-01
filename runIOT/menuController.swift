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
        //let cell:menuTableViewCell = tableView.cellForRow(at: indexPath) as! menuTableViewCell
        //let bgColorView = UIView()
        //bgColorView.backgroundColor = UIColor.hxc(hex: "#2980b9")
        //cell.selectedBackgroundView = bgColorView
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.textLabel?.text = menuitems[indexPath.row]
        cell?.textLabel?.textColor = UIColor.hxc(hex: "#333333")


        
        switch(indexPath.row)
        {
            
        case 0:
            
            let centerViewController = self.storyboard?.instantiateViewController(withIdentifier:"centerViewController") as! centerViewController
            let centerNavController = UINavigationController(rootViewController: centerViewController)
            let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.centerContainer!.centerViewController = centerNavController
            appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
            break;
            
        case 1:
            
            let centerViewController = self.storyboard?.instantiateViewController(withIdentifier:"settingsViewController") as! settingsViewController
            let centerNavController = UINavigationController(rootViewController: centerViewController)
            let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.centerContainer!.centerViewController = centerNavController
            appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
            break;
            
        case 2:
            let centerViewController = self.storyboard?.instantiateViewController(withIdentifier:"aboutViewController") as! aboutViewController
            let centerNavController = UINavigationController(rootViewController: centerViewController)
            let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.centerContainer!.centerViewController = centerNavController
            appDelegate.centerContainer!.toggle(MMDrawerSide.left, animated: true, completion: nil)
            break;
            
        default:
            print("\(menuitems[indexPath.row]) is selected");
            break;
            
            
        }
    }
    public func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath)
    {
        //let cell = tableView.cellForRow(at: indexPath)
        ////cell?.contentView.backgroundColor = UIColor.hxc(hex: "#2980b9")
        //cell?.backgroundColor = UIColor.hxc(hex: "#2980b9")
    }
    
    public func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath)
    {
       // let cell = tableView.cellForRow(at: indexPath)
        //cell?.contentView.backgroundColor = UIColor.orange
       	//	 cell?.backgroundColor = UIColor.orange
    }
    public func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.textLabel?.text = menuitems[indexPath.row]
        cell?.textLabel?.textColor = UIColor.hxc(hex: "#ffffff")    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
