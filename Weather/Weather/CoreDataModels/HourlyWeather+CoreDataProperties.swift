//
//  HourlyWeather+CoreDataProperties.swift
//  Weather
//
//  Created by Andrey on 21.11.21.
//
//

import Foundation
import CoreData


extension HourlyWeather {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HourlyWeather> {
        return NSFetchRequest<HourlyWeather>(entityName: "HourlyWeather")
    }

    @NSManaged public var currentTemp: String?
    @NSManaged public var hourlyTemp: String?
    @NSManaged public var time: Int64
    @NSManaged public var icon: String?

}

extension HourlyWeather : Identifiable {

}
