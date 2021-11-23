//
//  DailyWeather+CoreDataProperties.swift
//  Weather
//
//  Created by Andrey on 21.11.21.
//
//

import Foundation
import CoreData


extension DailyWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DailyWeather> {
        return NSFetchRequest<DailyWeather>(entityName: "DailyWeather")
    }

    @NSManaged public var day: Int64
    @NSManaged public var icon: String?
    @NSManaged public var minTemp: String?
    @NSManaged public var maxTemp: String?

}

extension DailyWeather : Identifiable {

}
