//
//  ReviewBaseController.swift
//  RBEriksen skabelon
//
//  Created by Simon Elhoej Steinmejer on 10/05/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class ReviewBaseController: UIViewController
{
    let carBrandAndSeriesLabel: UILabel =
    {
        let label = UILabel()
        label.text = "\(DataContainer.shared.carBrand ?? "Car Brand"), \(DataContainer.shared.carSeries ?? "Car Series")"
        label.font = UIFont(name: "Montserrat-Regular", size: 36)
        label.textColor = .white
        label.sizeToFit()
        
        return label
    }()
    
    lazy var carImagesCollectionView: ReviewCollectionView =
        {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            
            let cv = ReviewCollectionView(frame: .zero, collectionViewLayout: layout)
            
            let array = DataContainer.shared.carPhotos
            cv.photosArray = array
            cv.titleStringArray = ["Bilen forfra", "Bilens venstre side", "Bilen bagfra", "Bilens højre side"]
            
            return cv
    }()
    
    lazy var carWheelImagesCollectionView: ReviewCollectionView =
        {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            
            let cv = ReviewCollectionView(frame: .zero, collectionViewLayout: layout)
            let array = DataContainer.shared.carWheelPhotos
            cv.photosArray = array
            cv.titleStringArray = ["Højre fordæk", "Venstre fordæk", "Venstre bagdæk", "Højre bagdæk"]
            
            return cv
    }()
    
    lazy var carBrakeDiscImagesCollectionView: ReviewCollectionView =
        {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            
            let cv = ReviewCollectionView(frame: .zero, collectionViewLayout: layout)
            let array = DataContainer.shared.carBrakeDiscPhotos
            cv.photosArray = array
            cv.titleStringArray = ["Højre forhjulsbremseskive", "Venstre forhjulsbremseskive", "Venstre baghjulsbremseskive", "Højre baghjulsbremseskive"]
            
            return cv
    }()
    
    lazy var carMiscImagesCollectionView: ReviewCollectionView =
        {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            
            let cv = ReviewCollectionView(frame: .zero, collectionViewLayout: layout)
            let array = DataContainer.shared.carMiscPhotos
            cv.photosArray = array
            cv.titleStringArray = ["Interiøret foran", "Interiøret bagi", "Kilometerstand", "Servicebog"]
            
            return cv
    }()
    
    lazy var carDamageImagesCollectionView: ReviewCollectionView =
        {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            
            let cv = ReviewCollectionView(frame: .zero, collectionViewLayout: layout)
            let array = DataContainer.shared.carDamagePhotos
            cv.photosArray = array
            
            var carDamageStrings = [String]()
            
            for (index, _) in DataContainer.shared.carDamagePhotos.enumerated()
            {
                carDamageStrings.append("Kosmetisk bemærkning \(index + 1)")
            }
            
            cv.titleStringArray = carDamageStrings
            
            return cv
    }()
    
    let wheelContainerView: ContainerView =
    {
        let cv = ContainerView(title: "Dækmønster", subTitle1: "Forhjul", value1: DataContainer.shared.frontWheelPatternMeasurement ?? "", subTitle2: "Baghjul", value2: DataContainer.shared.backWheelPatternMeasurement ?? "")
        
        return cv
    }()
    
    let brakeDiscContainerView: ContainerView =
    {
        let cv = ContainerView(title: "Stand på\nbremser", subTitle1: "Bremser for", value1: DataContainer.shared.frontBrakeDiscMeasurement ?? "", subTitle2: "Bremser bag", value2: DataContainer.shared.backBrakeDiscMeasurement ?? "")
        
        return cv
    }()
    
    let serviceContainerView: ContainerView =
    {
        let cv = ContainerView(title: "Næste service", subTitle1: "Kilometer", value1: DataContainer.shared.serviceKilometers ?? "", subTitle2: "Dage", value2: DataContainer.shared.serviceDays ?? "")
        
        return cv
    }()
    
    let frostEffect: UIVisualEffectView =
    {
        let frost = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        frost.autoresizingMask = .flexibleWidth
        
        return frost
    }()

}






















