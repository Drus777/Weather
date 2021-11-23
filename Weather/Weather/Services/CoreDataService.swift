//
//  CoreDataService.swift
//  Weather
//
//  Created by Andrey on 21.11.21.
//

import Foundation
import CoreData

final class CoreDataService {
  
  static let shared = CoreDataService()
  
  lazy var managedObjectContext: NSManagedObjectContext = {
    return persistentContainer.viewContext
  }()
  
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "CoreDataModelWeather")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  func saveContext() {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
}
