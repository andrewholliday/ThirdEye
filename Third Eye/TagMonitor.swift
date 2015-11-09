//
//  BeaconService.swift
//  ConventionTour
//
//  Created by Admin on 10/28/15.
//  Copyright © 2015 Admin. All rights reserved.
//

import Foundation
import CoreLocation

class TagMonitor: NSObject, CLLocationManagerDelegate
{
    
    static let Service = TagMonitor()
    var locationManager: CLLocationManager?
    var beaconRegion:CLBeaconRegion?

    func StartMonitor()
    {
        
        let uuidString = "FDA50693-A4E2-4FB1-AFCF-C6EB07647825"// "8492E75F-4FD6-469D-B132-043FE94921D8"
        let beaconIdentifier = "thirdEye"
        let beaconUUID = NSUUID(UUIDString: uuidString)
        beaconRegion  = CLBeaconRegion(proximityUUID: beaconUUID!,
            //major: 1200, minor: 1000,
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
    }
    
    func StopMonitor()
    {
        locationManager!.stopMonitoringForRegion(beaconRegion!)
        locationManager!.stopRangingBeaconsInRegion(beaconRegion!)
        locationManager!.stopUpdatingLocation()
    }
    
    
    func locationManager(manager: CLLocationManager, didEnterRegion region: CLRegion) {
        locationManager!.startRangingBeaconsInRegion(beaconRegion!)
        
        NSLog("%@", "Did enter region1111")
    }
    
    func locationManager(manager: CLLocationManager, didExitRegion region: CLRegion) {
        locationManager!.stopRangingBeaconsInRegion(beaconRegion!)
        
        NSLog("%@", "Did Exit region")
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
    
        
        //  NSLog("didRangeBeacons");
        var message:String = ""
        
        if(beacons.count > 0) {
            
            //update all found beacons
                 TagManager.Service.UpdateTags(beacons as! [CLBeacon])
            
            //let knownBeacons = beacons.filter{ $0.proximity != CLProximity.Unknown }
            
            let nearestBeacon:CLBeacon = beacons[0] as! CLBeacon
            
            //  manager.startRangingBeaconsInRegion(nearestBeacon)
            
            
            //                if(nearestBeacon.proximity == lastProximity ||
            //                    nearestBeacon.proximity == CLProximity.Unknown) {
            //                        return;
            //                }
            //  lastProximity = nearestBeacon.proximity;
            
            
            NSLog("%.02f", nearestBeacon.accuracy)
            
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
    
    
    
}


