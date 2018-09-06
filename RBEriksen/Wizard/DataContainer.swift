//
//  DataContainer.swift
//  RBEriksen skabelon
//
//  Created by Simon Elhoej Steinmejer on 10/05/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class DataContainer
{
    static let shared = DataContainer()
    
    var carBrand: String?
    var carSeries: String?
    
    var frontWheelPatternMeasurement: String?
    var backWheelPatternMeasurement: String?
    var backBrakeDiscMeasurement: String?
    var frontBrakeDiscMeasurement: String?
    var serviceKilometers: String?
    var serviceDays: String?
    
    var carPhotos = [UIImage]()
    var carDamagePhotos = [UIImage]()
    var carWheelPhotos = [UIImage]()
    var carBrakeDiscPhotos = [UIImage]()
    var carMiscPhotos = [UIImage]()
    
    func resetAllVariables()
    {
        self.carPhotos.removeAll()
        self.carDamagePhotos.removeAll()
        self.carWheelPhotos.removeAll()
        self.carMiscPhotos.removeAll()
        self.carBrakeDiscPhotos.removeAll()
        
        self.carBrand = nil
        self.carSeries = nil
        self.frontWheelPatternMeasurement = nil
        self.backWheelPatternMeasurement = nil
        self.backBrakeDiscMeasurement = nil
        self.frontBrakeDiscMeasurement = nil
        self.serviceDays = nil
        self.serviceKilometers = nil
    }
}

















