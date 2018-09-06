//
//  ReviewCollectionView.swift
//  RBEriksen skabelon
//
//  Created by Simon Elhoej Steinmejer on 19/05/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class ReviewCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    let cellId = "cellId"
    var timer: Timer?
    var photosArray = [UIImage]()
    {
        didSet
        {
            attemptReloadOfTable()
        }
    }
    var titleStringArray: [String]?
    {
        didSet
        {
            attemptReloadOfTable()
        }
    }
    
    var photoUrlArray = [String]()
    {
        didSet
        {
            attemptReloadOfTable()
        }
    }
    
    private func attemptReloadOfTable()
    {
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.handleReloadTable), userInfo: nil, repeats: false)
    }
    
    @objc func handleReloadTable()
    {
        DispatchQueue.main.async(execute:
            {
                self.reloadData()
        })
    }
    
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout)
    {
        super.init(frame: frame, collectionViewLayout: layout)
        backgroundColor = .clear
        
        delegate = self
        dataSource = self
        
        showsHorizontalScrollIndicator = false
        
        register(ReviewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return photosArray.isEmpty ? photoUrlArray.count : photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ReviewCell
        
        cell.layer.zPosition = CGFloat(-indexPath.item)
        
        if !photosArray.isEmpty
        {
            let image = photosArray[indexPath.item]
            cell.carImageView.image = image
        }
        else
        {
            let url = photoUrlArray[indexPath.item]
            cell.carImageView.loadImageUsingCacheWithUrlString(url)
        }
        
        let title = titleStringArray?[indexPath.item]
        cell.imageTitleLabel.text = title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: 270, height: 220)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}






















