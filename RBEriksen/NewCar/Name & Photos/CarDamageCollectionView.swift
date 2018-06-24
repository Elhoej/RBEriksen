//
//  CarDamagePhotosView.swift
//  RBEriksen skabelon
//
//  Created by Simon Elhoej Steinmejer on 16/05/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class CarDamageCollectionView: UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate
{
    let cellId = "cellId"
    var exampleImages = ["car-scratch", "car-window-stone-chip", "car-rim-scratch", "car-interior-damage"]
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout)
    {
        super.init(frame: frame, collectionViewLayout: layout)
        
        dataSource = self
        delegate = self
        indicatorStyle = .white
        
        backgroundColor = .clear
        
        register(CarDamageCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    
//    var displayLink: CADisplayLink?
//
//    @objc func startDisplayLink()
//    {
//        stopDisplayLink()
//
//        let displayLink = CADisplayLink(target: self, selector: #selector(autoScrollView))
//        displayLink.add(to: .main, forMode: .commonModes)
//    }
//
//    func stopDisplayLink()
//    {
//        displayLink?.invalidate()
//        displayLink = nil
//    }
//
//    var xPoint: CGFloat = 0
//
//    @objc func autoScrollView()
//    {
//        let initailPoint = CGPoint(x: xPoint, y: 0)
//
//        if __CGPointEqualToPoint(initailPoint, self.contentOffset)
//        {
//            if xPoint < self.contentSize.width
//            {
//                xPoint += 0.6
//            }
//            else
//            {
//                xPoint = -self.frame.width
//            }
//
//            let offsetPoint = CGPoint(x: xPoint, y: 0)
//            self.contentOffset = offsetPoint
//        }
//        else
//        {
//            xPoint = self.contentOffset.x
//        }
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return DataContainer.shared.carDamagePhotos.isEmpty ? exampleImages.count : DataContainer.shared.carDamagePhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CarDamageCell
        
        if DataContainer.shared.carDamagePhotos.isEmpty
        {
            let imageString = exampleImages[indexPath.item]
            let image = UIImage(named: imageString)
            cell.carDamageImageView.image = image
            cell.exampleLabel.isHidden = false
        }
        else
        {
            let image = DataContainer.shared.carDamagePhotos[indexPath.item]
            cell.carDamageImageView.image = image
            cell.exampleLabel.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 285, height: 185)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
