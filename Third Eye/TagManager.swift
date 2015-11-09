//
//  TagManager.swift
//  Third Eye
//
//  Created by Admin on 10/14/15.
//  Copyright (c) 2015 Admin. All rights reserved.
//

import UIKit
import CoreLocation
import AVFoundation

class TagManager: NSObject {
    
    static let Service = TagManager()
    
     let TAG_KEY = "REGISTEREDTAGS"
     var registedTags=[String : RegisteredTag]()
     var unregisteredTags=[Tag]()

     let userDefaults = NSUserDefaults.standardUserDefaults()
    
     var tagObservers = [ITagObserver]()

    
     var didAlarm: Bool = false;
     var audioPlayer:AVAudioPlayer = AVAudioPlayer()
     let critLock = NSLock()
    
    
    func Initialize()
    {
        
        critLock.lock()
        registedTags.removeAll()

     //   NSUserDefaults.standardUserDefaults().setObject(nil, forKey: self.TAG_KEY)
        
        if let rawTags = NSUserDefaults.standardUserDefaults().objectForKey(self.TAG_KEY) as? NSData {
            registedTags =  NSKeyedUnarchiver.unarchiveObjectWithData(rawTags) as! [String:RegisteredTag]
        }
        critLock.unlock()
    }
    
    
     func RegisterObserver(observer: ITagObserver)
    {
        tagObservers.append(observer)
    }
    
     func UpdateObservers()
    {
      for tag in tagObservers
      {
        tag.UpdateView()
      }
    }
    
     func RemoveAllUnregisteredTags ()
    {
        critLock.lock()
        unregisteredTags.removeAll(keepCapacity: false)
        critLock.unlock()
    }
    
    
    
     func Alarm()
    {
        
//        if (didAlarm)
//        {
//            return
//        }
        
        didAlarm = true
   AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        let path = NSBundle.mainBundle().pathForResource("emergency022", ofType:"mp3")
        let fileURL = NSURL(fileURLWithPath: path!)
//        audioPlayer = AVAudioPlayer(contentsOfURL: fileURL, fileTypeHint: nil)
//        audioPlayer.prepareToPlay()
//      //  audioPlayer.delegate = self
//        audioPlayer.play()
    }

    
     func UpdateTags(beacons: [CLBeacon])
    {
        
    critLock.lock()
        
            for beacon: CLBeacon in beacons {
            if let foundTag = self.GetTagByBeacon(beacon)  {
               // foundTag.distance = beacon.accuracy.
                foundTag.proximity = beacon.proximity
                foundTag.distance = Int(beacon.accuracy)
                
                
                if (foundTag.distance > foundTag.alarmDistance)
                {
                    Alarm()
                }
                
                UpdateObservers()
                
            }
            else
            {
                
                
                if  beacon.proximity == CLProximity.Immediate && !unregisteredTags.contains({t in t.major == beacon.major &&
                    t.minor == beacon.minor &&
                    t.uuid == beacon.proximityUUID} ) {
                        
                        unregisteredTags.append(Tag(beacon: beacon))
                        UpdateObservers()
                }
                else if  beacon.proximity != CLProximity.Immediate && unregisteredTags.contains( {t in t.major == beacon.major &&
                    t.minor == beacon.minor &&
                    t.uuid == beacon.proximityUUID} ) {
                        
                        
                       for (index, t)  in unregisteredTags.enumerate()
                       {
                         if (t.major == beacon.major && t.minor == beacon.minor)
                         {
                            unregisteredTags.removeAtIndex(index)
                            UpdateObservers()
                            break
                          }
                        }
                }
            }

        }
        
        
        critLock.unlock()
    }
    
     func GetTagByIndex(index : Int) -> RegisteredTag
    {
        var regTags = Array(registedTags.values)
        return regTags[index]
    }
        
     func GetTagsByName() -> [RegisteredTag]
    {
        var regTags = Array(registedTags.values)
        
        //sort by name
        regTags.sort({ $0.name > $1.name })
        return regTags

    }
    
     func GetTagByBeacon(beacon: CLBeacon) -> RegisteredTag?
    {
        for (name, registeredTag) in registedTags {
            print("name: \(name)")
            
            if (registeredTag.uuid.UUIDString == beacon.proximityUUID.UUIDString &&
                registeredTag.major == beacon.major &&
                registeredTag.major == beacon.major)
            {
                return registedTags[name]
                break
            }
            
        }
        return nil
    }
    
//    class func GetTagsByDistance() -> [RegisteredTag]
//    {
//        var regTags = Array(registedTags.values)
//        
//        //sort by name
//        regTags.sort({ $0.name > $1.name })
//        return regTags
//        
//    }
    
    
     func AddTag(tag: RegisteredTag)
    {
        critLock.lock()
        registedTags[tag.name!] = tag
        Save()
        
        critLock.unlock()
    }
    
     func DeleteTag(tag: RegisteredTag)
    {
        
        critLock.lock()
            registedTags.removeValueForKey(tag.name!)
            Save()
        critLock.unlock()
    }
    
    
 
    
    func GetTagByName (searchName: String) -> RegisteredTag?
    {
        for (name, registeredTag) in registedTags {
                print ("name: \(name)")
            
            if (name == searchName)
            {
                return registedTags[name]
                break
            }
           
        }
        return nil
    }
    
    private  func Save() {
         let tmpRegistedTags = NSKeyedArchiver.archivedDataWithRootObject(registedTags)
        NSUserDefaults.standardUserDefaults().setObject(tmpRegistedTags, forKey: self.TAG_KEY)
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }

    
}
