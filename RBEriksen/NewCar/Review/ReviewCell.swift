//
//  ReviewCell.swift
//  RBEriksen skabelon
//
//  Created by Simon Elhoej Steinmejer on 19/05/18.
//  Copyright © 2018 Simon Elhoej Steinmejer. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell
{
    let imageTitleLabel: UILabel =
    {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 18)
        label.textColor = .white
        label.sizeToFit()
        
        return label
    }()
    
    let carImageView: ImageViewWithZoom =
    {
        let iv = ImageViewWithZoom(frame: .zero)
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.masksToBounds = true
        iv.layer.cornerRadius = 8
        
        return iv
    }()
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        backgroundColor = .clear
        layer.cornerRadius = 8
        
        addSubview(imageTitleLabel)
        addSubview(carImageView)
        
        imageTitleLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
        carImageView.anchor(top: imageTitleLabel.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 8, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}








