//
//  centerViewController.swift
//  runIOT
//
//  Created by Apple on 1/28/17.
//  Copyright © 2017 Boomboxninjas. All rights reserved.
//

import UIKit
import Moscapsule
import Foundation
class centerViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var firebtn: UICollectionView!
    
    @IBOutlet weak var constat: UILabel!
    
    let mqttConfig = MQTTConfig(clientId: removeSpecialCharsFromString(text: UIDevice.current.name), host: "m20.cloudmqtt.com", port: 15905, keepAlive: 90)
    var handle:Timer? = nil
    var mqttClient: MQTTClient? = nil
    
    let reuseIdentifier = "collCell" // also enter this string as the cell identifier in the storyboard
    var items = ["Porch Light", "Fan", "Study Light", "Other"]
    var stateflag = ["t","t","t","t"]
    var initial = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.firebtn!.dataSource = self // dataSource delegate
        self.firebtn!.delegate = self
        //set Configuration
        
        mqttConfig.onConnectCallback = { returnCode in
            print("\n\n\nconnection status")
            print("\(returnCode.description)")
            if(returnCode.description.lowercased() == "success")
            {
                DispatchQueue.main.async {
                    
                    self.constat.textColor = UIColor.hxc(hex: "#2ecc71")
                    
                }
            }
            else
            {
                DispatchQueue.main.async {
                    self.constat.textColor = UIColor.hxc(hex: "#e74c3c")
                    
                }
                self.mqttClient?.disconnect()
                
            }
            //print("\n\n\n")
        }
        
        mqttConfig.onMessageCallback = { mqttMessage in
            let receivedMessage:String = mqttMessage.payloadString!
            
            if(self.initial) {
                self.stateflag = receivedMessage.lowercased().characters.map { String($0) }
                self.initial = !self.initial
            }
            for i in  0..<self.items.count {
                self.updatecellState(i: i)
            }
            
            
            print("\n\n\nfrom server msg = \(receivedMessage)")
            
        }
        
        if(UserDefaults.standard.string(forKey: "uname") != nil){
            
            mqttConfig.mqttAuthOpts = MQTTAuthOpts(username: UserDefaults.standard.string(forKey: "uname")!, password: UserDefaults.standard.string(forKey: "pwd")!)
            mqttClient = MQTT.newConnection(mqttConfig, connectImmediately: false)
            
            mqttClient?.disconnect()
            mqttClient?.connectTo(host: "m20.cloudmqtt.com", port: 15905, keepAlive: 60)
            mqttClient?.subscribe("/ijammer99/inTopic", qos: 1)
            print(mqttClient.debugDescription)
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillDisappear(_ animated: Bool){
        mqttClient?.disconnect()
    }
    
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! collCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.targetx.text = self.items[indexPath.item]
        cell.backgroundColor = UIColor.hxc(hex: "#2980b9") // make cell more visible in our example project
        
        return cell
    }
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        
        
        if(self.handle != nil)
        {
            self.handle?.invalidate()
        }
        
        if(self.stateflag[indexPath.item] == "f"){
            self.stateflag[indexPath.item] = "t"
        }
        else{
            self.stateflag[indexPath.item] = "f"
        }
        let str:String = self.stateflag.joined(separator: "")
        
        if(mqttClient?.isConnected == true){
            self.handle = setTimeout(delay: 0.7, block: { () -> Void in
                self.mqttClient?.publish(string: str, topic: "/ijammer99/inTopic", qos: 1, retain: true)
            })
        }
        
        
        updatecellState(i: indexPath.item)
        
        print("You selected cell #\(indexPath.item)!")
        print("array data \(stateflag)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        return CGSize(width: screenWidth - 50, height: screenWidth/3)
    }
    
    func updatecellState(i:Int)
    {
        let cell = self.firebtn.cellForItem(at: IndexPath.init(row: i, section: 0)) as! collCollectionViewCell
        
        if(self.stateflag[i] == "t")
        {
            DispatchQueue.main.async {
                
                cell.cellstate.text = "on"
                cell.backgroundColor = UIColor.hxc(hex: "#e67e22")
            }
        }
        else
        {
            DispatchQueue.main.async {
                
                cell.cellstate.text = "off"
                cell.backgroundColor = UIColor.hxc(hex: "#2980b9")
            }
        }
        
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("\n\n\n\n\ncleanup\n\n")
        moscapsule_cleanup()
    }
    
}
