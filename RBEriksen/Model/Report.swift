//
//  Report.swift
//  RBEriksen skabelon
//
//  Created by Simon Elhoej Steinmejer on 11/05/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class Report: NSObject
{
    var carBrand: String?
    var carSeries: String?
    var frontWheelPatternMeasurement: String?
    var backWheelPatternMeasurement: String?
//    var backLeftBrakeDiscMeasurement: String?
//    var backRightBrakeDiscMeasurement: String?
//    var frontRightBrakeDiscMeasurement: String?
//    var frontLeftBrakeDiscMeasurement: String?
    var timestamp: NSNumber?
    var carDamagePhotos: [String: String]?
    var carPhotos: [String: String]?
    var carWheelPhotos: [String: String]?
    var carBrakeDiscPhotos: [String: String]?
    var carMiscPhotos: [String: String]?
    
    init(dictionary: [String: Any])
    {
        self.carBrand = dictionary["carBrand"] as? String
        self.carSeries = dictionary["carSeries"] as? String
        self.frontWheelPatternMeasurement = dictionary["frontWheelPatternMeasurement"] as? String
        self.backWheelPatternMeasurement = dictionary["backWheelPatternMeasurement"] as? String
//        self.backLeftBrakeDiscMeasurement = dictionary["backLeftBrakeDiscMeasurement"] as? String
//        self.backRightBrakeDiscMeasurement = dictionary["backRightBrakeDiscMeasurement"] as? String
//        self.frontRightBrakeDiscMeasurement = dictionary["frontRightBrakeDiscMeasurement"] as? String
//        self.frontLeftBrakeDiscMeasurement = dictionary["frontLeftBrakeDiscMeasurement"] as? String
        self.timestamp = dictionary["timestamp"] as? NSNumber
        self.carDamagePhotos = dictionary["carDamagePhotos"] as? [String: String]
        self.carPhotos = dictionary["carPhotos"] as? [String: String]
        self.carWheelPhotos = dictionary["carWheelPhotos"] as? [String: String]
        self.carBrakeDiscPhotos = dictionary["carBrakeDiscPhotos"] as? [String : String]
        self.carMiscPhotos = dictionary["carMiscPhotos"] as? [String: String]
        
    }
}












