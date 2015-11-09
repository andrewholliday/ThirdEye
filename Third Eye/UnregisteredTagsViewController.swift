//
//  UnregisteredTagsViewController.swift
//  Third Eye
//
//  Created by Admin on 10/12/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import UIKit
import CoreLocation



class UnregisteredTagsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {

    var locationManager: CLLocationManager?
    var lastProximity: CLProximity?
    var selectedBeaconIndex = 0
    
    @IBOutlet var tblUnRegisteredTags: UITableView!
    
    @IBOutlet weak var lblSearching: UILabel!
    
    let array = ["item1", "iten2", "item3"]
    var beacons: [CLBeacon]?
    var beaconRegion:CLBeaconRegion?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblUnRegisteredTags.registerClass(UnregisteredTagViewCell.self, forCellReuseIdentifier: "cell")
        
        let uuidString = "8492E75F-4FD6-469D-B132-043FE94921D8"
        let beaconIdentifier = "thirdEye"
        let beaconUUID = NSUUID(UUIDString: uuidString)
        beaconRegion  = CLBeaconRegion(proximityUUID: beaconUUID!, major: 1200, minor: 1000,
            identifier: beaconIdentifier )
        
        locationManager = CLLocationManager()
        
        if(locationManager!.respondsToSelector("requestAlwaysAuthorization")) {
            locationManager!.requestAlwaysAuthorization()
        }
        
        locationManager!.delegate = self
        locationManager!.pausesLocationUpdatesAutomatically = false
        
        locationManager!.startMonitoringForRegion(beaconRegion!)
        locationManager!.startRangingBeaconsInRegion(beaconRegion!)
        locationManager!.startUpdatingLocation()

      //  tblUnRegisteredTags.dataSource = self
       // tblUnRegisteredTags.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(self.beacons != nil) {
            return beacons!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        var cell:UnregisteredTagViewCell = tableView.dequeueReusableCellWithIdentifier("UnregisteredTagViewCell") as! UnregisteredTagViewCell
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("UnregisteredTagViewCell") as! UnregisteredTagViewCell
        
        let beacon:CLBeacon = beacons![indexPath.row]
        
        cell.configure(String(stringInterpolationSegment: beacon.minor))
        
       // cell.textLabel?.text = self.array[indexPath.row]
        
     //   cell.backgroundColor = indexPath.row % 2 == 0 ? UIColor.blueColor() :
      //  UIColor.redColor()
        
        return cell
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        
            //let viewController:ViewController = window!.rootViewController as! ViewController
            //viewController.beacons = beacons as! [CLBeacon]?
            self.beacons = beacons as! [CLBeacon]?
            tblUnRegisteredTags.reloadData()
            
            NSLog("didRangeBeacons");
            var message:String = ""
            
            if(beacons.count > 0) {
                
                //let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
                
                let nearestBeacon:CLBeacon = beacons[0] as! CLBeacon
                
              //  manager.startRangingBeaconsInRegion(nearestBeacon)

                
//                if(nearestBeacon.proximity == lastProximity ||
//                    nearestBeacon.proximity == CLProximity.Unknown) {
//                        return;
//                }
                lastProximity = nearestBeacon.proximity;
                
                
                NSLog("%d", nearestBeacon.accuracy)
                
                switch nearestBeacon.proximity {
                case CLProximity.Far:
                    message = "Proximity: Far"
                case CLProximity.Near:
                    message = "Proximity: Near"
                case CLProximity.Immediate:
                    message = "Proximity: Immediate"
                case CLProximity.Unknown:
                    return
                }
            } else {
                message = "No beacons"
            }
            
            NSLog("%@", message)
         //   beaconNotificationMessage(message)
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
//        self.selectedBeaconIndex = indexPath.row
//        
//        self.performSegueWithIdentifier("DetailsViewID", sender: self)
//        
//        let row = indexPath.row
        print(array[indexPath.row])
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!)
        
    {
        
        if segue.identifier == "DetailsViewID"
            
        {
            let detailsViewController = segue.destinationViewController as? RegisterViewController
      //     detailsViewController!.SelectedBeacon  = beacons![selectedBeaconIndex]
            
        }
        
        locationManager!.stopMonitoringForRegion(beaconRegion!)
        locationManager!.startRangingBeaconsInRegion(beaconRegion!)
        locationManager!.startUpdatingLocation()
        
        
    }

    
    
}


class UnregisteredTagViewCell:UITableViewCell {
    
    
    @IBOutlet weak var lblCode: UILabel!
    //    @IBOutlet weak var lblMinor: UILabel!
    //

    //
    //    @IBOutlet weak var btnRegister: UIButton!
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
        func configure(code:String) {
    
     lblCode.text = code

        }
    
    required init(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)!
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
}
