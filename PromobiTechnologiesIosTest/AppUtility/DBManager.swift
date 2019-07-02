//
//  DBManager.swift
//  PromobiTechnologiesIosTest
//
//  Created by Kondya on 02/07/19.
//  Copyright © 2019 Fortune4. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DBManager {
    class var shared: DBManager {
        struct Static {
            static let instance: DBManager = DBManager()
        }
        return Static.instance
    }
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    func saveModelInDatabase(lattitude: String?, longitude: String?, battery: Float, cpuusages: String?,datetime: Date?)  {
        
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "LocationInfo", in: context)
        let locationInfo = NSManagedObject(entity: entity!, insertInto: context)
        locationInfo.setValue(lattitude, forKey: "lattitude")
        locationInfo.setValue(longitude, forKey: "longitude")
        locationInfo.setValue(battery, forKey: "battery")
        locationInfo.setValue(cpuusages, forKey: "cpuusages")
        locationInfo.setValue(datetime, forKey: "datetime")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func getAllLocationFromDataBase(_ completion: @escaping ([LocationInfo]) -> ())  {
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LocationInfo")
        do {
            var result = try context.fetch(request)
            result.reverse()
            if let locationInfoDataArray = result as? [LocationInfo] {
                
               completion(locationInfoDataArray)
                
            }
        } catch {
            completion([])
            print("Failed")
        }
        
    }
    
    func deleteAllLocationFromDataBase()  {
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "LocationInfo")
        do {
            let result = try context.fetch(request)
            for object in result {
                context.delete(object as! NSManagedObject)
            }
           
        } catch {
           
        }
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
    }
    
}
