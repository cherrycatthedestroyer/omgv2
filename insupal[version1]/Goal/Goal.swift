//  CMPT 276 Project Group 12 - Smart Apps
//  tempGoalClass.swift
//
//
//  Created by Stanislaw Kalinowski on 2018-07-03.
//  Copyright © 2018 Stanislaw Kalinowski. All rights reserved.
//
// Goal Model class for the goal table view


import Foundation
import os.log


class Goal: NSObject, NSCoding {
    
    //Class Variable Declerations
    private var goalDescription:String
    private var specifics:String
    
    private var Due:String
    private var alertType:Int;
    
    //Mark Types
    
    struct PropertyKey{
        
        static let description = "description"
        static let specifics = "specifics"
        static let due = "due"
        static let alertType = "alert"
        
    }
    
    //Mark Archive Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("goals")
    
    //Initializer
    init?(goalDescription:String, specifics:String, due:String, alertType:Int){
        
        //if no goalDescription or no due then return nil
        if( goalDescription.isEmpty){
            return nil
        }
        
        self.goalDescription = goalDescription
        self.specifics = specifics
        self.Due = due
        self.alertType = alertType
        
        
    }
    
    //Getters
    func getDescription()->String { return self.goalDescription }
    func getSpecifics()->String {return self.specifics}
    func getDue()->String { return self.Due}
    func getalertType()->Int {return self.alertType}
    
    //Setters
    func setDescription(goal:String){self.goalDescription = goal}
    func setSpecifics(specifics:String){self.specifics = specifics}
    func setDue(dueDate:String){self.Due = dueDate}
    func setAlertType(alertType:Int){self.alertType = alertType}
    
    //Mark: NSCoding
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(goalDescription, forKey:PropertyKey.description)
        aCoder.encode(specifics, forKey:PropertyKey.specifics)
        aCoder.encode(Due, forKey:PropertyKey.due)
        print(alertType)
        aCoder.encode(alertType, forKey:PropertyKey.alertType)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        // The goalDescription is required. If we cannot decode a descirption string, the initializer should fail.
        guard let goalDescription = aDecoder.decodeObject(forKey: PropertyKey.description) as? String else {
            os_log("Unable to decode goal description.", log: OSLog.default, type: .debug)
            return nil
        }
        //Due date is also required
        guard let Due = aDecoder.decodeObject(forKey: PropertyKey.due) as? String else {
            os_log("Unable to decode due date.", log: OSLog.default, type: .debug)
            return nil
        }
        
        //Specifics not required
        let specifics = aDecoder.decodeObject(forKey: PropertyKey.specifics) as? String
        
        //Alert type not required
        //let alertType = aDecoder.decodeObject(forKey: PropertyKey.alertType) as? Int
        
        let alertType = 0
        // Must call designated initializer.
        self.init(goalDescription:goalDescription, specifics:specifics!, due:Due, alertType:alertType)
        
        
    }
    
}




