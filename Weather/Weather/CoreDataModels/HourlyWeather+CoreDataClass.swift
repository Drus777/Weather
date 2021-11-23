//
//  HourlyWeather+CoreDataClass.swift
//  Weather
//
//  Created by Andrey on 21.11.21.
//
//

import Foundation
import CoreData


public class HourlyWeather: NSManagedObject {

  convenience init?(moc: NSManagedObjectContext) {
      if let entity = NSEntityDescription.entity(forEntityName: "HourlyWeather",
                                                 in: moc) {
          self.init(entity: entity, insertInto: moc)
      } else {
          return nil
      }
  }
  
}
