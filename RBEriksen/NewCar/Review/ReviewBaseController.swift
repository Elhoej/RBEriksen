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
            cv.titleStringArray = ["Højre forhjuls bremseskive", "Venstre forhjuls bremseskive", "Venstre baghjuls bremseskive", "Højre baghjuls bremseskive"]
            
            return cv
    }()
    
    lazy var carMiscImagesCollectionView: ReviewCollectionView =
        {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            
            let cv = ReviewCollectionView(frame: .zero, collectionViewLayout: layout)
            let array = DataContainer.shared.carMiscPhotos
            cv.photosArray = array
            cv.titleStringArray = ["Interiøret foran", "Interiøret bagi", "Antal kilometer kørt", "Servicebog"]
            
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
                carDamageStrings.append("Skade \(index + 1)")
            }
            
            cv.titleStringArray = carDamageStrings
            
            return cv
    }()
    
    let wheelPatternLabel: UILabel =
    {
        let label = UILabel()
        label.text = "Dækmønster mål"
        label.font = UIFont(name: "Montserrat-Regular", size: 32)
        label.textColor = .white
        label.sizeToFit()
        
        return label
    }()
    
    let frontWheelPatternLabel: UILabel =
    {
        let label = UILabel()
        label.text = "Forhjul"
        label.font = UIFont(name: "Montserrat-Regular", size: 18)
        label.textColor = .white
        label.sizeToFit()
        
        return label
    }()
    
    let frontWheelPatternValueLabel: UILabel =
    {
        let label = UILabel()
        label.text = DataContainer.shared.frontWheelPatternMeasurement?.toString()
        label.font = UIFont(name: "Montserrat-Regular", size: 32)
        label.textColor = .white
        label.sizeToFit()
        
        return label
    }()
    
    let backWheelPatternLabel: UILabel =
    {
        let label = UILabel()
        label.text = "Baghjul"
        label.font = UIFont(name: "Montserrat-Regular", size: 18)
        label.textColor = .white
        label.sizeToFit()
        
        return label
    }()
    
    let backWheelPatternValueLabel: UILabel =
    {
        let label = UILabel()
        label.text = DataContainer.shared.backWheelPatternMeasurement?.toString()
        label.font = UIFont(name: "Montserrat-Regular", size: 32)
        label.textColor = .white
        label.sizeToFit()
        
        return label
    }()
    
    let frostEffect: UIVisualEffectView =
    {
        let frost = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        frost.autoresizingMask = .flexibleWidth
        
        return frost
    }()
    
}






















